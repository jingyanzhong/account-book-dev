-- Database: account_book

-- DROP DATABASE IF EXISTS account_book;

DO $$
declare
	objects TEXT[] := ARRAY[
        --FUNCTION
        'function|get_monthly_summary_debit',
        'function|get_monthly_summary_credit',

        --VIEW
        'view|view_journal_record_year_month',

        --TABLE
        'table|journal_record',
        'table|journal_memo',
        'table|subject'
    ];
    obj TEXT;
    obj_type TEXT;
    obj_name TEXT;
BEGIN
    --移除列表
    FOREACH obj IN ARRAY objects LOOP
        -- 按 "|" 分割对象字符串
        obj_type := split_part(obj, '|', 1);
        obj_name := split_part(obj, '|', 2);

        -- DROP
        CASE obj_type
            WHEN 'function' THEN
                EXECUTE FORMAT('DROP FUNCTION IF EXISTS %I', obj_name);
            WHEN 'view' THEN
                EXECUTE 'DROP VIEW IF EXISTS ' || obj_name;
            WHEN 'table' THEN
                EXECUTE FORMAT('DROP TABLE IF EXISTS %I', obj_name);
            ELSE
                RAISE WARNING 'Unsupported object type: %', obj_type;
        END CASE;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

