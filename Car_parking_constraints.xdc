create_clock -period 10.000 -name clk [get_ports clk]

set_load 5.000 [all_outputs]
set_property LOAD 5 [get_ports {car_count[0]}]
set_property LOAD 5 [get_ports {car_count[1]}]
set_property LOAD 5 [get_ports {car_count[2]}]
set_property LOAD 5 [get_ports entry_gate_open]
set_property LOAD 5 [get_ports exit_gate_open]
set_property LOAD 5 [get_ports parking_full]
