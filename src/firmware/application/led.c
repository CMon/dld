/***************************************************************
 *
 * OpenBeacon.org - LED support
 *
 * Copyright 2007 Milosch Meriac <meriac@openbeacon.de>
 *
 ***************************************************************

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
#include <FreeRTOS.h>
#include <AT91SAM7.h>
#include <lib_AT91SAM7.h>
#include <string.h>
#include <board.h>
#include <task.h>
#include "led.h"
/**********************************************************************/

void vLedSetRed(bool_t on)
{
    if(on)
	AT91F_PIO_ClearOutput( AT91C_BASE_PIOA, LED_RED );
    else
        AT91F_PIO_SetOutput( AT91C_BASE_PIOA, LED_RED );
}
/**********************************************************************/

extern void vLedSetGreen(bool_t on)
{
    if(on)
	AT91F_PIO_ClearOutput( AT91C_BASE_PIOA, LED_GREEN );
    else
        AT91F_PIO_SetOutput( AT91C_BASE_PIOA, LED_GREEN );
}
/**********************************************************************/

void vLedHaltBlinking(int reason)
{
    volatile u_int32_t i=0;
    while(1)
    {
        AT91F_PIO_ClearOutput( AT91C_BASE_PIOA, LED_MASK );
        for(i=0; i<MCK/40; i++) ;
	
	switch(reason) {
		case 1:
			vLedSetGreen(1);
			vLedSetRed(0);
			break;
		case 2:
			vLedSetGreen(0);
			vLedSetRed(1);
			break;
		case 3:
			vLedSetGreen(1);
			vLedSetRed(1);
			break;
		case 0:
		default:
			vLedSetGreen(0);
			vLedSetRed(0);
			break;
	}
        for(i=0; i<MCK/20; i++) ;
	
        AT91F_PIO_SetOutput( AT91C_BASE_PIOA, LED_MASK );
        for(i=0; i<MCK/40; i++) ;
    }
}
/**********************************************************************/

void vLedInit(void)
{
    // turn off LED's 
    AT91F_PIO_CfgOutput( AT91C_BASE_PIOA, LED_MASK );
    AT91F_PIO_SetOutput( AT91C_BASE_PIOA, LED_MASK );
}
