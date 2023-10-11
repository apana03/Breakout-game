ARCHITECTURE rtl OF game_ctl IS
   
TYPE state IS (idle, play, finish);

SIGNAL s_state : state;
SIGNAL s_no_bricks , s_end_game, s_game_without_bricks : std_logic;

BEGIN

    s_no_bricks <= '1' WHEN brick_loc_valid = "0000" ELSE '0';

    s_end_game <= '1' WHEN (s_state = play AND (ball_loc_invalid = '1' OR (s_game_without_bricks ='0' AND s_no_bricks = '1'))) ELSE '0';

    game_ctl_out <= '0' WHEN n_reset ='0' ELSE 
        '0' WHEN s_end_game = '1' ELSE 
            '1' WHEN s_state = play else '0';


    dff : PROCESS (clk, n_reset) IS
    BEGIN	
        IF( n_reset = '0') THEN
            s_state <= idle;
            s_game_without_bricks <= '0';
        ELSIF (rising_edge(clk)) THEN
            IF(s_state = idle) THEN
                s_game_without_bricks <= '0';
                IF(but_left = '1' OR but_right = '1') THEN
                    IF(s_no_bricks = '1') THEN 
                        s_game_without_bricks <= '1';
                    END IF;
                    s_state <= play;
                END IF;
            ELSIF(s_state = play) THEN 
                IF(s_end_game = '1') THEN 
                    s_state <= finish;
                END IF;
            END IF;
        END IF;
    END PROCESS dff;   

END rtl;