-- Extracting of Heparin Data from the MIMIC-IV 'Inputevents' Table

SELECT DISTINCT 
    subject_id,
    hadm_id,
    stay_id,
    starttime,
    endtime,
    MIN(starttime) OVER(PARTITION BY stay_id) AS init_hep_starttime,
    DATE_DIFF(starttime, MIN(starttime) OVER(PARTITION BY stay_id), MINUTE) AS rel_starttime,
    DATE_DIFF(endtime, MIN(starttime) OVER(PARTITION BY stay_id), MINUTE) AS rel_endtime,
    DATE_DIFF(endtime, starttime, MINUTE) AS treatment_length,
    ROUND(SUM(amount) OVER(PARTITION BY stay_id ORDER BY starttime,endtime ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) - amount, 2) AS kum_amount_start,
    ROUND(SUM(amount) OVER(PARTITION BY stay_id ORDER BY starttime,endtime ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS kum_amount_end,
    ROUND((SUM(amount) OVER(PARTITION BY stay_id ORDER BY starttime,endtime ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) - amount)/patientweight, 2) AS kum_amount_start_by_weight,
    ROUND((SUM(amount) OVER(PARTITION BY stay_id ORDER BY starttime,endtime ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))/patientweight, 2) AS kum_amount_end_by_weight,
    ROUND(amount, 2) AS amount,
    amountuom,
    ROUND(rate, 2) AS rate,
    rateuom,
    patientweight,
    ROUND(rate/patientweight,2) AS rate_by_weight,
    ordercategorydescription
FROM `physionet-data.mimic_icu.inputevents` ie
WHERE ie.itemid = 225152 -- Heparin Sodium
    AND stay_id NOT IN ( -- Remove Outliers
        SELECT stay_id
        FROM `physionet-data.mimic_icu.inputevents`
        WHERE itemid = 225152
            AND (
                rate/patientweight > 35
                    OR rate > 3500
                    OR patientweight NOT BETWEEN 40 AND 200
            ) 
        GROUP BY stay_id
    ) 
ORDER BY subject_id, hadm_id, stay_id, starttime, endtime
