-- Here, the APTT data get's merged with the heparin data, resulting in the finals table on where the subsequent analysis has been performed

SELECT 
    ptt.subject_id,
    ptt.hadm_id,
    ptt.stay_id,
    ptt.hadmit_time,
    ptt.rel_charttime,
    ptt.prev_PTT,
    ptt.PTT,
    ptt.diff_PTT,
    ptt.diff_charttime,
    ptt.sofa_resp,
    ptt.sofa_coag,
    ptt.sofa_liver,
    ptt.sofa_cardio,
    ptt.sofa_cns,
    ptt.sofa_renal,
    ptt.sofa_score,
    ptt.age,
    ptt.gender,
    ptt.ethnicity,
    ptt.ICU_Type,
    hep.rel_starttime,
    hep.rel_endtime,
    hep.rate_by_weight,
    ROUND(((((rel_charttime-rel_starttime)/60)*rate_by_weight)+kum_amount_start_by_weight)/(rel_charttime/60),2) AS kum_hep_t,
    hep.patientweight,
    hep.ordercategorydescription
FROM (
    SELECT *
    FROM `bachelorarbeit-heparin.mimic_data.cohort1_ptt_data`
    WHERE rel_charttime BETWEEN 1 AND 1440
) ptt
LEFT JOIN (
    SELECT *
    FROM `bachelorarbeit-heparin.mimic_data.cohort1_hep_data_preprocessed`
    ORDER BY stay_id, rel_starttime
) hep
    ON ptt.stay_id = hep.stay_id
    AND rel_charttime BETWEEN rel_starttime AND rel_endtime
ORDER BY subject_id, stay_id, rel_starttime
