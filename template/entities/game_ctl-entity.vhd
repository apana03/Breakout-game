LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.utils.ALL;

ENTITY game_ctl IS
    PORT (
        clk : IN STD_LOGIC;
        n_reset : IN STD_LOGIC;
        but_left : IN STD_LOGIC;
        but_right : IN STD_LOGIC;
        ball_loc_invalid : IN STD_LOGIC;
        brick_loc_valid : IN array_loc_valid;
        game_ctl_out : OUT STD_LOGIC);
END game_ctl;