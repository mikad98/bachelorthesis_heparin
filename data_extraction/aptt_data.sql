-- Extract APTT data from MIMIC-IV 'Chartevents' Table
 
SELECT DISTINCT
    ce.subject_id,
    ce.hadm_id,
    ad.admittime AS hadmit_time,
    ce.stay_id,
    ce.charttime,
    DATE_DIFF(ce.charttime, init_hep_starttime, MINUTE) AS rel_charttime, -- relative time to initial heparin infusion
    ce.valuenum AS PTT,
    ce.valueuom,
    respiration_24hours AS sofa_resp, -- respiaration
    coagulation_24hours AS sofa_coag, -- coagulation
    liver_24hours AS sofa_liver,
    cardiovascular_24hours AS sofa_cardio, -- cardiovascular
    cns_24hours AS sofa_cns, -- neurological
    renal_24hours AS sofa_renal,
    sofa_24hours AS sofa_score,
    DATE_DIFF(ce.charttime, DATETIME(anchor_year,1,1,0,0,0), YEAR) + pa.anchor_age AS age,  -- Age is not 100% appropriate, but at least in the range of +/- 1 year of the actual age which should be sufficient in this context
    pa.gender,
    ad.ethnicity,
    tr.careunit AS ICU_Type
FROM (
    SELECT *
    FROM `physionet-data.mimic_icu.chartevents`
    WHERE itemid =  227466 -- PTT   
) ce

-- Join other Features (cf. Chapter 3.2 in thesis)

INNER JOIN (
    SELECT stay_id, init_hep_starttime
    FROM `bachelorarbeit-heparin.mimic_data.hep_data`
    GROUP BY stay_id, init_hep_starttime
) hep_data
    ON ce.stay_id = hep_data.stay_id
LEFT JOIN `bachelorarbeit-heparin.mimic_data.sofa` sofa
    ON ce.stay_id = sofa.stay_id
LEFT JOIN `physionet-data.mimic_core.transfers` tr
    ON ce.subject_id = tr.subject_id
LEFT JOIN `physionet-data.mimic_core.patients` pa
    ON ce.subject_id = pa.subject_id
LEFT JOIN `physionet-data.mimic_core.admissions` ad
    ON ce.hadm_id = ad.hadm_id
WHERE ce.charttime BETWEEN sofa.starttime AND sofa.endtime
    AND ce.charttime BETWEEN tr.intime AND tr.outtime
    AND ce.stay_id NOT IN (
        SELECT stay_id
        FROM `physionet-data.mimic_icu.chartevents` ce
        WHERE itemid =  227466 -- PTT
            AND valuenum NOT BETWEEN 10 AND 150
        GROUP BY stay_id
    ) -- Remove Outliers (for some rare cases, the second pharmacokinetics computation failed because of errors in the MIMIC-IV database)
    AND ce.stay_id NOT IN (31914622,33304266,34345297,30640850,36574062,36563429,36538893,30371335,34168977,38380950,33071091,38384732,36488395,31631743,34705235) -- Remove Outliers (kum_hep_t too large)
ORDER BY subject_id, hadm_id, ce.stay_id, charttime
