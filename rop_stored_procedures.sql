USE rop_screening_db;

-- PROCEDURE 1: identify babies who require weekly ROP screening
-- join baby (firstname, lastname, DOB and postmenstrual age) + risk (birthweight + GA at birth) + screening_schedule (screening_frequency + next_screen)
-- join baby_id from risk.baby_id and baby.baby_id, join risk.risk_id to screening_schedule.risk_id
-- where is_eligible for screening = true (risk table)
-- where screening_frequency = 'weekly'

DELIMITER //

CREATE PROCEDURE babies_to_screen()
BEGIN
    SELECT 
		baby.firstname,
        baby.lastname,
        baby.date_of_birth,
        baby.postmenstrual_age_weeks,
		risk.birthweight_grams,
        risk.gestational_age_at_birth_weeks,
        screening_schedule.screening_frequency,
        screening_schedule.next_screen
	FROM baby
	JOIN risk ON baby.baby_id = risk.baby_id
	JOIN screening_schedule ON risk.risk_id = screening_schedule.risk_id
    WHERE risk.is_eligible_for_screening = True 
    AND screening_schedule.screening_frequency = "weekly";
END;
//

DELIMITER ;

CALL babies_to_screen()

-- PROCEDURE 2: identify babies with ROP eligible for treatment
-- join baby (firstname, lastname, DOB and postmenstrual age) + fundus (is_ROP_z1, is_ROP_z2, is_ROP_z3) + ROP (stage + is_plus + is_preplus)
-- where ROP stage = stage1, or stage2 or stage 3+ 



DELIMITER //

CREATE PROCEDURE babies_to_treat()
BEGIN
    SELECT 
		baby.firstname,
        baby.lastname,
        baby.date_of_birth,
        baby.postmenstrual_age_weeks,
		fundus.is_ROP_Zone1,
        fundus.is_ROP_Zone2,
        fundus.is_ROP_Zone3,
        ROP.stage,
        ROP.is_plus_disease,
        ROP.is_preplus_disease
	FROM baby
	JOIN fundus ON baby.baby_id = fundus.baby_id
	JOIN ROP ON fundus.fundus_id = ROP.fundus_id
    WHERE rop.stage = "stage 1" or "stage 2" or "stage 3+";
END;
//

DELIMITER ;

CALL babies_to_treat()