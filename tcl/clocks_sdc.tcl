# You have to replace <ENTITY_PORT_NAME_xxx> with the name of the Clock port
# of your top entity
set_time_unit ns
set_decimal_places 3
create_clock -period 83.333 -waveform { 0 41.667 } clk -name clk1
#create_clock -period 20.0 -waveform { 0 10.0 } <ENTITY_PORT_NAME_CONNECTED_TO_CLOCK_12MHZ> -name clk2
