# bachelorthesis_heparin

## Project's Aim



## Data Extraction
First of, data from MIMIC-IV has been extracted according to the following workflow:

* Extraction of Heparin Data via [hep_data.sql](./data_extraction/hep_data.sql)
* Select only Heparin Data of Cohort 1 via [hep_data_cohort1.sql](./data_extraction/hep_data_cohort1.sql)
* Preprocess the data with Python via [cohort1_hep_data_preprocessed.ipynb](./data_extraction/cohort1_hep_data_preprocessed.ipynb)
* Extraction of APTT Data via [aptt_data.sql](./data_extraction/aptt_data.sql) (Note that other Features have been added here as well, e.g. SOFA Score according to [sofa.sql](./data_extraction/sofa.sql))
* Select only APTT Data of Cohort 1 via [aptt_data_cohort1.sql](./data_extraction/aptt_data_cohort1.sql)
* Merge Heparin and APTT data for the final dataframe via [final_data.sql](./data_extraction/final_data.sql)
