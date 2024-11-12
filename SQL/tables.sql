--會計科目檔
CREATE TABLE public."SUBJECT"
(
    "CODE" character varying(4) NOT NULL,
    "NAME" character varying(20) NOT NULL,
    "CREATE_TIME" timestamp without time zone NOT NULL DEFAULT now(),
    PRIMARY KEY ("CODE")
);

ALTER TABLE IF EXISTS public."SUBJECT"
    OWNER to postgres;

COMMENT ON TABLE public."SUBJECT"
    IS '會計科目檔';

COMMENT ON COLUMN public."SUBJECT"."CODE"
    IS '會計科目代號';

COMMENT ON COLUMN public."SUBJECT"."NAME"
    IS '會計科目名稱';

COMMENT ON COLUMN public."SUBJECT"."CREATE_TIME"
    IS '建立時間';

--日記帳檔
CREATE TABLE public."JOURNAL_RECORD" (
	"JOURNAL_RECORD_KEY" bigserial NOT NULL,
    PRIMARY KEY ("JOURNAL_RECORD_KEY"),
	"TX_TIME" timestamp without time zone NOT NULL,
	"DEBIT" character varying(4) NOT NULL,
	"CREDIT" character varying(4) NOT NULL,
	"AMOUNT" bigint NOT NULL,
	"MEMO" character varying(10) NOT NULL,
	"CREATE_TIME" timestamp without time zone NULL DEFAULT now()
);

ALTER TABLE IF EXISTS public."JOURNAL_RECORD"
    OWNER to postgres;

COMMENT ON TABLE public."JOURNAL_RECORD"
    IS '日記帳檔';

COMMENT ON COLUMN public."JOURNAL_RECORD"."JOURNAL_RECORD_KEY"
    IS '日記帳檔流水號';

COMMENT ON COLUMN public."JOURNAL_RECORD"."TX_TIME"
    IS '交易時間';

COMMENT ON COLUMN public."JOURNAL_RECORD"."DEBIT"
    IS '借項';

COMMENT ON COLUMN public."JOURNAL_RECORD"."CREDIT"
    IS '貸項';

COMMENT ON COLUMN public."JOURNAL_RECORD"."AMOUNT"
    IS '金額';

COMMENT ON COLUMN public."JOURNAL_RECORD"."MEMO"
    IS '摘要';

COMMENT ON COLUMN public."JOURNAL_RECORD"."CREATE_TIME"
    IS '建立時間';
