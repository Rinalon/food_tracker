
CREATE TABLE health_dict.vitamins (
		"id"			smallint		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"			varchar(4)		UNIQUE NOT NULL
);

CREATE TABLE health_dict.vitamers (
		"id" 			smallint 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"			varchar(64)		NOT NULL
);


CREATE TABLE health_dict.vitamin_vitamer(
		vitamer_id		smallint		REFERENCES health_dict.vitamers("id") 
												ON DELETE CASCADE 
												DEFERRABLE INITIALLY IMMEDIATE
		,vitamin_id		smallint		REFERENCES health_dict.vitamins("id")
												ON DELETE CASCADE 
												DEFERRABLE INITIALLY IMMEDIATE
		,PRIMARY KEY(vitamer_id, vitamin_id)
);