import basedosdados as bd
from basedosdados import backend as b
from create_yaml_file import sheet_to_df
from getpass import getpass


def get_token(backend: b.Backend, email: str, password: str) -> str:
    """
    Get JWT token for authentication to be able to edit metadata directly from api
    """
    mutation = """
        mutation ($email: String!, $password: String!) {
            tokenAuth(email: $email, password: $password) {
                token
            }
        }
    """
    variables = {"email": email, "password": password}
    response = backend._execute_query(mutation, variables)
    return response["tokenAuth"]["token"]


def create_column(
    backend: b.Backend,
    mutation_parameters: dict[str, str],
    token: str,
):
    ## tinha que ser create or replace, por enquanto ele duplica os dados se rodar duas vezes por isso atenção na hora de rodar!

    # GraphQL mutation to create or update a column
    mutation = """
                    mutation($input: CreateUpdateColumnInput!) {
                        CreateUpdateColumn(input: $input) {
                            errors {
                                field,
                                messages
                            },
                            clientMutationId,
                            column {
                                id,
                            }
                        }
                    }
        """

    # Set headers for the GraphQL request, including the token for authentication
    headers = {
        "Authorization": f"Bearer {token}",
    }

    # Execute the GraphQL query with the provided mutation parameters and headers
    return backend._execute_query(
        query=mutation,
        variables={"input": mutation_parameters},  # type: ignore
        headers=headers,  # type: ignore
    )


def get_bqtype_dict(backend: b.Backend) -> dict[str, str]:
    # GraphQL query to fetch all BigQuery types
    query = """{
    allBigquerytype{
      edges{
        node{
          name
          _id
        }
      }
    }
  }"""

    # Execute the GraphQL query to retrieve the data
    data = backend._execute_query(query=query)

    # Simplify the GraphQL response to extract the relevant data
    data = backend._simplify_graphql_response(response=data)["allBigquerytype"]

    # Create a dictionary where the 'name' part is the key and the '_id' is the value
    bqtype_dict = {item["name"]: item["_id"] for item in data}

    # Return the resulting dictionary
    return bqtype_dict


def main(dataset_id: str, table_id: str, arch_url: str, email: str, password: str):
    tb = bd.Table(dataset_id=dataset_id, table_id=table_id)
    # Create a backend object with the GraphQL URL
    # This will help us interact with the api
    backend = b.Backend(graphql_url="https://api.basedosdados.org/api/v1/graphql")

    # Get the authentication token using the provided email and password
    token = get_token(backend, email=email, password=password)

    # Get the table ID using the dataset ID and table ID
    table_id = backend._get_table_id_from_name(  # type: ignore
        gcp_dataset_id=tb.dataset_id, gcp_table_id=tb.table_id
    )

    # Relevant columns
    columns = [
        "name",
        "bigquery_type",
        "description",
        "covered_by_dictionary",
        "measurement_unit",
        "has_sensitive_data",
        "observations",
    ]

    architecture = sheet_to_df(arch_url)[columns]

    # Get the id of BigQueryTypes in a dict
    bqtype_dict = get_bqtype_dict(backend)

    # Iterate over each row in the 'architecture' DataFrame
    for _, row in architecture.iterrows():
        # Define the mutation parameters for creating a new column
        bigquery_type = (
            row["bigquery_type"] if row["bigquery_type"] != "bool" else "boolean"
        )
        mutation_parameters = {
            "table": table_id,
            "bigqueryType": bqtype_dict[bigquery_type.upper()],  # type: ignore
            "name": row["name"],
            "description": row["description"],
            "coveredByDictionary": row["covered_by_dictionary"] == "yes",
            "measurementUnit": row["measurement_unit"],
            "containsSensitiveData": row["has_sensitive_data"] == "yes",
            "observations": row["observations"],
        }

        # Call the 'create_column' function with the mutation parameters and authentication token
        response = create_column(
            backend, mutation_parameters=mutation_parameters, token=token
        )
        print(response)


if __name__ == "__main__":
    EMAIL = "email@basedosdados.org"
    DATASET_ID = "DATASET_ID"
    TABLE_ID = "TABLE_ID"
    ARCH_URL = "URL_TO_SHEET"

    main(
        dataset_id=DATASET_ID,
        table_id=TABLE_ID,
        arch_url=ARCH_URL,
        email=EMAIL,
        password=getpass(prompt="Your Django Password: "),
    )
