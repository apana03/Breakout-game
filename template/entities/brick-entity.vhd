LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.utils.ALL;

ENTITY brick IS
    GENERIC (
        loc_x, loc_y : STD_LOGIC_VECTOR(3 DOWNTO 0);
        clear_when_adj : STD_LOGIC := '0');
    PORT (
        clk : IN STD_LOGIC;
        n_reset : IN STD_LOGIC;
        game_ctl : IN STD_LOGIC;
        sync : IN STD_LOGIC;
        sw : IN STD_LOGIC;
        ball_loc_x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        ball_loc_y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        ball_vel_x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        ball_vel_y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        brick_loc_x : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        brick_loc_y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        brick_loc_valid : OUT STD_LOGIC);
END brick;