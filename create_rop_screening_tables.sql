CREATE DATABASE rop_screening_db;

USE rop_screening_db;

CREATE TABLE baby
(
baby_id INT AUTO_INCREMENT PRIMARY KEY,
firstname VARCHAR(50) NOT NULL DEFAULT "baby",
lastname VARCHAR(50) NOT NULL,
gender ENUM ("male", "female") NOT NULL,
date_of_birth DATE DEFAULT (CURDATE()), 
postmenstrual_age_weeks VARCHAR(50) NOT NULL
);

CREATE TABLE risk
(
risk_id INT AUTO_INCREMENT PRIMARY KEY,
baby_id INT, FOREIGN KEY (baby_id) REFERENCES baby(baby_id),
gestational_age_at_birth_weeks INT NOT NULL,
birthweight_grams INT NOT NULL,
is_eligible_for_screening BOOLEAN DEFAULT TRUE NOT NULL
);


CREATE TABLE fundus
(
fundus_id INT AUTO_INCREMENT PRIMARY KEY,
baby_id INT, FOREIGN KEY (baby_id) REFERENCES baby(baby_id),
vessels_end ENUM("zone 1", "zone 2", "zone 3"),
is_ROP_Zone1 BOOLEAN DEFAULT FALSE NOT NULL,
is_ROP_Zone2 BOOLEAN DEFAULT FALSE NOT NULL,
is_ROP_Zone3 BOOLEAN DEFAULT FALSE NOT NULL
);


CREATE TABLE ROP
(
ROP_id INT AUTO_INCREMENT PRIMARY KEY,
fundus_id INT, FOREIGN KEY (fundus_id) REFERENCES fundus(fundus_id),
stage ENUM ("No ROP", "stage 1", "stage 2", "stage 3+") NOT NULL,
is_plus_disease BOOLEAN DEFAULT FALSE NOT NULL,
is_preplus_disease BOOLEAN DEFAULT FALSE NOT NULL
);

CREATE TABLE treatment
(
treatment_id INT AUTO_INCREMENT PRIMARY KEY,
ROP_id INT, FOREIGN KEY (ROP_id) REFERENCES ROP(ROP_id),
requires_treatment BOOLEAN DEFAULT FALSE NOT NULL,
treatment_date DATE
);

CREATE TABLE screening_schedule
(
screening_id INT AUTO_INCREMENT PRIMARY KEY,
risk_id INT, FOREIGN KEY (risk_id) REFERENCES risk(risk_id),
treatment_id INT, FOREIGN KEY (treatment_id) REFERENCES treatment(treatment_id),
first_screen DATE DEFAULT (CURDATE()),
next_screen DATE DEFAULT (CURDATE()),
screening_frequency ENUM("weekly", "Every 2 weeks"),
is_terminated BOOLEAN DEFAULT FALSE NOT NULL
);
