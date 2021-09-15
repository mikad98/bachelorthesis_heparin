-- DATASET 1: Only Patients that received Heparin just as Continuous Med (no Bolus!)

WITH ds1_cohort AS
(
    WITH continous AS
    (
        -- Patients, that received Heparin as "Continous Med"
        SELECT stay_id, ordercategorydescription, COUNT(1) AS cnt
        FROM `bachelorarbeit-heparin.mimic_data.hep_data` hd
        GROUP BY stay_id, ordercategorydescription
        HAVING cnt >= 1 AND ordercategorydescription = "Continuous Med"
    )

    , drug_push AS
    (
        -- Patients, that received Heparin as "Drug Push"
        SELECT stay_id, ordercategorydescription, COUNT(1) AS cnt
        FROM `bachelorarbeit-heparin.mimic_data.hep_data` hd
        GROUP BY stay_id, ordercategorydescription
        HAVING (cnt >= 1 AND ordercategorydescription = "Drug Push")
    )


    -- All Patients that received Heparin just as Drug Push
    SELECT stay_id
    FROM continous 

    EXCEPT DISTINCT

    SELECT stay_id
    FROM drug_push
)

SELECT hd.*
FROM `bachelorarbeit-heparin.mimic_data.hep_data` hd
INNER JOIN ds1_cohort 
    ON hd.stay_id = ds1_cohort.stay_id
ORDER BY subject_id, hadm_id, stay_id, starttime, endtime
