LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE utils IS
    TYPE array_loc_x IS ARRAY(0 TO 3) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
    TYPE array_loc_y IS ARRAY(0 TO 3) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
    TYPE array_loc_valid IS ARRAY(0 TO 3) OF STD_LOGIC;

    FUNCTION coord_to_ind(x : STD_LOGIC_VECTOR(3 DOWNTO 0);
        y : STD_LOGIC_VECTOR(3 DOWNTO 0)
    ) RETURN INTEGER;
    FUNCTION coord_to_ind(x : INTEGER;
        y : INTEGER
    ) RETURN INTEGER;

    CONSTANT refresh_count : INTEGER := 1;
    CONSTANT debounce_count : INTEGER := 8;

    -- CONSTANT refresh_count : INTEGER := 12000000 / 4; -- 4Hz
    -- CONSTANT debounce_count : INTEGER := 12000000 / 8; -- 0.125s interval 
END PACKAGE utils;

PACKAGE BODY utils IS

    FUNCTION coord_to_ind(x : STD_LOGIC_VECTOR(3 DOWNTO 0);
        y : STD_LOGIC_VECTOR(3 DOWNTO 0)) RETURN INTEGER IS
    BEGIN
        RETURN (8 - to_integer(unsigned(y))) * 12 + to_integer(unsigned(x));
    END FUNCTION coord_to_ind;

    FUNCTION coord_to_ind(x : INTEGER;
        y : INTEGER) RETURN INTEGER IS
    BEGIN
        RETURN (8 - y) * 12 + x;
    END FUNCTION coord_to_ind;
END PACKAGE BODY utils;
