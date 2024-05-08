import os
from pathlib import Path
from create_yaml_file import find_model_directory, update_dbt_project_yaml
from distutils.dir_util import copy_tree

def change_origin_from_dev_to_staging(file, prod_models_dataset_path):
    sql_file = Path(prod_models_dataset_path +'/'+ file).open("r").read()
    sql_final = sql_file.replace("basedosdados-dev.", "basedosdados-staging.")
    Path(prod_models_dataset_path +'/'+ file).open("w").write(sql_final)


def main(datasets):
    dev_models_path = find_model_directory(os.getcwd())
    prod_models_path = dev_models_path.replace('queries-basedosdados-dev', 'queries-basedosdados')
    for dataset_id in datasets:
        prod_models_dataset_path = f"{prod_models_path}/{dataset_id}"
        copy_tree(f"{dev_models_path}/{dataset_id}",prod_models_dataset_path)
        update_dbt_project_yaml(dataset_id,prod_models_path)
        [change_origin_from_dev_to_staging(file, prod_models_dataset_path) for file in os.listdir(prod_models_dataset_path) if '.sql' in file]


if __name__ == '__main__':
    DATASETS = ['br_ibge_ppm','br_ibge_pam',]
    main(DATASETS)
