
create_driver mem_checker_driver

set_sw_property hw_class_name mem_checker
set_sw_property version 1.1
set_sw_property bsp_subdirectory drivers
set_sw_property min_compatible_hw_version 0.1

add_sw_property include_source inc/mem_checker.h
add_sw_property include_source inc/mem_checker_regs.h

add_sw_property c_source src/mem_checker.c

add_sw_property supported_bsp_type HAL
