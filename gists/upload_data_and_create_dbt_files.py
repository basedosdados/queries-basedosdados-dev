from create_yaml_file import create_yaml_file
import basedosdados as bd

if __name__ == '__main__':
    # Defining variables for dataset and table
    DATASET_ID = 'br_bd_metadados'
    TABLE_ID = 'storage_blobs'
    #The URL must be the browser link containing '#gid='. The edit function should be open to anyone on the internet.
    ARCHITECTURE_URL = 'https://docs.google.com/spreadsheets/d/1mWNTeUVpLAufhxdnXLqcbKasv9MA3xbZ/edit#gid=1518247806'
    #Path to the table, if you saved in the hive format, this is the path to the dir that contains all hives
    PATH_TO_DATA = f"/path_to_datasets/{DATASET_ID}/{TABLE_ID}"
    # Source format can be 'csv' or 'parquet'
    SOURCE_FORMAT = 'csv'
    # If you've already modified the data columns from 'original_name' to 'name' (architecture table) in your Python code, change this variable to True
    PREPROCESSED_STAGING_COLUMN_NAMES = False

    # Creating a Table object
    tb = bd.Table(
        dataset_id=DATASET_ID,
        table_id=TABLE_ID
    )

    # Uploading data to BD Storage and creating a BigQuery table that accesses this data directly from Storage
    # Below, we list the parameters commonly used, but it's important to explore other parameter options in our documentation for your specific use case
    tb.create(
        path=PATH_TO_DATA,
        if_storage_data_exists='raise',
        if_table_exists='replace',
        source_format=SOURCE_FORMAT
    )

    # Creating standard files required to run a dbt model
    # Modifications will be needed, but this code significantly reduces workload
    create_yaml_file(
        arch_url=ARCHITECTURE_URL,
        table_id=TABLE_ID,
        dataset_id=DATASET_ID,
        preprocessed_staging_column_names=PREPROCESSED_STAGING_COLUMN_NAMES)
