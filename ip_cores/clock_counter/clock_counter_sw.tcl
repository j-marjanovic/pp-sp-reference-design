
create_driver clock_counter_driver

set_sw_property hw_class_name clock_counter
set_sw_property version 1.0
set_sw_property bsp_subdirectory drivers
set_sw_property min_compatible_hw_version 1.0

add_sw_property include_source inc/clock_counter.h

add_sw_property c_source src/clock_counter.c

add_sw_property supported_bsp_type HAL
