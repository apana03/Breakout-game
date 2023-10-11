LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.utils.ALL;

ENTITY breakout IS
        PORT (
                clk : IN STD_LOGIC;
                n_reset : IN STD_LOGIC;
                switches : IN STD_LOGIC_VECTOR(0 TO 3);
                buttons : IN STD_LOGIC_VECTOR(0 TO 1);
                led_array : OUT STD_LOGIC_VECTOR(0 TO 107));
END breakout;