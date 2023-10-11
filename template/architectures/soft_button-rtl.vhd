ARCHITECTURE rtl OF soft_button IS
    SIGNAL but_debounced_last : STD_LOGIC;
    SIGNAL but_debounced : STD_LOGIC;
BEGIN

    edge_detect : PROCESS (clk, n_reset)
    BEGIN
        IF (n_reset = '0') THEN
            but_debounced_last <= '0';
        ELSIF rising_edge(clk) THEN
            but_debounced_last <= but_debounced;
        END IF;
    END PROCESS;

    button_out <= but_debounced AND (NOT but_debounced_last); --posedge

    debounce : ENTITY work.debounce
        PORT MAP(
            clk => clk,
            n_reset => n_reset,
            button_in => button_in,
            button_out => but_debounced);

END rtl;