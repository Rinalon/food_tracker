CREATE TABLE health_dict.nutrient_groups (
		"id"			smallint		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"			varchar(16)		UNIQUE NOT NULL
		,is_organic		bool			NOT NULL 
);

CREATE TABLE health_dict.nutrients (
		"id" 			smallint 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"			varchar(64)		NOT NULL
		,group_id		smallint		REFERENCES health_dict.nutrient_groups("id")
												ON DELETE CASCADE 
												DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE health_dict.vitamers (
		"id" 			smallint 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
		,"name"			varchar(64)		NOT NULL
		,vitamin_id		smallint		REFERENCES health_dict.nutrients("id")
												ON DELETE CASCADE 
												DEFERRABLE INITIALLY IMMEDIATE
		,activity		real			NOT NULL CHECK (activity > 0)
);

CREATE TABLE health_dict.units (
    	"id"         	smallint 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
    	,"name"      	varchar(32) 	NOT NULL
    	,symbol     	varchar(8)  	NOT NULL UNIQUE
);

CREATE TABLE health_dict.population_segments (
    	"id"             smallint 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
    	,"name"          varchar(64) 	NOT NULL
		,age_group		 smallint
    	,sex             char(1) 		CHECK (sex IN ('M', 'F'))
    	,is_pregnant     bool 			DEFAULT FALSE
    	,is_lactating    bool 			DEFAULT FALSE
    UNIQUE (age_min, age_max, sex, is_pregnant, is_lactating)
);

CREATE TABLE health_dict.recommendation_types (
    	"id"             smallint 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY
    	,abbreviation    varchar(10) 	NOT NULL UNIQUE -- 'RDA', 'UL', 'AI'
    	,full_name       varchar(64) 	NOT NULL
    	,description     text
);


CREATE TABLE health_dict.nutrient_recommendations (
    	"id"             integer 		PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    	,nutrient_id     smallint 		NOT NULL REFERENCES health_dict.nutrients(id)
                                				ON DELETE CASCADE 
												DEFERRABLE INITIALLY IMMEDIATE
    	,segment_id      smallint 		NOT NULL REFERENCES health_dict.population_segments(id)
                                				ON DELETE CASCADE 
												DEFERRABLE INITIALLY IMMEDIATE
    	,type_id         smallint 		NOT NULL REFERENCES health_dict.recommendation_types(id)
                                				ON DELETE CASCADE 
												DEFERRABLE INITIALLY IMMEDIATE
    	,"value"         numeric(12,4) 	NOT NULL
    	,unit_id         smallint 		NOT NULL REFERENCES health_dict.units(id),
    	,"source"     	 varchar(128)
    	,"link"  		 text
    UNIQUE (nutrient_id, segment_id, type_id)
);

-- Индексы для ускорения поиска
CREATE INDEX idx_recommendations_nutrient ON health_dict.nutrient_recommendations (nutrient_id);
CREATE INDEX idx_recommendations_segment   ON health_dict.nutrient_recommendations (segment_id);
CREATE INDEX idx_recommendations_type      ON health_dict.nutrient_recommendations (type_id);
