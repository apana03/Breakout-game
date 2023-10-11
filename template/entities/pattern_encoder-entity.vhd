LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY pattern_encoder IS
    PORT (
        led_array : IN STD_LOGIC_VECTOR(0 TO 107);
        next_ball_x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        next_ball_y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        curr_ball_x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        curr_ball_y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        curr_ball_valid : IN STD_LOGIC;
        next_pattern : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        next_pattern_valid : OUT STD_LOGIC);
END pattern_encoder;