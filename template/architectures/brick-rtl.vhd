ARCHITECTURE rtl OF brick IS

SIGNAL s_previous_reset : std_logic;
    
BEGIN
    dff : PROCESS (clk, n_reset) IS
        BEGIN	
        IF( n_reset = '0') THEN
            brick_loc_valid <= sw;
            s_previous_reset <= '0';
        ELSIF (rising_edge(clk)) THEN
            IF (game_ctl = '0' AND s_previous_reset = '0') THEN 
                brick_loc_valid <= sw;
                s_previous_reset <= '1';
            ELSE 
                IF sync = '1' THEN
                    IF(signed(ball_loc_x) + signed(ball_vel_x) = signed(loc_x)  OR signed(ball_loc_x) + signed(ball_vel_x) = signed(loc_x)+ to_signed(1,4)) THEN 
                        IF(signed(ball_loc_y) + signed(ball_vel_y)= signed(loc_y)) THEN 
                            brick_loc_valid <= '0';
                        END IF;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS dff;   
    brick_loc_x <= loc_x;
    brick_loc_y <= loc_y;
END rtl;