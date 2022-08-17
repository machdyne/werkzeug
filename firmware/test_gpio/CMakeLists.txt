cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)

project(test_gpio)

add_executable(test_gpio
        test_gpio.c
        )

target_sources(test_gpio PUBLIC
        ${CMAKE_CURRENT_LIST_DIR}/test_gpio.c
        )

pico_sdk_init()

target_link_libraries(test_gpio PRIVATE pico_stdlib hardware_resets hardware_irq hardware_adc)

# enable usb output, disable uart output
pico_enable_stdio_usb(test_gpio 1)
pico_enable_stdio_uart(test_gpio 0)

pico_add_extra_outputs(test_gpio)
