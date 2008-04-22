/***************************************************************
 *
 * OpenBeacon.org - main entry, CRC, behaviour
 *
 * Copyright 2006 Milosch Meriac <meriac@openbeacon.de>
 *
/***************************************************************

/*
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; version 2.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

*/

#define OPENBEACON_ENABLEENCODE

#include <htc.h>
#include <stdlib.h>
#include "config.h"
#include "timer.h"
#include "xxtea.h"
#include "nRF_CMD.h"
#include "nRF_HW.h"
#include "main.h"

__CONFIG (0x03d4);
__EEPROM_DATA (0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
__EEPROM_DATA (0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);

static const u_int32_t oid=CONFIG_GENERATED_TAG_ID;
u_int32_t bank1 seq=0x12345678;
static u_int16_t code_block;
static char current_sector_vote;

TMacroBeacon g_MacroBeacon = {
  0x02,				// Size
  RF_SETUP | WRITE_REG,		// Setup RF Options
  RFB_RFOPTIONS,

  0x02,				// Size
  RF_CH | WRITE_REG,		// Setup RF Channel
  CONFIG_DEFAULT_CHANNEL,

  sizeof (TBeaconEnvelope) + 1,	// Size
  //W_TX_PAYLOAD_NOACK	        // Transmit Packet Opcode (newfangled)
  WR_TX_PLOAD                   // Transmit Packet Opcode
};

unsigned long
htonl (unsigned long src)
{
  unsigned long res;

  ((unsigned char *) &res)[0] = ((unsigned char *) &src)[3];
  ((unsigned char *) &res)[1] = ((unsigned char *) &src)[2];
  ((unsigned char *) &res)[2] = ((unsigned char *) &src)[1];
  ((unsigned char *) &res)[3] = ((unsigned char *) &src)[0];

  return res;
}

unsigned short
htons (unsigned short src)
{
  unsigned short res;

  ((unsigned char *) &res)[0] = ((unsigned char *) &src)[1];
  ((unsigned char *) &res)[1] = ((unsigned char *) &src)[0];

  return res;
}

#define SHUFFLE(a,b) 	tmp=g_MacroBeacon.env.datab[a];\
			g_MacroBeacon.env.datab[a]=g_MacroBeacon.env.datab[b];\
			g_MacroBeacon.env.datab[b]=tmp;

void
shuffle_tx_byteorder (void)
{
  unsigned char tmp;

  SHUFFLE (0 +  0, 3 +  0);
  SHUFFLE (1 +  0, 2 +  0);
  SHUFFLE (0 +  4, 3 +  4);
  SHUFFLE (1 +  4, 2 +  4);
  SHUFFLE (0 +  8, 3 +  8);
  SHUFFLE (1 +  8, 2 +  8);
  SHUFFLE (0 + 12, 3 + 12);
  SHUFFLE (1 + 12, 2 + 12);
}

unsigned short
crc16 (const unsigned char *buffer, unsigned char size)
{
  unsigned short crc = 0xFFFF;
  if (buffer)
    {
      while (size--)
	{
	  crc = (crc >> 8) | (crc << 8);
	  crc ^= *buffer++;
	  crc ^= ((unsigned char) crc) >> 4;
	  crc ^= crc << 12;
	  crc ^= (crc & 0xFF) << 5;
	}
    }
  return crc;
}

void
store_codeblock (u_int16_t code_block)
{
  EEPROM_WRITE (8, (u_int8_t) (code_block));
  msleep (10);
  EEPROM_WRITE (9, (u_int8_t) (code_block >> 8));
  msleep (10);
}

void blink(unsigned short time_jiffies)
{
      CONFIG_PIN_LED = 1;
      sleep_jiffies(5*TIMER1_JIFFIES_PER_MS);
      CONFIG_PIN_LED = 0;
      sleep_jiffies(time_jiffies - 5*TIMER1_JIFFIES_PER_MS);
}

void
main (void)
{
  u_int8_t i, status;
  u_int16_t crc;
  
  current_vote = current_sector_vote = 0;

  timer1_init ();
  nRFCMD_Init ();
  
  for (i = 0; i <= 20; i++)
  {
    CONFIG_PIN_LED = i & 1;
    msleep (100);
  }
  
  IOCA = IOCA | (1<<0);

  // increment code block after power cycle
  ((unsigned char *) &crc)[0] = EEPROM_READ (8);
  ((unsigned char *) &crc)[1] = EEPROM_READ (9);
  store_codeblock (++crc);

  seq ^= crc;
  srand (crc16 ((unsigned char *) &seq, sizeof (seq)));

  // increment code blocks to make sure that seq is higher or equal after battery
  // change
  seq = ((u_int32_t) crc) << 16;

  i = 0;
  while (1)
    {
      g_MacroBeacon.rf_setup = NRF_RFOPTIONS | ((i&3)<<1);
      g_MacroBeacon.rf_ch = (i%3==0) ? CONFIG_ALTERNATIVE_CHANNEL : CONFIG_DEFAULT_CHANNEL;
      g_MacroBeacon.env.pkt.hdr.size = sizeof (TBeaconTracker);
      g_MacroBeacon.env.pkt.hdr.proto = RFBPROTO_BEACONTRACKER;
      g_MacroBeacon.env.pkt.flags = 0;
      if(remaining_vote_resends > 0) {
      	g_MacroBeacon.env.pkt.flags = (current_vote << 2) | RFBFLAGS_SENSOR;
      	remaining_vote_resends--;
      	if(remaining_vote_resends == 0) {
      		current_vote = 0;
      	}
      }
      if(i%17==0) g_MacroBeacon.env.pkt.flags |= RFBFLAGS_REQUEST_VOTE_TRANSMISSION;
      g_MacroBeacon.env.pkt.strength =
	0x55 * ((g_MacroBeacon.rf_setup >> 1) & 0x3);
      g_MacroBeacon.env.pkt.seq = htonl (seq++);
      g_MacroBeacon.env.pkt.oid = htonl (oid);
      g_MacroBeacon.env.pkt.reserved = 0;
      crc =
	crc16 (g_MacroBeacon.env.datab,
	       sizeof (g_MacroBeacon.env.pkt) -
	       sizeof (g_MacroBeacon.env.pkt.crc));
      g_MacroBeacon.env.pkt.crc = htons (crc);

      // update code_block so on next power up
      // the seq will be higher or equal
      crc = seq >> 16;
      if (crc == 0xFFFF)
	break;
      if (crc == code_block)
	store_codeblock (++crc);

      // encrypt my data
      shuffle_tx_byteorder ();
      xxtea_encode ();
      shuffle_tx_byteorder ();

      // send it away
      nRFCMD_Macro ((unsigned char *) &g_MacroBeacon);
      if(i%CONFIG_BLINK_DISPLAY_MODULO==0 || i%CONFIG_BLINK_DISPLAY_MODULO==2)
        CONFIG_PIN_LED = 1;
      nRFCMD_Execute ();
      if((i%CONFIG_BLINK_DISPLAY_MODULO==0 || i%CONFIG_BLINK_DISPLAY_MODULO==2) && !(remaining_vote_resends == 0 && current_vote > 0) || remaining_vote_resends > 0)
        CONFIG_PIN_LED = 0;
      if(i%CONFIG_VOTE_DISPLAY_MODULO==0) {
	      if( remaining_vote_resends == 0 && current_vote > 0 ) {
	        //sleep_jiffies (6* CONFIG_VOTE_DISPLAY_TIME * TIMER1_JIFFIES_PER_MS);
	      } else {
	        CONFIG_PIN_LED = 0;
	        // sleep a random time to avoid on-air collosions
	        //sleep_jiffies (0xFFFF);
        
	        // Unrolled loop, because there was no free space for a loop counter
	        if(current_sector_vote > 0) {
	          blink(CONFIG_VOTE_DISPLAY_TIME * TIMER1_JIFFIES_PER_MS);
		        if(current_sector_vote > 1) {
		          blink(CONFIG_VOTE_DISPLAY_TIME * TIMER1_JIFFIES_PER_MS);
			        if(current_sector_vote > 2) {
			          blink(CONFIG_VOTE_DISPLAY_TIME * TIMER1_JIFFIES_PER_MS);
				        if(current_sector_vote > 3) {
				          blink(CONFIG_VOTE_DISPLAY_TIME * TIMER1_JIFFIES_PER_MS);
					        if(current_sector_vote > 4) {
					          blink(CONFIG_VOTE_DISPLAY_TIME * TIMER1_JIFFIES_PER_MS);
						        if(current_sector_vote > 5)
						          blink(CONFIG_VOTE_DISPLAY_TIME * TIMER1_JIFFIES_PER_MS);
						        else {
						          //sleep_jiffies (CONFIG_VOTE_DISPLAY_TIME * TIMER1_JIFFIES_PER_MS);
						        }
					        } else {
					          //sleep_jiffies (2* CONFIG_VOTE_DISPLAY_TIME * TIMER1_JIFFIES_PER_MS);
					        }
				        } else {
				          //sleep_jiffies (3* CONFIG_VOTE_DISPLAY_TIME * TIMER1_JIFFIES_PER_MS);
				        }
			        } else {
			          //sleep_jiffies (4* CONFIG_VOTE_DISPLAY_TIME * TIMER1_JIFFIES_PER_MS);
			        }
		        } else {
		          //sleep_jiffies (5* CONFIG_VOTE_DISPLAY_TIME * TIMER1_JIFFIES_PER_MS);
		        }
	        } else {
	          //sleep_jiffies (6* CONFIG_VOTE_DISPLAY_TIME * TIMER1_JIFFIES_PER_MS);
	        }
        }

      }
      
      // Sleep 50ms
      sleep_jiffies(50 * TIMER1_JIFFIES_PER_MS);
      // Sleep from 0ms to ((32767/20)/32767)s = 50ms
      sleep_jiffies (rand ()/20);
      i++;
    }

  // rest in peace
  // when seq counter is exhausted
  while (1)
    {
      msleep (95);
      CONFIG_PIN_LED = 1;
      msleep (5);
      CONFIG_PIN_LED = 0;
    }
}
