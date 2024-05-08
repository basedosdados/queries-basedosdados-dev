import pandas as pd
from basedosdados import backend as b

def get_columns_info_from_api(table_name:str, dataset_name:str, url_api:str):
  backend = b.Backend(graphql_url=url_api)

  id = backend._get_table_id_from_name(gcp_dataset_id=dataset_name, gcp_table_id=table_name)

  variables = {"table_Id":id}

  query = """query($table_Id: ID){
    allColumn(table_Id: $table_Id){
      edges{
        node{
          name
          order
          bigqueryType{
            name
          }
          description
          coverages{
            edges{
              node{
                datetimeRanges{
                  edges{
                    node{
                      startYear
                      endYear
                    }
                  }
                }
              }
            }
          }
          coveredByDictionary
          directoryPrimaryKey{
            cloudTables{
              edges{
                node{
                  gcpDatasetId
                  gcpTableId
                }
              }
            }
            name
          }
          measurementUnit
          containsSensitiveData
          observations
        }
      }
    }
  }"""

  query_data = backend._execute_query(query=query, variables=variables)

  query_data = backend._simplify_graphql_response(query_data)['allColumn']


  df = pd.json_normalize(query_data, max_level=3)
  df.index = df.order
  df.sort_index(inplace=True)
  return df

def format_temporal_coverage_column(df):

  try:
    start_year = df["coverages"].map(lambda x: x[0]['datetimeRanges'][0]['startYear']).astype("Int64")
    end_year = df["coverages"].map(lambda x: x[0]['datetimeRanges'][0]['endYear']).astype("Int64")
    df["temporal_coverage"] = start_year.astype(str)+"(1)"+end_year.astype(str)
    df["temporal_coverage"] = df["temporal_coverage"].str.replace("<NA>","")
  except:
    df["temporal_coverage"] = "(1)"

  return df["temporal_coverage"]

def boolean_to_yes_no():
    return {True: 'yes',False: 'no'}

def get_directory_column(row):
  if "directoryPrimaryKey.cloudTables" in row.index:
    if isinstance(row["directoryPrimaryKey.cloudTables"], list):
      directory_dataset = row["directoryPrimaryKey.cloudTables"][0]['gcpDatasetId']
      directory_table = row["directoryPrimaryKey.cloudTables"][0]['gcpTableId']
      directory_column_name = row["directoryPrimaryKey.name"]
      return directory_dataset+"."+directory_table+":"+directory_column_name
  return None

def get_architecture_table(dataset_name,
        table_name,
        url_api="https://api.basedosdados.org/api/v1/graphql"):

  df = get_columns_info_from_api(table_name, dataset_name, url_api)

  df["bigquery_type"] = df["bigqueryType.name"].str.lower()
  df["temporal_coverage"] = format_temporal_coverage_column(df)
  df["covered_by_dictionary"] = df["coveredByDictionary"].map(boolean_to_yes_no())
  df["has_sensitive_data"] = df["containsSensitiveData"].map(boolean_to_yes_no())
  df["directory_column"]=(df.apply(lambda row: get_directory_column(row), axis = 1))
  df["measurement_unit"] = df["measurementUnit"]

  columns = ["name",
            "bigquery_type",
            "description",
            "temporal_coverage",
            "covered_by_dictionary",
            "directory_column",
            "measurement_unit",
            "has_sensitive_data",
            "observations"]


  return df[columns]

if __name__ == '__main__':

  table_list = ['microdados']
  for table in table_list:
    df = get_architecture_table(dataset_name = "br_ms_sinasc",
          table_name = table)
    df.to_csv(f"{table}.csv", index=False)
