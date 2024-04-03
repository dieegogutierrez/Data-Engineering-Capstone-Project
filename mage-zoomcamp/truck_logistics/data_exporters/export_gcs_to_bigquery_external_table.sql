CREATE OR REPLACE EXTERNAL TABLE `{{ env_var("TF_VAR_project") }}.{{ env_var("TF_VAR_bq_dataset_name") }}.trip_data_external_table`
(
    date DATE,
    driver STRING,
    customer STRING,
    hours FLOAT64,
    km INTEGER
)
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://{{ env_var("TF_VAR_gcs_bucket_name") }}/trip_data.parquet']
);