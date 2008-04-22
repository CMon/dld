/***************************************************************
 *
 * OpenBeacon.org - configuration file
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

#ifndef CONFIG_H
#define CONFIG_H

#define	CONFIG_DEBUG_LED
#define CONFIG_DELAYUS

#define CONFIG_TEA_ENABLEENCODE
#define CONFIG_TEA_ENABLEDECODE

/***************************************************************
 *
 *  CPU peripherals settings
 *
 * configuration:
 *      RA0                     input
 *      RA1     SENSOR          input
 *      RA2     nRF_IRQ         input
 *      RA3     Vpp             input
 *      RA4                     input
 *      RA5                     input
 *
 *      RC0     SCK             output
 *      RC1     MOSI            output
 *      RC2     MISO            input
 *      RC3     CSN             output
 *      RC4     nRF_CE          output
 *      RC5     LED             output
 *
 ***************************************************************/

#define CONFIG_PIN_SENSOR	RA0
#define CONFIG_PIN_IRQ		RA2

#define CONFIG_PIN_SCK		RC0
#define CONFIG_PIN_MOSI		RC1
#define CONFIG_PIN_MISO		RC2
#define CONFIG_PIN_CSN		RC3
#define CONFIG_PIN_CE		RC4
#define CONFIG_PIN_LED		RC5

#define CONFIG_CPU_XTAL_FREQ	8MHz
#define CONFIG_CPU_TRISA	0x3F
#define CONFIG_CPU_TRISC	0x04
#define CONFIG_CPU_ANSEL	0x00
#define CONFIG_CPU_WPUA		0x00
#define CONFIG_CPU_CMCON0	0x07
#define CONFIG_CPU_OPTION	0x00
#define CONFIG_CPU_OSCCON	0x71

/***************************************************************
 *
 *  RF chip settings
 *
 ***************************************************************/

#define CONFIG_DEFAULT_CHANNEL 85
#define CONFIG_ALTERNATIVE_CHANNEL 81


/***************************************************************
 *
 *  Voting settings
 *
 ***************************************************************/

/*
 * CONFIG_VOTE_TIMEOUT_SHIFT and CONFIG_MAX_VOTE_TIMEOUT determine
 * together the time without button presses that is used to detect
 * when the voting sequence ends. In timer.c a timer (vote_timeout)
 * is kept which keeps track of the time (in timer1 jiffies, 
 * rightshifted by CONFIG_VOTE_TIMEOUT_SHIFT) since the last button
 * press in a voting sequence. When this value is greater or equal
 * CONFIG_MAX_VOTE_TIMEOUT the voting process is defined to have
 * ended and the accumulated vote (clipped at CONFIG_MAX_VOTE_VALUE)
 * is sent for the next CONFIG_VOTE_RESENDS beacons.
 */
#define CONFIG_VOTE_TIMEOUT_SHIFT 5
#define CONFIG_MAX_VOTE_TIMEOUT 0x3ff
#define CONFIG_MAX_VOTE_VALUE 5
#define CONFIG_VOTE_RESENDS 255

/* Time in ms between pulses of the LED to display current
 * sector vote.
 */
#define CONFIG_VOTE_DISPLAY_TIME 200
/* Display the current sector vote every CONFIG_VOTE_DISPLAY_MODULO
 * runs of the main loop.
 */
#define CONFIG_VOTE_DISPLAY_MODULO 32
/* Blink every CONFIG_BLINK_DISPLAY_MODULO runs of the main loop
 * to indicate that we are still alive.
 */
#define CONFIG_BLINK_DISPLAY_MODULO 16

#include "config_generated.h"

#endif
