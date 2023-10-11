ARCHITECTURE rtl OF pattern_encoder IS

    SIGNAL pos_00, pos_01, pos_02, pos_10, pos_11, pos_12, pos_20, pos_21, pos_22 : STD_LOGIC := '0';
    SIGNAL nx, ny, cx, cy : signed(15 DOWNTO 0);
    SIGNAL led_array_internal : STD_LOGIC_VECTOR(0 TO 153) := (OTHERS => '0'); -- 14 * 11;

    FUNCTION if_then_else(cond : BOOLEAN;
        th : STD_LOGIC;
        el : STD_LOGIC) RETURN STD_LOGIC IS
    BEGIN
        IF (cond) THEN
            RETURN th;
        ELSE
            RETURN el;
        END IF;
    END FUNCTION if_then_else;

    FUNCTION coord_to_ind(x : signed(15 DOWNTO 0);
        y : signed(15 DOWNTO 0)) RETURN INTEGER IS
    BEGIN
        RETURN (10 - to_integer(y)) * 14 + to_integer(x);
    END FUNCTION coord_to_ind;
BEGIN

    map_leds : PROCESS (led_array)
        VARIABLE idx : INTEGER;
        VARIABLE idx2 : INTEGER;
    BEGIN
        FOR i IN 1 TO 9 LOOP
            FOR j IN 1 TO 12 LOOP
                idx := i * 14 + j;
                idx2 := (i - 1) * 12 + j - 1;
                led_array_internal(idx) <= led_array(idx2);
            END LOOP;
        END LOOP;
    END PROCESS;

    get_pattern : PROCESS (curr_ball_valid, next_ball_x, next_ball_y, nx, ny, cx, cy, pos_00, pos_01, pos_02, pos_10, pos_11, pos_12, pos_20, pos_21, pos_22)
        VARIABLE i_00, i_01, i_02, i_10, i_11, i_12, i_20, i_21, i_22 : INTEGER;
        ALIAS p8 IS pos_00;
        ALIAS p7 IS pos_01;
        ALIAS p6 IS pos_02;
        ALIAS p5 IS pos_10;
        ALIAS p4 IS pos_11;
        ALIAS p3 IS pos_12;
        ALIAS p2 IS pos_20;
        ALIAS p1 IS pos_21;
        ALIAS p0 IS pos_22;
    BEGIN

        nx <= resize(signed('0' & next_ball_x), nx'length);
        cx <= resize(signed('0' & curr_ball_x), cx'length);
        cy <= resize(signed('0' & curr_ball_y), cy'length);
        IF (unsigned(next_ball_y) > 8) THEN
            ny <= resize(signed(next_ball_y), ny'length);
        ELSE
            ny <= resize(signed('0' & next_ball_y), ny'length);
        END IF;
        -- report integer'image(to_integer(nx));
        -- report integer'image(to_integer(ny));
        -- report integer'image(to_integer(cx));
        -- report integer'image(to_integer(cy));
        -- report integer'image(to_integer((ny + 2) * 14 + nx));

        -- calculate index
        -- expand coordinates by 1
        i_00 := coord_to_ind(nx, ny + 2);
        i_10 := coord_to_ind(nx, ny + 1);
        i_20 := coord_to_ind(nx, ny + 0);
        i_01 := i_00 + 1;
        i_11 := i_10 + 1;
        i_21 := i_20 + 1;
        i_02 := i_01 + 1;
        i_12 := i_11 + 1;
        i_22 := i_21 + 1;

        IF (curr_ball_valid = '1') THEN
            -- access led pos
            pos_00 <= if_then_else((nx >= 1 AND nx <= 11 AND ny >= 0 AND ny <= 7) AND (nx - 1 /= cx OR ny + 1 /= cy), led_array_internal((i_00)), '0');
            pos_01 <= if_then_else((nx >= 0 AND nx <= 11 AND ny >= 0 AND ny <= 7) AND (nx /= cx OR ny + 1 /= cy), led_array_internal((i_01)), '0');
            pos_02 <= if_then_else((nx >= 0 AND nx <= 10 AND ny >= 0 AND ny <= 7) AND (nx + 1 /= cx OR ny + 1 /= cy), led_array_internal((i_02)), '0');

            pos_10 <= if_then_else((nx >= 1 AND nx <= 11 AND ny >= 0 AND ny <= 8) AND (nx - 1 /= cx OR ny /= cy), led_array_internal((i_10)), '0');
            pos_11 <= if_then_else((nx >= 0 AND nx <= 11 AND ny >= 0 AND ny <= 8) AND (nx /= cx OR ny /= cy), led_array_internal((i_11)), '0');
            pos_12 <= if_then_else((nx >= 0 AND nx <= 10 AND ny >= 0 AND ny <= 8) AND (nx + 1 /= cx OR ny /= cy), led_array_internal((i_12)), '0');

            pos_20 <= if_then_else((nx >= 1 AND nx <= 11 AND ny >= 1 AND ny <= 8) AND (nx - 1 /= cx OR ny - 1 /= cy), led_array_internal((i_20)), '0');
            pos_21 <= if_then_else((nx >= 0 AND nx <= 11 AND ny >= 1 AND ny <= 8) AND (nx /= cx OR ny - 1 /= cy), led_array_internal((i_21)), '0');
            pos_22 <= if_then_else((nx >= 0 AND nx <= 10 AND ny >= 1 AND ny <= 8) AND (nx + 1 /= cx OR ny - 1 /= cy), led_array_internal((i_22)), '0');
            next_pattern(3) <= ((NOT p8) AND (NOT p6) AND (NOT p2) AND (NOT p0))
            OR ((NOT p8) AND (NOT p7) AND (NOT p5) AND p4 AND p3 AND (NOT p2) AND (NOT p1) AND (NOT p0))
            OR ((NOT p7) AND (NOT p6) AND p5 AND p4 AND (NOT p3) AND (NOT p2) AND (NOT p1) AND (NOT p0))
            OR ((NOT p8) AND (NOT p7) AND (NOT p6) AND p5 AND p4 AND (NOT p2) AND p1)
            OR ((NOT p8) AND (NOT p7) AND (NOT p6) AND p5 AND p4 AND p3 AND p1 AND (NOT p0));
            next_pattern(2) <= ((NOT p7) AND (NOT p5) AND (NOT p1))
            OR ((NOT p5) AND p2)
            OR (p5 AND (NOT p3))
            OR ((NOT p1) AND p0)
            OR ((NOT p8) AND (NOT p7) AND (NOT p6) AND p5 AND p4 AND (NOT p2) AND p1)
            OR (p6 AND (NOT p5))
            OR (p8 AND (NOT p1));
            next_pattern(1) <= ((NOT p5) AND p3)
            OR ((NOT p7) AND (NOT p3) AND (NOT p1))
            OR ((NOT p1) AND p0)
            OR (p2 AND (NOT p1))
            OR ((NOT p8) AND (NOT p7) AND (NOT p6) AND p4 AND p3 AND p2 AND (NOT p0))
            OR (p6 AND (NOT p5))
            OR (p8 AND (NOT p5));
            next_pattern(0) <= ((NOT p1) AND p0)
            OR ((NOT p8) AND (NOT p6) AND (NOT p5) AND (NOT p2) AND p1 AND (NOT p0))
            OR (p2 AND (NOT p1))
            OR ((NOT p3) AND (NOT p1))
            OR ((NOT p8) AND (NOT p7) AND (NOT p6) AND p5 AND p4 AND p3 AND p2 AND (NOT p0))
            OR (p6 AND (NOT p4) AND (NOT p1))
            OR (p6 AND p5 AND (NOT p1))
            OR (p7 AND p6 AND (NOT p1))
            OR (p8 AND (NOT p1));
            next_pattern_valid <= pos_11;
        ELSE
            next_pattern_valid <= '0';
        END IF;
    END PROCESS;
END rtl;