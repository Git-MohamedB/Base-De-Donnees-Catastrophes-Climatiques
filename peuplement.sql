CREATE TABLE region ( 
    region_code SERIAL PRIMARY KEY, 
    name VARCHAR NOT NULL 
);

CREATE TABLE sub_region (
    sub_region_code SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    region_code INTEGER NOT NULL REFERENCES region(region_code) ON DELETE CASCADE
);

CREATE TABLE country (
    country_code SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    iso2 VARCHAR, 
    iso3 VARCHAR NOT NULL,
    sub_region_code INTEGER NOT NULL REFERENCES sub_region(sub_region_code) ON DELETE CASCADE 
);

CREATE TABLE disaster (
    disaster_code SERIAL PRIMARY KEY,
    disaster VARCHAR NOT NULL 
);

CREATE TABLE climate_disaster (
    country_code INTEGER NOT NULL REFERENCES country(country_code) ON DELETE CASCADE,
    disaster_code INTEGER NOT NULL REFERENCES disaster(disaster_code) ON DELETE CASCADE,
    year INTEGER NOT NULL,
    number INTEGER NOT NULL,
    PRIMARY KEY (country_code, disaster_code, year)
);

CREATE TEMP TABLE temp_data (
    country VARCHAR NOT NULL,
    iso2 VARCHAR,
    iso3 VARCHAR NOT NULL,
    region_code INTEGER,
    region VARCHAR NOT NULL,
    sub_region_code INTEGER,
    sub_region VARCHAR NOT NULL,
    disaster VARCHAR NOT NULL,
    year INTEGER NOT NULL,
    number INTEGER NOT NULL
);

\copy temp_data(country, iso2, iso3, region_code, region, sub_region_code, sub_region, disaster, year, number) FROM 'Documents/sae_bdd/donnees.csv' CSV HEADER;



INSERT INTO region (name)
SELECT DISTINCT region
FROM temp_data
WHERE region IS NOT NULL;

INSERT INTO sub_region (name, region_code)
SELECT DISTINCT sub_region, region.region_code
FROM temp_data
JOIN region ON temp_data.region = region.name
WHERE sub_region IS NOT NULL;

INSERT INTO country (name, iso2, iso3, sub_region_code)
SELECT DISTINCT temp_data.country, temp_data.iso2, temp_data.iso3, sub_region.sub_region_code
FROM temp_data
JOIN sub_region ON temp_data.sub_region = sub_region.name
WHERE temp_data.country IS NOT NULL;

INSERT INTO disaster (disaster)
SELECT DISTINCT disaster
FROM temp_data
WHERE disaster IS NOT NULL;

INSERT INTO climate_disaster (country_code, disaster_code, year, number)
SELECT country.country_code, disaster.disaster_code, temp_data.year, temp_data.number
FROM temp_data
JOIN country ON temp_data.country = country.name
JOIN disaster ON temp_data.disaster = disaster.disaster
WHERE temp_data.year IS NOT NULL AND temp_data.number IS NOT NULL;

DROP TABLE temp_data;
