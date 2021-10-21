-- APTT data has been reduced to the patients that are in cohort1 (patients that have just received heparin via 'Continuous Med'

SELECT 
    ptt.subject_id,
    ptt.hadm_id,
    ptt.hadmit_time,
    ptt.stay_id,
    ptt.charttime,
    ptt.rel_charttime,
    LAG(ptt.PTT) OVER(PARTITION BY ptt.stay_id ORDER BY ptt.charttime) AS prev_PTT, -- previous PTT
    ptt.PTT,
    ROUND(ptt.PTT - LAG(ptt.PTT) OVER(PARTITION BY ptt.stay_id ORDER BY ptt.charttime), 2) AS diff_PTT,
    ptt.rel_charttime - LAG(ptt.rel_charttime) OVER(PARTITION BY ptt.stay_id ORDER BY ptt.charttime) AS diff_charttime,
    sofa_resp, -- respiaration
    sofa_coag, -- coagulation
    sofa_liver,
    sofa_cardio, -- cardiovascular
    sofa_cns, -- neurological
    sofa_renal,
    ptt.sofa_score,
    ptt.age,
    ptt.gender,
    ptt.ethnicity,
    ptt.ICU_Type,
FROM `bachelorarbeit-heparin.mimic_data.ptt_data` ptt
INNER JOIN (
    SELECT stay_id
    FROM `bachelorarbeit-heparin.mimic_data.cohort1_hep_data`
    GROUP BY stay_id
) cohort1
    ON ptt.stay_id = cohort1.stay_id -- just give out PTT-measurements of patients, where information about heparin administration is available
ORDER BY subject_id, hadm_id, stay_id, charttime
