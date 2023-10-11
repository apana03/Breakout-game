ARCHITECTURE rtl OF timer IS

SIGNAL s_present_count : INTEGER RANGE 0 to count;

BEGIN

	flag <= '1' when (s_present_count = count - 1) else '0';	

	counter : PROCESS(clk,n_reset) IS
	BEGIN
		IF (n_reset = '0') THEN 
			s_present_count <= 0;
		ELSIF(rising_edge(clk)) THEN 
			IF reset ='1' THEN 
				s_present_count <= 0;
			ELSE
				IF (s_present_count = count - 1)  then
					s_present_count <= 0;
				ELSE	 
					s_present_count <= s_present_count + 1;
				END IF;
			END IF;
		END IF;
	END PROCESS;

	
END rtl;