LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY steer IS
    PORT (
        next_pattern : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        curr_dir : IN unsigned(2 DOWNTO 0);
        next_dir : OUT unsigned(2 DOWNTO 0));
END steer;