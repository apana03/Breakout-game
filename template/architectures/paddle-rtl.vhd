ARCHITECTURE rtl OF paddle IS

SIGNAL s_paddle_x : STD_LOGIC_VECTOR (3 downto 0);

BEGIN
    
    dff: PROCESS ( clk, n_reset) IS
    BEGIN
        IF( n_reset = '0') THEN
            s_paddle_x <= "0101";
        ELSIF (rising_edge(clk)) THEN
            IF (game_ctl = '1') THEN
                IF (but_left = '1' AND but_right = '0') THEN
                    IF(to_integer(unsigned(s_paddle_x)) > 3) THEN 
                        s_paddle_x <= std_logic_vector (unsigned(s_paddle_x) - 1) ;
                    END IF;
                ELSIF(but_left = '0' AND but_right = '1') THEN 
                    IF(to_integer(unsigned(s_paddle_x)) < 8) THEN 
                        s_paddle_x <= std_logic_vector (unsigned(s_paddle_x) + 1) ;
                     END IF;
                END IF;
            END IF;				
        END IF;
    END PROCESS dff;

    paddle_loc_x <= s_paddle_x;
END rtl;