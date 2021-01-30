set_global_assignment -entity "fortygig_eth_pll" -library "lib_fortygig_eth_pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "fortygig_eth_pll" -library "lib_fortygig_eth_pll" -name IP_TOOL_VERSION "19.1"
set_global_assignment -entity "fortygig_eth_pll" -library "lib_fortygig_eth_pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_fortygig_eth_pll" -name SPD_FILE [file join $::quartus(sip_path) "fortygig_eth_pll.spd"]

set_global_assignment -library "lib_fortygig_eth_pll" -name MISC_FILE [file join $::quartus(sip_path) "fortygig_eth_pll_sim/fortygig_eth_pll.vo"]
