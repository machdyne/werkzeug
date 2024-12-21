# Werkzeug USB Multi-Tool

Werkzeug is a USB multi-tool that can be used as a universal programmer, USB-UART bridge, USB-SPI bridge, USB-I2C bridge, USB host bridge, USB-PMOD bridge, programmable GPIO bit-bang device, logic analyzer, debugging tool and a lot more.

![Werkzeug USB Multi-Tool](https://github.com/machdyne/werkzeug/blob/9b79874ae331459f5c31abc263e31347d1d49e67/werkzeug.png)

This repo contains schematics, pinouts, a 3D-printable case, example firmware and documentation.

Find more information on the [Werkzeug product page](https://machdyne.com/product/werkzeug-multi-tool/).

## Firmware

The firmware can be updated by pressing the RESET button while holding down the BOOT button and then dragging and dropping a new UF2 file to the device filesystem.

### Firmware Resources

| Firmware | Description |
| --------- | ----------- |
| test\_gpio | Test for GPIO and ADC |
| test\_usb\_host | Test for USB host port |
| micropython | [Micropython](https://micropython.org/) |
| [atio](https://github.com/machdyne/atio) | AT command set for controlling GPIO over USB CDC |
| [dev\_musli](https://github.com/machdyne/musli/tree/main/firmware/dev_musli) | Firmware for using Werkzeug with [ldprog](https://github.com/machdyne/ldprog) |
| [pico-dirtyJtag](https://github.com/machdyne/pico-dirtyJtag) | JTAG firmware |

Note: Our fork of dirtyJtag uses different GPIOs for JTAG than the original repo.

Note: The dirtyJtag\_alt.uf2 firmware is intended for a straight-through cable with 2x3 female headers where one wire has been removed. This cable can be plugged into the GPIO header (see pinout below).

### Building Firmware

To build the example firmware you will need to install the [Raspberry Pi Pico SDK](https://github.com/raspberrypi/pico-sdk).

Set the `PICO_SDK_PATH` environment variable to your SDK path.

```
$ git clone https://github.com/machdyne/werkzeug
$ cd werkzeug/firmware/test_gpio
$ mkdir build
$ cd build
$ cmake ..
$ make
```

This will create a UF2 file that can be programmed to the device using the method described above.

After the firmware is loaded you can see the output on the USB-C port:

```
minicom -D /dev/ttyACM0 -b 115200
```

## Pico Examples

```
$ git clone https://github.com/raspberrypi/pico-examples
$ cd pico-examples
$ mkdir build
$ cd build
$ cmake -DPICO_BOARD=machdyne_werkzeug ..
```

## Micropython

After the Micropython firmware is installed, you can access the REPL via the
USB-C port:

```
minicom -D /dev/ttyACM0 -b 115200
```

And then:

```
>>> help()
>>> help(machine.Pin.board) # list werkzeug pins
>>> green = machine.Pin('LED_GREEN', machine.Pin.OUT, value=1)
>>> red = machine.Pin('LED_RED', machine.Pin.OUT, value=1)
>>> green.value(0) # werkzeug LEDs are active low
```

You can use [ampy](https://learn.adafruit.com/micropython-basics-load-files-and-run-code/install-ampy) to upload scripts to the filesystem.

## USB Host Power

There is a switch near the USB Type-A female port that determines whether or not the port VBUS is connected to 5V.

Warning: Do not use a male-to-male cable with this port to connect Werkzeug to a computer when VBUS is connected.

## Resources

  * [RP2040 Datasheet (PDF)](https://datasheets.raspberrypi.com/rp2040/rp2040-datasheet.pdf)
  * [Getting started with Raspberry Pi Pico (PDF)](https://datasheets.raspberrypi.com/pico/getting-started-with-pico.pdf)
  * [Raspberry Pi Pico Examples](https://github.com/raspberrypi/pico-examples)
  * [TinyUSB Examples](https://github.com/hathach/tinyusb/tree/master/examples)

## Pinouts

### IO Header

```
1  2  3  4  5  6  7  8  9  10
11 12 13 14 15 16 17 18 19 20
```

| Pin | RP2040 Signal | dirtyJtag | dirtyJtag\_alt |
| --- | ------------- | --------- | -------------- |
| 1 | GPIO0 | TCK |
| 2 | GPIO1 | TDI |
| 3 | GPIO2 | TDO |
| 4 | GPIO3 | TMS |
| 5 | GPIO4 |
| 6 | GPIO5 |
| 7 | GPIO6 | | TCK |
| 8 | GPIO7 | | TDO |
| 9 | GND |
| 10 | 3V3 |
| 11 | GPIO8 |
| 12 | GPIO9 |
| 13 | GPIO10 |
| 14 | GPIO11 |
| 15 | GPIO26/ADC0 |
| 16 | GPIO27/ADC1 |
| 17 | GPIO28/ADC2 | | TDI |
| 18 | GPIO29/ADC3 | | TMS |
| 19 | GND |
| 20 | 3V3 |

### PMOD

```
6  5  4  3  2  1
12 11 10 9  8  7
```

| Pin | Signal |
| --- | ------ |
| 1 | GPIO19 |
| 2 | GPIO17 |
| 3 | GPIO15 |
| 4 | GPIO13 |
| 5 | GND |
| 6 | 3V3 |
| 7 | GPIO18 |
| 8 | GPIO16 |
| 9 | GPIO14 |
| 10 | GPIO12 |
| 11 | GND |
| 12 | 3V3 |

### Other Signals

| Signal | Description |
| ------ | ------ |
| GPIO20 | Green LED (active low) |
| GPIO21 | Red LED (active low) |
| GPIO22 | USB host VBUS status (controlled by switch) |
| GPIO23 | USB host D- |
| GPIO24 | USB host D+ |
| GPIO25 | USB host D+ pull-up |

## Board Revisions

| Revision | Notes |
| -------- | ----- |
| V2 | Initial production version |
| V3 | Adds side boot/reset buttons and unpopulated SWD header |
| V3A | Current production version; has silkscreen error on bottom side unpopulated external power header (5V and GND labels are swapped and blacked out) |
| V3C | Future production version; fixes silkscreen error |
