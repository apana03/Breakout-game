ARCHITECTURE rtl OF ball IS
    -- up	        0
    -- down	        1
    -- up left	    2
    -- up right	    3
    -- down left 	4
    -- down right	5
    TYPE signed_array IS ARRAY (0 TO 5) OF signed(3 DOWNTO 0);
    SIGNAL lookup_vx : signed_array := (0 => "0000",
    1 => "0000",
    2 => "1111",
    3 => "0001",
    4 => "1111",
    5 => "0001",
    OTHERS => "0000");
    SIGNAL lookup_vy : signed_array := (0 => "0001",
    1 => "1111",
    2 => "0001",
    3 => "0001",
    4 => "1111",
    5 => "1111",
    OTHERS => "0000");

    -- cur velocity
    SIGNAL ball_dir : unsigned(2 DOWNTO 0) := b"001";
    SIGNAL next_ball_dir : unsigned(2 DOWNTO 0) := b"001";

    -- cur pos
    SIGNAL ball_x : unsigned(3 DOWNTO 0) := x"5";
    SIGNAL ball_y : unsigned(3 DOWNTO 0) := x"3";
    SIGNAL ball_invalid : STD_LOGIC;
    SIGNAL curr_ball_valid : STD_LOGIC;

    SIGNAL next_ball_x : unsigned(3 DOWNTO 0) := x"5";
    SIGNAL next_ball_y : unsigned(3 DOWNTO 0) := x"3";

    SIGNAL next_pattern : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL next_pattern_valid : STD_LOGIC := '0';

    SIGNAL next_dir_out : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');

    SIGNAL led_array_internal : STD_LOGIC_VECTOR(0 TO 107) := x"000000000000000000000000000";

    FUNCTION to_std_logic(L : BOOLEAN) RETURN STD_LOGIC IS
    BEGIN
        IF (L) THEN
            RETURN '1';
        ELSE
            RETURN '0';
        END IF;
    END FUNCTION to_std_logic;

BEGIN

    -- detect out of bound
    out_of_bound : PROCESS (ball_x, ball_y, game_ctl, n_reset)
        VARIABLE c1, c2, c3, c4 : STD_LOGIC;
    BEGIN
        c1 := to_std_logic(unsigned(ball_x) = 0);
        c2 := to_std_logic(unsigned(ball_x) = 11);
        c3 := to_std_logic(unsigned(ball_y) = 0);
        c4 := to_std_logic(unsigned(ball_y) = 8);

        IF (n_reset = '0') THEN
            ball_invalid <= '0';
        ELSE
            ball_invalid <= c1 OR c2 OR c3 OR c4;
        END IF;
    END PROCESS;

    update_position : PROCESS (clk, n_reset)
        VARIABLE ball_vx : signed(3 DOWNTO 0);
        VARIABLE ball_vy : signed(3 DOWNTO 0);
        VARIABLE dir : unsigned(2 DOWNTO 0);
    BEGIN
        -- variables
        IF (next_pattern_valid = '1') THEN
            dir := next_ball_dir;
        ELSE
            dir := ball_dir;
        END IF;
        ball_vx := lookup_vx(to_integer(dir));
        ball_vy := lookup_vy(to_integer(dir));

        IF (n_reset = '0') THEN
            ball_x <= x"5"; -- init pos
            ball_y <= x"3"; -- init pos
            ball_dir <= b"001";
            led_array_internal <= x"000000000000000000000000000";
        ELSIF rising_edge(clk) THEN
            IF (game_ctl = '0' OR ball_invalid = '1') THEN
                -- end or out of bound
                ball_x <= ball_x;
                ball_y <= ball_y;
                ball_dir <= ball_dir;
            ELSIF (game_ctl = '1') THEN
                -- continue game
                led_array_internal <= led_array;
                IF (sync = '1') THEN
                    -- update location
                    ball_x <= ball_x + unsigned(ball_vx);
                    ball_y <= ball_y + unsigned(ball_vy);
                    ball_dir <= dir;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    next_ball_x <= unsigned(ball_x) + unsigned(lookup_vx(to_integer(ball_dir))) WHEN n_reset = '1' ELSE
        x"5";
    next_ball_y <= unsigned(ball_y) + unsigned(lookup_vy(to_integer(ball_dir))) WHEN n_reset = '1' ELSE
        x"3";

    ball_loc_x <= STD_LOGIC_VECTOR(ball_x);
    ball_loc_y <= STD_LOGIC_VECTOR(ball_y);
    ball_vel_x <= STD_LOGIC_VECTOR(lookup_vx(to_integer(ball_dir)));
    ball_vel_y <= STD_LOGIC_VECTOR(lookup_vy(to_integer(ball_dir)));

    ball_loc_invalid <= ball_invalid;
    curr_ball_valid <= game_ctl AND (NOT ball_invalid);

    pattern_encoder : ENTITY work.pattern_encoder
        PORT MAP(
            led_array => led_array_internal,
            next_ball_x => STD_LOGIC_VECTOR(next_ball_x),
            next_ball_y => STD_LOGIC_VECTOR(next_ball_y),
            curr_ball_x => STD_LOGIC_VECTOR(ball_x),
            curr_ball_y => STD_LOGIC_VECTOR(ball_y),
            curr_ball_valid => curr_ball_valid,
            next_pattern => next_pattern,
            next_pattern_valid => next_pattern_valid);

    steer : ENTITY work.steer
        PORT MAP(
            next_pattern => next_pattern,
            curr_dir => ball_dir,
            next_dir => next_ball_dir);

END rtl;
