USE rop_screening_db;

INSERT INTO baby (firstname, lastname, gender, date_of_birth, gestational_age_at_birth_weeks, birthweight_grams)
VALUES
('Baby', 'Garcia', 'female', '2024-02-12', 900),
('Baby', 'Rodriguez', 'male','2024-03-15', 1249),
('Lucas', 'Jones', 'male','2024-03-04', 1431),
('Charlotte', 'Davis', 'female', '2024-02-16', 1900),
('Ava', 'Jones', 'female', '2024-02-12',  1356),
('Elijah', 'Jones', 'male', '2024-02-03', 1698),
('Olivia', 'Smith', 'female','2024-02-14', 900),
('Henry', 'McGarmin', 'male', '2024-02-01', 2900),
('Harper', 'Johnson', 'male', '2024-02-02', 1899),
('Mia', 'Franklin', 'female', '2024-03-17', 1450);

UPDATE baby SET gestational_age_at_birth_weeks = 26 WHERE baby_id = 1;
UPDATE baby SET gestational_age_at_birth_weeks = 24 WHERE baby_id = 2;
UPDATE baby SET gestational_age_at_birth_weeks = 33 WHERE baby_id = 3;
UPDATE baby SET gestational_age_at_birth_weeks = 40 WHERE baby_id = 4;
UPDATE baby SET gestational_age_at_birth_weeks = 32 WHERE baby_id = 5;
UPDATE baby SET gestational_age_at_birth_weeks = 31 WHERE baby_id = 6;
UPDATE baby SET gestational_age_at_birth_weeks = 31 WHERE baby_id = 7;
UPDATE baby SET gestational_age_at_birth_weeks = 31 WHERE baby_id = 8;
UPDATE baby SET gestational_age_at_birth_weeks = 31 WHERE baby_id = 9;
UPDATE baby SET gestational_age_at_birth_weeks = 30 WHERE baby_id = 10;

UPDATE baby SET gestational_age_at_birth_days = 0 WHERE baby_id = 1;
UPDATE baby SET gestational_age_at_birth_days = 1 WHERE baby_id = 2;
UPDATE baby SET gestational_age_at_birth_days = 1 WHERE baby_id = 3;
UPDATE baby SET gestational_age_at_birth_days = 6 WHERE baby_id = 4;
UPDATE baby SET gestational_age_at_birth_days = 6 WHERE baby_id = 5;
UPDATE baby SET gestational_age_at_birth_days = 3 WHERE baby_id = 6;
UPDATE baby SET gestational_age_at_birth_days = 1 WHERE baby_id = 7;
UPDATE baby SET gestational_age_at_birth_days = 6 WHERE baby_id = 8;
UPDATE baby SET gestational_age_at_birth_days = 5 WHERE baby_id = 9;
UPDATE baby SET gestational_age_at_birth_days = 2 WHERE baby_id = 10;



SELECT * FROM baby;


INSERT INTO fundus (baby_id, vessels_end, is_ROP)
VALUES
(01, 'zone 1', FALSE),
(02, 'zone 2', FALSE), 
(03, 'zone 2', FALSE), 
(05, 'zone 1', FALSE), 
(06, 'zone 2', TRUE), 
(07, 'zone 2', FALSE),
(08, 'zone 2', TRUE), 
(09, 'zone 2', TRUE), 
(10, 'zone 1', TRUE);

SELECT * FROM fundus;


INSERT INTO ROP(fundus_id, stage, zone, plus_disease)
VALUES
(5, "stage 3", "zone 1", "preplus"),
(7, "stage 1", "zone 1", "plus"),
(8, "stage 1", "zone 2", "plus"),
(9, "stage 1", "zone 3", NULL);

SELECT * FROM ROP;


INSERT INTO screening(baby_id, rop_id, first_screen, next_screen, screening_frequency, is_terminated)
VALUES
(1, NULL, NULL, NULL,NULL, FALSE),
(2, NULL, NULL, NULL, NULL, FALSE),
(3, NULL, NULL, NULL, NULL, FALSE),
(5, NULL, NULL, NULL, NULL, FALSE),
(6, 1, NULL, NULL, NULL, FALSE),
(7, NULL, NULL, NULL, NULL, FALSE),
(8, 2, NULL, NULL, NULL, FALSE),
(9, 3, NULL, NULL, NULL, FALSE),
(10, 4, NULL, NULL, NULL, FALSE);

SELECT * FROM screening;


INSERT INTO treatment(ROP_id, requires_treatment, treatment_date, post_treatment_review)
VALUES
(1, NULL, NULL, NULL),
(2, NULL, NULL, NULL),
(3, NULL, NULL, NULL),
(4, NULL, NULL, NULL);

SELECT * FROM treatment;





