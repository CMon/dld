/***************************************************************
 *
 * OpenBeacon.org - main entry for 2.4GHz RFID USB reader
 *
 * Copyright 2007 Milosch Meriac <meriac@openbeacon.de>
 *
 * basically starts the USB task, initializes all IO ports
 * and introduces idle application hook to handle the HF traffic
 * from the nRF24L01 chip
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
/* Library includes. */
#include <string.h>
#include <stdio.h>

#include <FreeRTOS.h>
#include <AT91SAM7.h>
#include <USB-CDC.h>
#include <task.h>

#include "openbeacon.h"
#include "board.h"
#include "led.h"
#include "env.h"
#include "cmd.h"
#include "proto.h"
#include "dbgu.h"

/**********************************************************************/
static inline void prvSetupHardware (void)
{
    /*	When using the JTAG debugger the hardware is not always initialised to
	the correct default state.  This line just ensures that this does not
	cause all interrupts to be masked at the start. */
    AT91C_BASE_AIC->AIC_EOICR = 0;

    /*	Enable the peripheral clock. */
    AT91C_BASE_PMC->PMC_PCER = 1 << AT91C_ID_PIOA;
    AT91C_BASE_PMC->PMC_PCER = 1 << AT91C_ID_PIOB;    

    /* initialize environment variables */
    AT91F_DBGU_Init();
    env_init();
    if(!env_load())
    {
	env.e.mode=0;
	env.e.reader_id=255;
	env_store();
    }
}

/**********************************************************************/
void vApplicationIdleHook(void)
{
    /* Restart watchdog, has been enabled in Cstartup_SAM7.c */
    AT91F_WDTRestart(AT91C_BASE_WDTC);
}

/**********************************************************************/
int main (void)
{
    prvSetupHardware ();

    vLedInit();
    
    xTaskCreate (vUSBCDCTask, (signed portCHAR *) "USB", TASK_USB_STACK,
	NULL, TASK_USB_PRIORITY, NULL);
	
    vCmdInit();
    
    vInitProtocolLayer();

    vLedSetGreen(0);

    vTaskStartScheduler ();
    
    return 0;
}
