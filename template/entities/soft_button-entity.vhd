LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.utils.ALL;

ENTITY soft_button IS
    PORT (
        clk : IN STD_LOGIC;
        n_reset : IN STD_LOGIC;
        button_in : IN STD_LOGIC;
        button_out : OUT STD_LOGIC);
END soft_button;