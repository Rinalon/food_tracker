CREATE TABLE products (
		"id"			integer 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"		 	varchar(128)
		,variety		varchar(128)
		,protein 	 	smallint		DEFAULT 0
		,fat 		 	smallint		DEFAULT 0
		,carbohydrates	smallint		DEFAULT 0
		,UNIQUE("name", variety)
);

CREATE TABLE categories (
		"id"			smallint 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"			varchar(16)
);

CREATE TABLE vitamins (
		"id"			smallint		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"			varchar(4)
		,recommended	numeric
		--,per			interval
);

CREATE TABLE vitamers (
		"id" 			smallint 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"			varchar(64)
		,recommended	numeric
);


CREATE TABLE vitamin_vitamer(
		vitamer_id		smallint		REFERENCES vitamers("id")
		,vitamin_id		smallint		REFERENCES vitamins("id")
		,PRIMARY KEY(vitamer_id, vitamin_id)
);

CREATE TABLE product_vitamer(
		product_id		integer			REFERENCES products("id")
		,vitamer_id		smallint		REFERENCES vitamers"id")
		,PRIMARY KEY(product_id, vitamer_id)
); 

CREATE TABLE product_category(
		product_id		integer			REFERENCES products("id")
		,category_id	integer			REFERENCES categories("id")
		,PRIMARY KEY(product_id, category_id)
); 

