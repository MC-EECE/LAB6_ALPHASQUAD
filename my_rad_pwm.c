#include "system.h"
#include "my_rad_pwm.h"
int main(void)
{ 
	alt_u32 period, pulse_width;
	alt_u8 enable = 0;
	IOWR(PWM_0_BASE, PWM_ENABLE, enable);
	while(1) {

	// read from switches to determine pulse width
	enable = (IORD(SLIDER_SWITCHES_BASE, 0)&0x20000)?1:0;
	pulse_width = IORD(SLIDER_SWITCHES_BASE,0)&0xFF;
	// set the pwm period
	period = (IORD(SLIDER_SWITCHES_BASE,0)&0xFF00) >> 8;

	// output the period to the pwm
	// output the pulse width value to the pwm
	 alt_u32 test_period = IORD(PWM_0_BASE, PWM_PERIOD);

    IOWR(PWM_0_BASE, PWM_PERIOD, period);
    IOWR(PWM_0_BASE, PWM_PULSE_WIDTH, pulse_width);

    alt_u32 test_pw = IORD(PWM_0_BASE, PWM_PULSE_WIDTH);
       if ((test_pw == pulse_width) && (test_period == period)) {

  	   IOWR(PWM_0_BASE, PWM_ENABLE, enable);
       }
	}
return 0;
}
