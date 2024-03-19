USE rop_screening_db;

INSERT INTO baby (firstname, lastname, gender, date_of_birth, postmenstrual_age_weeks)
VALUES
('Baby', 'Garcia', 'female', '2024-02-12', 31),
('Baby', 'Rodriguez', 'male','2024-02-15', 36),
('Lucas', 'Jones', 'male','2024-03-04', 35),
('Charlotte', 'Davis', 'female', '2024-02-16', 34),
('Ava', 'Jones', 'female', '2024-02-12', 36),
('Elijah', 'Jones', 'male', '2024-02-03', 36),
('Olivia', 'Smith', 'female','2024-02-14', 36),
('Henry', 'McGarmin', 'male', '2024-02-01', 38),
('Harper', 'Johnson', 'male', '2024-02-02', 37),
('Mia', 'Franklin', 'female', '2024-03-17', 40);

SELECT * FROM baby;

INSERT INTO risk(baby_id, gestational_age_at_birth_weeks, birthweight_grams, is_eligible_for_screening)
VALUES
(01, 26, 900, TRUE),
(02, 31, 1249, TRUE),
(03, 33, 1431, TRUE),
(04, 32, 1356, TRUE),
(05, 31, 1698, TRUE),
(06, 31, 900, TRUE),
(07, 31, 2900, TRUE),
(08, 31, 1899, TRUE),
(09, 31, 1450, TRUE),
(10, 40, 1900, FALSE);

SELECT * FROM risk;


INSERT INTO fundus (baby_id, vessels_end, is_ROP_Zone1, is_ROP_Zone2, is_ROP_Zone3)
VALUES
(01, 'zone 1', FALSE, FALSE, FALSE),
(02, 'zone 2', FALSE, FALSE, FALSE),
(03, 'zone 2', FALSE, FALSE, FALSE),
(04, 'zone 2', FALSE, FALSE, FALSE),
(05, 'zone 1', FALSE, FALSE, FALSE),
(06, 'zone 2', TRUE, TRUE, TRUE),
(07, 'zone 2', FALSE, FALSE, FALSE),
(08, 'zone 2', FALSE, TRUE, TRUE),
(09, 'zone 2', FALSE, FALSE, TRUE);

SELECT * FROM fundus;

INSERT INTO ROP(fundus_id, stage, is_plus_disease, is_preplus_disease)
VALUES
(01, "No ROP", FALSE, FALSE),
(02, "No ROP", FALSE, FALSE),
(03, "No ROP", FALSE, FALSE),
(04, "No ROP", FALSE, FALSE),
(05, "No ROP", FALSE, FALSE),
(06, "stage 1", FALSE, TRUE),
(07, "No ROP", FALSE, FALSE),
(08, "stage 1", FALSE, TRUE),
(09, "stage 1", TRUE, FALSE);

SELECT * FROM ROP;


INSERT INTO treatment(ROP_id, requires_treatment, treatment_date)
VALUES
(15, TRUE, '2024-03-17'),
(17, TRUE, '2024-03-19'),
(18, FALSE, NULL);

SELECT * FROM treatment;


INSERT INTO screening_schedule(risk_id, treatment_id, first_screen, next_screen, screening_frequency, is_terminated)
VALUES
(01, NULL, '2024-03-15', '2024-03-22', "weekly", FALSE),
(02, NULL, '2024-03-08', '2024-03-29', "Every 2 weeks", FALSE),
(03, NULL, '2024-04-08', '2024-04-08', "Every 2 weeks", FALSE),
(04, NULL, '2024-03-15', '2024-03-29', "Every 2 weeks", FALSE),
(05, NULL, '2024-03-08', '2024-03-22', "weekly", FALSE),
(06, 04, '2024-03-08', '2024-03-25', "weekly", FALSE),
(07, NULL, '2024-03-08', '2024-03-29', "Every 2 weeks", FALSE),
(08, 05, '2024-02-29', '2024-03-25', "weekly", FALSE),
(09, 06, '2024-03-01', '2024-03-22', "weekly", FALSE);

SELECT * FROM screening_schedule;



