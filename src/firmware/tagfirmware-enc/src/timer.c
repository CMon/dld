/***************************************************************
 *
 * OpenBeacon.org - accurate low power sleep function,
 *                  based on 32.768kHz watch crystal
 *
 * Copyright 2006 Harald Welte <laforge@openbeacon.org>
 *           2007 Henryk Plötz <henryk@ploetzli.ch>
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

#include <htc.h>
#include "config.h"
#include "timer.h"

#define PIE1	0x8c
#define INTCON	0x0b

#define	T1CON_TMR1ON 	(1 << 0)
#define	T1CON_TMR1CS	(1 << 1)
#define T1CON_T1SYNC	(1 << 2)
#define T1CON_T1OSCEN	(1 << 3)
#define T1CON_T1CKPS0	(1 << 4)
#define T1CON_T1CKPS1	(1 << 5)
#define T1CON_TMR1GE	(1 << 6)
#define T1CON_T1GINV	(1 << 7)

#define PIR1_TMR1IF	(1 << 0)

#define PIE1_TMR1IE	(1 << 0)

#define INTCON_PEIE	(1 << 6)
#define INTCON_GIE	(1 << 7)

static char timer1_wrapped;
unsigned short vote_timeout;
unsigned char current_vote;
unsigned char remaining_vote_resends;
static unsigned short last_timer_set;

void
timer1_init (void)
{
  /* Configure Timer 1 to use external 32768Hz crystal and 
   * no (1:1) prescaler*/
  T1CON = T1CON_T1OSCEN | T1CON_T1SYNC | T1CON_TMR1CS;
  timer1_wrapped = vote_timeout = current_vote = remaining_vote_resends = last_timer_set = 0;
}

void
timer1_set (unsigned short tout)
{
  last_timer_set = tout >> CONFIG_VOTE_TIMEOUT_SHIFT;
  tout = 0xffff - tout;

  TMR1H = tout >> 8;
  TMR1L = tout & 0xff;
}

void
timer1_go (void)
{
  TMR1ON = 1;
  TMR1IE = 1;
  PEIE = 1;
  GIE = 1;
}

void
timer1_sleep (void)
{
  timer1_wrapped = 0;
  while (timer1_wrapped == 0)
    {
      /* enable peripheral interrupts */
      GIE = PEIE = RAIE = TMR1IE = 1;
      SLEEP ();
    }
}

void
sleep_jiffies (unsigned short jiffies)
{
  timer1_set (jiffies);
  timer1_go ();
  timer1_sleep ();
}

void
msleep (unsigned short ms)
{
  sleep_jiffies (ms * TIMER1_JIFFIES_PER_MS);
}

void
sleep2ms (void)
{
  msleep (2);
}

void interrupt
irq (void)
{
  /* timer1 has overflowed */
  if (TMR1IF)
    {
    	/* This is a somewhat strange way to write something similar to:
    	 * if(vote_timeout > 0) {
    	 *   if(last_timer_set > 0) {
    	 *     if(vote_timeout < (0xffff - last_timer_set))
    	 *       vote_timeout += last_timer_set;
    	 *     else
    	 *       vote_timeout = 0xffff;
    	 *   } else {
    	 *     if(vote_timeout < 0xffff)
    	 *       vote_timeout++;
    	 *   }
    	 * }
    	 * using the msb of vote_timeout as an overflow bit (thereby reducing the
    	 * max usable value from 0xffff to 0x7fff), but without the compiler needing
    	 * additional RAM for temporary results. -- Henryk
    	 */
	if(vote_timeout > 0) {
		if(vote_timeout < 0x8000) {
			if(last_timer_set == 0) last_timer_set = 1;
			if(last_timer_set > 0x7fff) last_timer_set = 0x7fff;
			vote_timeout += last_timer_set;
		}
		if(vote_timeout >= 0x8000)
			vote_timeout = 0xffff;
	} 
      timer1_wrapped = 1;
      last_timer_set = 0;
      TMR1ON = 0;
      TMR1IF = 0;
    }

  	if (RAIF) {
		if (CONFIG_PIN_SENSOR == 0) {
			if(remaining_vote_resends > 0) {
				remaining_vote_resends = 0;
				current_vote = 0;
			}
			
			if(current_vote < CONFIG_MAX_VOTE_VALUE) {
				current_vote++;
			}
			vote_timeout = 1;
			CONFIG_PIN_LED = 1;
		}
		RAIF = 0;
	}
	
	if(vote_timeout > CONFIG_MAX_VOTE_TIMEOUT) {
		vote_timeout = 0;
		remaining_vote_resends = CONFIG_VOTE_RESENDS;
	}
}
