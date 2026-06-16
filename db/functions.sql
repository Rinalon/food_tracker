CREATE OR REPLACE FUNCTION get_age_group(birth_date date)
RETURNS smallint
AS $$
DECLARE
    age interval := AGE(birth_date);
BEGIN
    RETURN CASE
        WHEN age < '1 year'::interval   THEN 0
        WHEN age < '4 year'::interval   THEN 1
        WHEN age < '9 year'::interval   THEN 2
        WHEN age < '19 year'::interval  THEN 3
        WHEN age < '51 year'::interval  THEN 4
        ELSE 7
    END;
END;
$$ LANGUAGE plpgsql STABLE;
