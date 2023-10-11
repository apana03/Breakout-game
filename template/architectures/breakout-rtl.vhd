ARCHITECTURE rtl OF breakout IS
        -- button
        SIGNAL buttons_inv : STD_LOGIC_VECTOR(0 TO 1);
        SIGNAL buttons_db : STD_LOGIC_VECTOR(0 TO 1);
        ALIAS but_left IS buttons_db(0);
        ALIAS but_right IS buttons_db(1);

        -- switches
        SIGNAL switches_inv : STD_LOGIC_VECTOR(0 TO 3);
        ALIAS sw0 IS switches_inv(0);
        ALIAS sw1 IS switches_inv(1);
        ALIAS sw2 IS switches_inv(2);
        ALIAS sw3 IS switches_inv(3);

        -- led array
        SIGNAL led_array_internal : STD_LOGIC_VECTOR(0 TO 107);

        -- ball location
        SIGNAL ball_loc_x : STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL ball_loc_y : STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL ball_vel_x : STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL ball_vel_y : STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL ball_loc_invalid : STD_LOGIC;

        -- paddle location
        SIGNAL paddle_loc_x : STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL paddle_loc_y : STD_LOGIC_VECTOR(3 DOWNTO 0);

        --brick 
        SIGNAL brick_loc_x : array_loc_x := (OTHERS => x"0");
        SIGNAL brick_loc_y : array_loc_y := (OTHERS => x"0");
        SIGNAL brick_loc_valid : array_loc_valid;

        -- game ctl
        SIGNAL game_ctl : STD_LOGIC;

        SIGNAL sync : STD_LOGIC;
BEGIN
        led_array <= led_array_internal;
        buttons_inv <= NOT buttons;
        switches_inv <= NOT switches;

        game_ctl_gen : ENTITY work.game_ctl
                PORT MAP(
                        clk => clk,
                        n_reset => n_reset,
                        but_left => but_left,
                        but_right => but_right,
                        brick_loc_valid => brick_loc_valid,
                        ball_loc_invalid => ball_loc_invalid,
                        game_ctl_out => game_ctl);

        soft_button0 : ENTITY work.soft_button
                PORT MAP(
                        clk => clk,
                        n_reset => n_reset,
                        button_in => buttons_inv(0),
                        button_out => buttons_db(0));

        soft_button1 : ENTITY work.soft_button
                PORT MAP(
                        clk => clk,
                        n_reset => n_reset,
                        button_in => buttons_inv(1),
                        button_out => buttons_db(1));

        ball : ENTITY work.ball
                PORT MAP(
                        clk => clk,
                        n_reset => n_reset,
                        game_ctl => game_ctl,
                        sync => sync,
                        led_array => led_array_internal,
                        ball_loc_x => ball_loc_x,
                        ball_loc_y => ball_loc_y,
                        ball_vel_x => ball_vel_x,
                        ball_vel_y => ball_vel_y,
                        ball_loc_invalid => ball_loc_invalid);

        paddle : ENTITY work.paddle
                PORT MAP(
                        clk => clk,
                        n_reset => n_reset,
                        game_ctl => game_ctl,
                        but_left => but_left,
                        but_right => but_right,
                        paddle_loc_x => paddle_loc_x);

        b0 : ENTITY work.brick
                GENERIC MAP(x"3", x"4")
                PORT MAP(
                        clk => clk,
                        n_reset => n_reset,
                        game_ctl => game_ctl,
                        sync => sync,
                        sw => sw0,
                        ball_loc_x => ball_loc_x,
                        ball_loc_y => ball_loc_y,
                        ball_vel_x => ball_vel_x,
                        ball_vel_y => ball_vel_y,
                        brick_loc_x => brick_loc_x(0),
                        brick_loc_y => brick_loc_y(0),
                        brick_loc_valid => brick_loc_valid(0));

        b1 : ENTITY work.brick
                GENERIC MAP(x"7", x"4")
                PORT MAP(
                        clk => clk,
                        n_reset => n_reset,
                        game_ctl => game_ctl,
                        sync => sync,
                        sw => sw1,
                        ball_loc_x => ball_loc_x,
                        ball_loc_y => ball_loc_y,
                        ball_vel_x => ball_vel_x,
                        ball_vel_y => ball_vel_y,
                        brick_loc_x => brick_loc_x(1),
                        brick_loc_y => brick_loc_y(1),
                        brick_loc_valid => brick_loc_valid(1));

        b2 : ENTITY work.brick
                GENERIC MAP(x"3", x"7", '0')
                PORT MAP(
                        clk => clk,
                        n_reset => n_reset,
                        game_ctl => game_ctl,
                        sync => sync,
                        sw => sw2,
                        ball_loc_x => ball_loc_x,
                        ball_loc_y => ball_loc_y,
                        ball_vel_x => ball_vel_x,
                        ball_vel_y => ball_vel_y,
                        brick_loc_x => brick_loc_x(2),
                        brick_loc_y => brick_loc_y(2),
                        brick_loc_valid => brick_loc_valid(2));

        b3 : ENTITY work.brick
                GENERIC MAP(x"7", x"7", '0')
                PORT MAP(
                        clk => clk,
                        n_reset => n_reset,
                        game_ctl => game_ctl,
                        sync => sync,
                        sw => sw3,
                        ball_loc_x => ball_loc_x,
                        ball_loc_y => ball_loc_y,
                        ball_vel_x => ball_vel_x,
                        ball_vel_y => ball_vel_y,
                        brick_loc_x => brick_loc_x(3),
                        brick_loc_y => brick_loc_y(3),
                        brick_loc_valid => brick_loc_valid(3));

        refresh : ENTITY work.timer
                GENERIC MAP(count => refresh_count)
                PORT MAP(
                        clk => clk,
                        n_reset => n_reset,
                        reset => '0',
                        flag => sync);

        display : ENTITY work.display
                PORT MAP(
                        clk => clk,
                        n_reset => n_reset,
                        ball_loc_x => ball_loc_x,
                        ball_loc_y => ball_loc_y,
                        paddle_loc_x => paddle_loc_x,
                        brick_loc_x_arr => brick_loc_x,
                        brick_loc_y_arr => brick_loc_y,
                        brick_loc_valid_arr => brick_loc_valid,
                        led_array => led_array_internal);

END rtl;
