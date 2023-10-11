LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY paddle IS
    PORT (
        clk : IN STD_LOGIC;
        n_reset : IN STD_LOGIC;
        game_ctl : IN STD_LOGIC;
        but_left : IN STD_LOGIC;
        but_right : IN STD_LOGIC;
        paddle_loc_x : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END paddle;