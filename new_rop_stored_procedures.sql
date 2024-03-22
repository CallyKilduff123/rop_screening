USE rop_screening_db;

-- PROCEDURE 1: DETERMINE POSTMENSTRUAL AGE AND WEEKS SINCE BIRTH (TO DETERMINE WHEN SCREENING SHOULD START)
DELIMITER //

CREATE PROCEDURE CalculatePMA()
BEGIN
    SELECT 
        baby_id,
        firstname,
        lastname,
		date_of_birth,
        gestational_age_at_birth_weeks,
        gestational_age_at_birth_days,
        (gestational_age_at_birth_weeks * 7 + gestational_age_at_birth_days + DATEDIFF(CURDATE(), date_of_birth)) DIV 7 AS pma_weeks,
        (gestational_age_at_birth_weeks * 7 + gestational_age_at_birth_days + DATEDIFF(CURDATE(), date_of_birth)) MOD 7 AS pma_days,
        TIMESTAMPDIFF(WEEK, date_of_birth, CURDATE()) AS weeks_since_birth
    FROM 
        baby;
END;
//

DELIMITER ;


CALL CalculatePMA()


-- PROCEDURE 2: IDENTIFY BABIES ELIGBLE FOR 1ST SCREEN BASED ON GA AND BIRTHWEIGHT CRITERIA:

DELIMITER //

CREATE PROCEDURE IdentifyROPScreeningCandidates()
BEGIN
    SELECT 
        baby_id,
        firstname,
        lastname,
        date_of_birth,
        gestational_age_at_birth_weeks,
        gestational_age_at_birth_days,
        birthweight_grams,
        CURRENT_DATE AS 'today',
        CASE 
            WHEN gestational_age_at_birth_weeks < 27 THEN 
                DATE_ADD(date_of_birth, INTERVAL (30 - gestational_age_at_birth_weeks) WEEK)
            ELSE 
                DATE_ADD(date_of_birth, INTERVAL 4 WEEK)
        END AS first_screening_date,
        -- Calculating Postmenstrual Age (PMA)
        FLOOR((DATEDIFF(CURDATE(), date_of_birth) + (gestational_age_at_birth_weeks * 7) + gestational_age_at_birth_days) / 7) AS pma_weeks,
        (DATEDIFF(CURDATE(), date_of_birth) + (gestational_age_at_birth_weeks * 7) + gestational_age_at_birth_days) % 7 AS pma_days
    FROM 
        baby
    WHERE 
        gestational_age_at_birth_weeks < 32 
        OR birthweight_grams < 1501;
END;
//

DELIMITER ;


CALL IdentifyROPScreeningCandidates()



-- PROCEDURE 3: IDENTIFY SCREENING INTERVALS BASED ON FUNDUS AND ROP FINDINGS
DELIMITER //

CREATE PROCEDURE ScreeningFollowUp()
BEGIN
    SELECT
        -- baby_id,
        firstname,
        lastname,
        -- Determine the follow-up interval and next screen date based on high-risk features
        CASE 
            WHEN vessels_end = 'zone 1' OR stage = 'stage3' OR plus_disease IN ('plus', 'preplus') THEN 'Weekly'
            ELSE 'Two-weekly'
        END AS follow_up_interval,
        DATE_ADD(CURDATE(), INTERVAL 
            CASE 
                WHEN vessels_end = 'zone 1' OR stage = 'stage3' OR plus_disease IN ('plus', 'preplus') THEN 1
                ELSE 2
            END WEEK) AS next_screen_date
    FROM
        baby
	JOIN fundus ON baby.baby_id = fundus.baby_id
    JOIN ROP ON fundus.fundus_id = ROP.fundus_id;
    
END//

DELIMITER ;

CALL ScreeningFollowUp()
 
--  DELIMITER //

-- CREATE PROCEDURE AllocateFollowUp()
-- BEGIN
--     SELECT
--         firstname,
--         lastname,
--         date_of_birth,
--         gestational_age_at_birth_weeks,
--         gestational_age_at_birth_days,
--         -- Calculate Postmenstrual Age in weeks and days
--         FLOOR((DATEDIFF(CURDATE(), date_of_birth) + (gestational_age_at_birth_weeks * 7) + gestational_age_at_birth_days) / 7) AS pma_weeks,
--         (DATEDIFF(CURDATE(), date_of_birth) + (gestational_age_at_birth_weeks * 7) + gestational_age_at_birth_days) % 7 AS pma_days,
--         -- Determine ROP status based on specified conditions
--         CASE 
--             WHEN vessels_end = 'zone 1' OR stage = 'stage 3' OR plus_disease IN ('plus', 'preplus') THEN 'High risk'
--             ELSE 'low risk'
--         END AS screening_status,
--         vessels_end,AllocateFollowUp,
--         -- Calculate Next Screen Date
--         DATE_ADD(CURDATE(), INTERVAL 
--             CASE 
--                 WHEN vessels_end = 'zone 1' OR stage = 'stage3' OR plus_disease IN ('plus', 'preplus') THEN 1
--                 ELSE 2
--             END WEEK) AS next_screen_date,
--         -- Determine Screening Interval
--         CASE 
--             WHEN vessels_end = 'zone 1' OR stage = 'stage3' OR plus_disease IN ('plus', 'preplus') THEN 'Weekly'
--             ELSE 'Two-weekly'
--         END AS screening_interval
--     FROM
--         baby
-- 	JOIN fundus ON baby.baby_id = fundus.baby_id
--     JOIN ROP ON fundus.fundus_id = ROP.fundus_id;
--     
-- END//

-- DELIMITER ;

-- CALL AllocateFollowUp()
