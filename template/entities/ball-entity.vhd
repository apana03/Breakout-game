LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.utils.ALL;

ENTITY ball IS
    PORT (
        clk : IN STD_LOGIC;
        n_reset : IN STD_LOGIC;
        game_ctl : IN STD_LOGIC;
        sync : IN STD_LOGIC;
        led_array : IN STD_LOGIC_VECTOR(0 TO 107);
        ball_loc_x : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        ball_loc_y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        ball_vel_x : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        ball_vel_y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        ball_loc_invalid : OUT STD_LOGIC);
END ball;