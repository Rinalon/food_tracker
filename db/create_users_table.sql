CREATE TABLE users.users(
		"id"			integer			PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,email			varchar(256)	NOT NULL CHECK (email ~ '^([\w]+[.-]{0,1}[\w]+)+@([a-zA-Z0-9]+([.-])*[a-zA-Z0-9]+)+\.+[a-zA-Z]{2,}$')
		,password_hash	varchar(512)
		,google_id		varchar(1024)
		,"name"			varchar(64)		NOT NULL
		,birth_date		date			NOT NULL CHECK (AGE(birth_date) < '121 year'::interval)
		,height			smallint		NOT NULL CHECK (height BETWEEN 40 AND 260)
		,weight			float			NOT NULL CHECK (weight	> 1.5)
		,sex			char(1)			NOT NULL CHECK (sex IN ('M', 'F'))
		,pregnant		smallint		CHECK ((pregnant BETWEEN 0 AND 3) AND sex = 'F') DEFAULT 0
												-- 0 - not, 1 - 1st trimester, 2 - 2nd trimester, 3 - 3rd trimester
		,is_lactating	bool			DEFAULT FALSE			
);