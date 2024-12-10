

-- 取得每月借項加總
CREATE OR REPLACE FUNCTION get_monthly_summary_debit(p_year INT, p_month INT)
RETURNS TABLE (
    year INT,
    month INT,
    code character varying(4),
    name character varying(4),
    sum_amount NUMERIC
) as $$
BEGIN
    RETURN QUERY
    SELECT
        to_char(j.tx_time, 'YYYY')::INT as year,
        to_char(j.tx_time, 'MM')::INT as month,
        s.code,
        s.name,
        SUM(amount) as sum_amount
    FROM
        subject s, journal_record j
    WHERE
        j.debit = s.code AND
        LEFT(j.debit, 1) = '2' AND
        to_char(j.tx_time, 'YYYY')::INT = p_year AND
        to_char(j.tx_time, 'MM')::INT = p_month
    GROUP BY
        to_char(j.tx_time, 'YYYY'), to_char(j.tx_time, 'MM'), s.code
    ORDER BY
        to_char(j.tx_time, 'YYYY'), to_char(j.tx_time, 'MM'), s.code;
END;
$$ LANGUAGE plpgsql;


-- 取得每月貸項加總
CREATE OR REPLACE FUNCTION get_monthly_summary_credit(p_year INT, p_month INT)
RETURNS TABLE (
    year INT,
    month INT,
    code character varying(4),
    name character varying(4),
    sum_amount NUMERIC
) as $$
BEGIN
    RETURN QUERY
    SELECT
        to_char(j.tx_time, 'YYYY')::INT as year,
        to_char(j.tx_time, 'MM')::INT as month,
        s.code,
        s.name,
        SUM(amount) as sum_amount
    FROM
        subject s, journal_record j
    WHERE
        j.credit = s.code AND
        LEFT(j.credit, 1) = '1' AND
        to_char(j.tx_time, 'YYYY')::INT = p_year AND
        to_char(j.tx_time, 'MM')::INT = p_month
    GROUP BY
        to_char(j.tx_time, 'YYYY'), to_char(j.tx_time, 'MM'), s.code
    ORDER BY
        to_char(j.tx_time, 'YYYY'), to_char(j.tx_time, 'MM'), s.code;
END;
$$ LANGUAGE plpgsql;

