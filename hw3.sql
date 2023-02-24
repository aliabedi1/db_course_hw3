-- 2

Select * from student as S where S.id not in (select T.student_id from takes as T)
Union 
Select * from student as S where S.id in( select T.student_id from takes as T)

-- 3
-- 3.1
select bname from boats where color = "red";
-- 3.2
select bname from (boats inner join reserves on boats.bid = reserves.bid) where color = "red";
-- 3.3
select sname , bname from 
    (select sname , bname , count(*) from
        sailors inner join reserves on reserves.sid = sailors.sid
            group by bid
            order by count(*))
offset 1 fetch next 1 row only;

-- 3.4
select sname, count from (select sname , count(*) from reserves inner join sailors on Reserves.sid = sailors.sid group by bid) where count(*) > 0;


-- 4


DROP TABLE IF EXISTS keyvalue;
CREATE TABLE keyvalue (
id SERIAL,
key VARCHAR(128) UNIQUE,
value VARCHAR(128) UNIQUE,
created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
PRIMARY KEY(id)
);


CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN

  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS set_timestamp ON keyvalue CASCADE;
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON keyvalue
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

INSERT INTO public.keyvalue(
	 key, value)
	VALUES ( 2123, 1231);
	
	INSERT INTO public.keyvalue(
	 key, value)
	VALUES ( 112323, 3121233);
	
	INSERT INTO public.keyvalue(
	 key, value)
	VALUES ( 12312125, 57632);
	
	
	UPDATE public.keyvalue
	SET key=97856, value=34757
	WHERE id = 2;
	
	UPDATE public.keyvalue
	SET key=91156, value=73301
	WHERE id = 3;