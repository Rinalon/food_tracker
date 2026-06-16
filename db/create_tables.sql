CREATE TABLE food_data.products (
		"id"			integer 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"		 	varchar(128)	NOT NULL
		,variety		varchar(128)	DEFAULT ''
		,protein 	 	numeric(5, 2)	NOT NULL CHECK (protein >= 0.00)			DEFAULT 0.00
		,fat 		 	numeric(5, 2)	NOT NULL CHECK (fat >= 0.00) 				DEFAULT 0.00	
		,carbohydrates	numeric(5, 2)	NOT NULL CHECK (carbohydrates >= 0.00) 		DEFAULT 0.00
		,UNIQUE("name", variety)
);

CREATE TABLE food_data.categories (
		"id"			smallint 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"			varchar(16)		UNIQUE NOT NULL
);


CREATE TABLE food_data.product_vitamer(
		product_id		integer			REFERENCES food_data.products("id") 
												ON DELETE CASCADE 
												DEFERRABLE INITIALLY IMMEDIATE
		,vitamer_id		smallint		REFERENCES health_dict.vitamers("id") 
												ON DELETE CASCADE 
												DEFERRABLE INITIALLY IMMEDIATE
		,PRIMARY KEY(product_id, vitamer_id)
); 

CREATE TABLE food_data.product_category(
		product_id		integer			REFERENCES food_data.products("id") 
												ON DELETE CASCADE 
												DEFERRABLE INITIALLY IMMEDIATE
		,category_id	integer			REFERENCES food_data.categories("id") 
												ON DELETE CASCADE 
												DEFERRABLE INITIALLY IMMEDIATE
		,PRIMARY KEY(product_id, category_id)
); 
