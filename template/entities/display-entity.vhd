LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.utils.ALL;

ENTITY display IS
    PORT (
        clk : IN STD_LOGIC;
        n_reset : IN STD_LOGIC;
        ball_loc_x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        ball_loc_y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        paddle_loc_x : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        brick_loc_x_arr : IN array_loc_x;
        brick_loc_y_arr : IN array_loc_y;
        brick_loc_valid_arr : IN array_loc_valid;
        led_array : OUT STD_LOGIC_VECTOR(0 TO 107)); -- 12 x 9
END display;