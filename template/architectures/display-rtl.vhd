ARCHITECTURE rtl OF display IS

BEGIN
    dff : PROCESS (clk, n_reset) IS
        BEGIN	
		IF( n_reset = '0') THEN
			led_array <= std_logic_vector (to_unsigned(0 , 108));
        
		ELSIF (rising_edge(clk)) THEN

            led_array <= std_logic_vector (to_unsigned(0 , 108));
            
            led_array(coord_to_ind(ball_loc_x, ball_loc_y)) <= '1';
        
            FOR i IN 0 TO 3 LOOP 
                IF ( brick_loc_valid_arr(i) = '1' ) THEN
                    led_array(coord_to_ind(brick_loc_x_arr(i), brick_loc_y_arr(i))) <= '1';
                    led_array(coord_to_ind(to_integer (unsigned(brick_loc_x_arr(i))) + 1, to_integer(unsigned(brick_loc_y_arr(i))))) <= '1';
                END IF; 
            END LOOP;
			
            FOR i IN 0 TO 8 LOOP 
                led_array(coord_to_ind(0,i)) <= '1';
                led_array(coord_to_ind(11,i)) <= '1';
            END LOOP;
            
            FOR i IN 0 TO 11 LOOP 
                led_array(coord_to_ind(i,8)) <= '1';   
            END LOOP;

            led_array(coord_to_ind(1,0)) <= '1';
            led_array(coord_to_ind(10,0)) <= '1';

            led_array(coord_to_ind(to_integer(unsigned(paddle_loc_x)) - 1, 0)) <= '1';
            led_array(coord_to_ind(to_integer(unsigned(paddle_loc_x)) + 1, 0)) <= '1';
            led_array(coord_to_ind(to_integer(unsigned(paddle_loc_x)) , 0)) <= '1';

		END IF;
	END PROCESS dff;

END rtl;