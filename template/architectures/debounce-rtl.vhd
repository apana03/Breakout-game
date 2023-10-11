ARCHITECTURE rtl OF debounce IS

SIGNAL s_diff1, s_diff2, s_diff3, s_diff4, s_reset, s_clear, s_edge_detect: std_logic; 

BEGIN
	dff1:PROCESS (clk, n_reset) IS
	BEGIN
		IF( n_reset = '0') THEN
			s_diff1 <=  '0';
		ELSIF (rising_edge(clk)) THEN
			s_diff1 <= button_in AND (NOT s_clear);				
		END IF;
	END PROCESS dff1;
	
	dff2: PROCESS ( clk, n_reset) IS
	BEGIN
		IF( n_reset = '0') THEN
			s_diff2 <=  '0';
		ELSIF (rising_edge(clk)) THEN
			s_diff2 <= s_diff1 AND (NOT s_clear);				
		END IF;
	END PROCESS dff2;
	
	
	dff3: PROCESS ( clk, n_reset) IS
	BEGIN
		IF( n_reset = '0') THEN
			s_diff3 <=  '0';
		ELSIF (rising_edge(clk)) THEN
			s_diff3 <= s_diff2 AND (NOT s_clear);				
		END IF;
	END PROCESS dff3;
	
	dff4: PROCESS ( clk, n_reset) IS
	BEGIN	
		IF( n_reset = '0') THEN
			s_diff4 <=  '0';
		ELSIF (rising_edge(clk)) THEN
			s_diff4 <= (s_edge_detect OR s_diff4) AND (NOT s_clear);
		END IF;
	END PROCESS dff4;

	button_out <= s_diff4;

	timer_val : ENTITY work.timer PORT MAP (
		clk => clk,
		n_reset => n_reset,
		reset=> s_reset,
		flag => s_clear);

	timer_ctrl : PROCESS (clk, n_reset) IS
	BEGIN
		IF n_reset = '0' THEN
			s_reset <= '1';
		ELSIF rising_edge(clk) THEN
			IF (s_reset = '1') THEN 
				s_reset <= NOT s_edge_detect;	
			ELSE 
				s_reset <= s_clear;
			END IF;
		END IF;
	END PROCESS timer_ctrl;

	s_edge_detect <= '0' WHEN n_reset = '0' ELSE (s_diff2 AND (NOT s_diff3));

END rtl;