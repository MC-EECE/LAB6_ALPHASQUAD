/*************************************************************************
 * Copyright (c) 2017       *
 * All rights reserved. All use of this software and documentation is     *
 * subject to the License Agreement located at the end of this file below.*
 *************************************************************************/
/******************************************************************************

 */

#include "my_cool_pwm.h"
#include "system.h"

/*******************************************************************************
 * int main()                                                                  *
 *                                                                             *
 *                                                    *
 ******************************************************************************/

int main(void)
{ 
	alt_u32 period, pulse_width;
	alt_u8 enable = 0;
	IOWR(PWM_0_BASE, PWM_enable, enable);
	while(1) {

	// read from switches to determine pulse width
	enable = (IORD(SLIDER_SWITCHES_BASE, 0)&0x20000)?1:0;
	pulse_width = IORD(SLIDER_SWITCHES_BASE,0)&0xFF;
	// set the pwm period
	period = (IORD(SLIDER_SWITCHES_BASE,0)&0xFF00) >> 8;

	// output the period to the pwm
	// output the pulse width value to the pwm

    IOWR(PWM_0_BASE, 1, period);
    IOWR(PWM_0_BASE, 2, pulse_width);

	// make sure the pwm is enabled
    if (enable==0){
    	enable = 1;
    	IOWR(PWM_0_BASE, PWM_enable, enable);}
	}
    return 0;
}
