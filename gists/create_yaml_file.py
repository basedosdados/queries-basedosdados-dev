import pandas as pd
import ruamel.yaml as yaml
from utils import *
import os
from typing import List


def create_yaml_file(arch_url,
                     table_id,
                     dataset_id,
                     table_description: str = "Insert table description here",
                     at_least: float = 0.05,
                     unique_keys: List[str] = ["insert unique keys here"],
                     mkdir: bool = True,
                     preprocessed_staging_column_names=True) -> None:
    """
    Creates dbt models and schema.yaml files based on the architecture table, including data quality tests automatically.

    Args:
        arch_url (str or list): The URL(s) or file path(s) of the input file(s) containing the data.
        table_id (str or list): The table ID(s) or name(s) to use as the YAML model name(s).
        dataset_id (str): The ID or name of the dataset to be used in the dbt models.
        at_least (float): The proportion of non-null values accepted in the columns.
        unique_keys (list, optional): A list of column names for which the 'dbt_utils.unique_combination_of_columns' test should be applied.
                                      Defaults to ["insert unique keys here"].
        mkdir (bool, optional): If True, creates a directory for the new model(s). Defaults to True.
        preprocessed_staging_column_names (bool, optional):  If True, builds SQL file renaming from 'original_name' to 'name' using the architecture file. Defaults to True.

    Raises:
        TypeError: If the table_id is not a string or a list.
        ValueError: If the number of URLs or file paths does not match the number of table IDs.

    Notes:
        The function generates dbt models in YAML format based on the input data and saves them to the specified output file.
        The generated YAML file includes information about the dataset, model names, descriptions, and column details.

    Example:
        ```python
        create_yaml_file(arch_url='input_data.csv', table_id='example_table', dataset_id='example_dataset')
        ```

    """
    if mkdir:
        models_path = find_model_directory(os.getcwd())
        if models_path:
            output_path = f"{models_path}/{dataset_id}"
            os.makedirs(output_path, exist_ok=True)
        else:
            raise(ValueError("Error: Failed to find the path for the 'models' directory. Ensure that you are running the script within the 'queries-basedosdados-dev' directory."))

    else:
        print(f"Directory for the new model has not been created, saving files in {os.getcwd()}")
        output_path = os.getcwd()

    schema_path = f"{output_path}/schema.yml"

    yaml_obj = yaml.YAML(typ='rt')
    yaml_obj.indent(mapping=4, sequence=4, offset=2)

    if os.path.exists(schema_path):
        with open(schema_path, 'r') as file:
            data = yaml_obj.load(file)
    else:
        data = yaml.comments.CommentedMap()
        data['version'] = 2
        data.yaml_set_comment_before_after_key('models', before='\n\n')
        data['models'] = []

    exclude = ['(excluded)', '(erased)', '(deleted)','(excluido)']

    if isinstance(table_id, str):
        table_id = [table_id]
        arch_url = [arch_url]

    # If table_id is a list, assume multiple input files
    if not isinstance(arch_url, list) or len(arch_url) != len(table_id):
        raise ValueError("The number of URLs or file paths must match the number of table IDs.")

    for url, id in zip(arch_url, table_id):

        unique_keys_copy = unique_keys.copy()
        architecture_df = sheet_to_df(url)
        architecture_df.dropna(subset = ['bigquery_type'], inplace= True)
        architecture_df = architecture_df[~architecture_df['bigquery_type'].apply(lambda x: any(word in x.lower() for word in exclude))]




        table = yaml.comments.CommentedMap()
        table['name'] = f"{dataset_id}__{id}"

        # If model is already in the schema.yaml, delete old model from schema and create a new one
        for model in data['models']:
            if id == model['name'] or table['name'] == model['name'] :
                data['models'].remove(model)
                break

        table['description'] = table_description
        table['tests'] = create_unique_combination(unique_keys_copy)
        table['tests'] += create_not_null_proportion(at_least)

        table['columns'] = []

        for _, row in architecture_df.iterrows():
            column = yaml.comments.CommentedMap()
            column['name'] = row['name']
            column['description'] = row['description']
            if pd.notna(row["directory_column"]):
                tests = []
                directory = row["directory_column"]
                tests = create_relationships(directory)
                column['tests'] = tests
            table['columns'].append(column)


        data['models'].append(table)

        create_model_from_architecture(architecture_df,
                                        output_path,
                                        dataset_id,
                                        id,
                                        preprocessed_staging_column_names)

    with open(schema_path, 'w') as file:
        yaml_obj.dump(data, file)

    print("Files successfully created!")


if __name__ == '__main__':
    DATASET_ID = 'test'
    TABLE_ID = 'test'
    #The URL must be the browser link containing '#gid='. The edit function should be open to anyone on the internet.
    ARCHITECTURE_URL = "https://docs.google.com/spreadsheets/d/1Y2ebUNrZTUv2x_psWpK4oTxvRxhje5K6BSKZIWBQYDM/edit?pli=0#gid=1213668070"

    create_yaml_file(
    arch_url=ARCHITECTURE_URL,
    table_id=TABLE_ID,
    dataset_id=DATASET_ID,
    preprocessed_staging_column_names=True)
