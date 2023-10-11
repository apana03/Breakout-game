LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY timer IS
    GENERIC (count : INTEGER := 8);
    PORT (
        clk : IN STD_LOGIC;
        n_reset : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        flag : OUT STD_LOGIC);
END timer;