ARCHITECTURE rtl OF steer IS
    ALIAS p3 IS next_pattern(3);
    ALIAS p2 IS next_pattern(2);
    ALIAS p1 IS next_pattern(1);
    ALIAS p0 IS next_pattern(0);
    ALIAS d2 IS curr_dir(2);
    ALIAS d1 IS curr_dir(1);
    ALIAS d0 IS curr_dir(0);
BEGIN

    next_dir(2) <= (p3 AND (NOT p0) AND d1)
    OR (p3 AND p1 AND (NOT d2) AND (NOT d0))
    OR (p1 AND p0 AND d1)
    OR ((NOT p3) AND (NOT p1) AND (NOT p0))
    OR (p3 AND (NOT p2) AND p0 AND (NOT d1));
    next_dir(1) <= (p3 AND (NOT p0) AND d2)
    OR ((NOT p3) AND p0 AND d2)
    OR (p3 AND p2 AND (NOT d1) AND d0)
    OR (p2 AND p0 AND d2)
    OR (p3 AND (NOT p1) AND p0 AND (NOT d2))
    OR ((NOT p3) AND (NOT p0) AND (NOT d2));
    next_dir(0) <= ((NOT p3) AND (NOT p2) AND d2)
    OR ((NOT p2) AND p1 AND (NOT d1))
    OR ((NOT p3) AND (NOT p0) AND (NOT d0))
    OR ((NOT p2) AND (NOT d2) AND (NOT d1) AND (NOT d0))
    OR ((NOT p2) AND (NOT p1) AND (NOT p0) AND d1 AND d0)
    OR (p3 AND (NOT p2) AND p0 AND (NOT d0))
    OR (p3 AND (NOT p1) AND (NOT p0) AND d2 AND d0)
    OR (p3 AND p1 AND p0 AND (NOT d1))
    OR ((NOT p3) AND p2 AND p1 AND d1 AND d0)
    OR ((NOT p3) AND p1 AND d2 AND d0)
    OR (p1 AND p0 AND (NOT d2) AND (NOT d1))
    OR (p1 AND d2 AND d1 AND d0)
    OR (p3 AND p2 AND p1 AND p0 AND (NOT d2));
END rtl;