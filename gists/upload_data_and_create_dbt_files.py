from create_yaml_file import create_yaml_file
import basedosdados as bd

if __name__ == '__main__':
    # Defining variables for dataset, table, architecture URL, and path to data
    dataset_id = 'br_bd_metadados'
    table_id = 'storage_blobs'
    architecture_url = 'https://docs.google.com/spreadsheets/d/1mWNTeUVpLAufhxdnXLqcbKasv9MA3xbZ/edit#gid=1518247806'
    path_to_data = f"/path_to_datasets/{dataset_id}/{table_id}"  # Standardized path for data communication with the BD

    # Creating a Table object
    tb = bd.Table(
        dataset_id=dataset_id,
        table_id=table_id
    )

    # Uploading data to BD Storage and creating a BigQuery table that accesses this data directly from Storage
    # Below, we list the parameters commonly used, but it's important to explore other parameter options in our documentation for your specific use case
    tb.create(
        path=path_to_data,
        if_storage_data_exists='raise',
        if_table_exists='replace',
        source_format='csv'
    )

    # Creating standard files required to run a dbt model
    # Modifications will be needed, but this code significantly reduces workload
    create_yaml_file(
        arq_url=architecture_url,
        table_id=table_id,
        dataset_id=dataset_id,
        preprocessed_staging_column_names=False)  # If you've already modified 'original_name' to 'name' in the architecture table for your Python code, change this variable to True
