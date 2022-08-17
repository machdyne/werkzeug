/**
 * Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
 * Copyright (c) 2022 Lone Dynamics Corporation <info@lonedynamics.com>
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Werkzeug GPIO/ADC Test Firmware
 *
 */

#include <stdio.h>
#include <strings.h>

// Pico
#include "pico/stdlib.h"
#include "hardware/watchdog.h"
#include "hardware/adc.h"
#include "pico/stdlib.h"
#include "pico/binary_info.h"

void init_gpio_test(void) {

	gpio_init(0);	// GPIO0
		gpio_set_dir(0, true);
	gpio_init(1);	// GPIO1
		gpio_set_dir(1, true);
	gpio_init(2);	// GPIO2
		gpio_set_dir(2, true);
	gpio_init(3);	// GPIO3
		gpio_set_dir(3, true);
	gpio_init(4);	// GPIO4
		gpio_set_dir(4, true);
	gpio_init(5);	// GPIO5
		gpio_set_dir(5, true);
	gpio_init(6);	// GPIO6
		gpio_set_dir(6, true);
	gpio_init(7);	// GPIO7
		gpio_set_dir(7, true);
	gpio_init(8);	// GPIO8
		gpio_set_dir(8, true);
	gpio_init(9);	// GPIO9
		gpio_set_dir(9, true);
	gpio_init(10);	// GPIO10
		gpio_set_dir(10, true);
	gpio_init(11);	// GPIO11
		gpio_set_dir(11, true);
	gpio_init(12);	// PMOD_A10
		gpio_set_dir(12, true);
	gpio_init(13);	// PMOD_A4
		gpio_set_dir(13, true);
	gpio_init(14);	// PMOD_A9
		gpio_set_dir(14, true);
	gpio_init(15);	// PMOD_A3
		gpio_set_dir(15, true);
	gpio_init(16);	// PMOD_A8
		gpio_set_dir(16, true);
	gpio_init(17);	// PMOD_A2
		gpio_set_dir(17, true);
	gpio_init(18);	// PMOD_A7
		gpio_set_dir(18, true);
	gpio_init(19);	// PMOD_A1
		gpio_set_dir(19, true);
	gpio_init(20);	// LED1
		gpio_set_dir(20, true);
	gpio_init(21);	// LED2
		gpio_set_dir(21, true);
	gpio_init(22);	// SW_HOST
		gpio_set_pulls(22, false, false);

	adc_init();
	adc_gpio_init(26);
		gpio_set_pulls(26, false, false);
	adc_gpio_init(27);
		gpio_set_pulls(27, false, false);
	adc_gpio_init(28);
		gpio_set_pulls(28, false, false);
	adc_gpio_init(29);
		gpio_set_pulls(29, false, false);

}

int main(void) {

	stdio_init_all();

	printf("gpio_test initializing ...\n");
	init_gpio_test();

	int gpioctr = 0;
	int pmodctr = 0;
	int led = 0;

	const float conversion_factor = 3.3f / (1 << 12);

	while (1) {

		for (int i = 0; i < 12; i++) gpio_put(0+i, 0);
		for (int i = 0; i < 8; i++) gpio_put(12+i, 0);

		gpio_put(0+gpioctr, 1);
		gpio_put(12+pmodctr, 1);

		if (++gpioctr == 12) gpioctr = 0;
		if (++pmodctr == 8) pmodctr = 0;

		if (led) {
			gpio_put(20, 0);
			gpio_put(21, 1);
			led = 0;
		} else {
			gpio_put(20, 1);
			gpio_put(21, 0);
			led = 1;
		}

		adc_select_input(0);
		float adc0 = adc_read() * conversion_factor;
		adc_select_input(1);
		float adc1 = adc_read() * conversion_factor;
		adc_select_input(2);
		float adc2 = adc_read() * conversion_factor;
		adc_select_input(3);
		float adc3 = adc_read() * conversion_factor;

		printf("sw_host: %i adc0: %f adc1: %f adc3: %f adc4: %f\n",
			gpio_get(22), adc0, adc1, adc2, adc3);

		sleep_ms(500);

	}

	return 0;

}
