CREATE TABLE products (
		"id"			integer 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"		 	varchar(128)	NOT NULL
		,variety		varchar(128)	DEFAULT ''
		,protein 	 	numeric(5, 2)	NOT NULL CHECK (protein >= 0.00)			DEFAULT 0.00
		,fat 		 	numeric(5, 2)	NOT NULL CHECK (fat >= 0.00) 				DEFAULT 0.00	
		,carbohydrates	numeric(5, 2)	NOT NULL CHECK (carbohydrates >= 0.00) 		DEFAULT 0.00
		,UNIQUE("name", variety)
);

CREATE TABLE categories (
		"id"			smallint 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"			varchar(16)		UNIQUE NOT NULL
);

CREATE TABLE vitamins (
		"id"			smallint		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"			varchar(4)		UNIQUE NOT NULL
		,recommended	numeric(5, 2)	NOT NULL CHECK (recommended > 0.00) 		DEFAULT 0.00
);

CREATE TABLE vitamers (
		"id" 			smallint 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"			varchar(64)		NOT NULL
		,recommended	numeric			NOT NULL CHECK (recommended > 0.00)			DEFAULT 0.00 
);


CREATE TABLE vitamin_vitamer(
		vitamer_id		smallint		REFERENCES vitamers("id")
		,vitamin_id		smallint		REFERENCES vitamins("id")
		,PRIMARY KEY(vitamer_id, vitamin_id)
);

CREATE TABLE product_vitamer(
		product_id		integer			REFERENCES products("id")
		,vitamer_id		smallint		REFERENCES vitamers("id")
		,PRIMARY KEY(product_id, vitamer_id)
); 

CREATE TABLE product_category(
		product_id		integer			REFERENCES products("id")
		,category_id	integer			REFERENCES categories("id")
		,PRIMARY KEY(product_id, category_id)
); 

