import basedosdados as bd
from utils import (
    async_crawler_ibge_municipio,
    parse_ibge_json,
    parse_files_save_parquet,
    uf_id_sigla,
)
import asyncio

API_URL_BASE        = "https://servicodados.ibge.gov.br/api/v3/agregados/{}/periodos/{}/variaveis/{}?localidades={}[{}]&classificacao={}"
AGREGADO            = "9878"
PERIODOS            = 'all'
VARIAVEIS           = "|".join(["2133", "1002133"]) 
NIVEL_GEOGRAFICO    = "N6" 
LOCALIDADES         = "all"
#NOTE: Seleciona todas as variáveis possíveis
CLASSIFICACAO       = "11603[all]|11561[all]|12237[all]|11562[all]" 


BILLING_ID = "pisagab-staging"
nome_tabela = "condicao_domicilio_grupo_idade_sexo_raca_cor"	

if __name__ == "__main__":

    # municipios = bd.read_sql(
    #         """
    #         SELECT id_municipio
    #         FROM `basedosdados.br_bd_diretorios_brasil.municipio`
    #         """,
    #         billing_project_id=BILLING_ID,
    #     )
    
    # print('------ Baixando dados da API ------')
    # asyncio.run(
    #     async_crawler_ibge_municipio(
    #         year=PERIODOS, 
    #         variables=VARIAVEIS,
    #         api_url_base=API_URL_BASE,
    #         agregado=AGREGADO,
    #         nivel_geografico=NIVEL_GEOGRAFICO,
    #         localidades=municipios,
    #         classificacao=CLASSIFICACAO,
    #         nome_tabela=nome_tabela,
    #     )
    # )
    
    print('------ Processando dados ------')
    parse_files_save_parquet(nome_tabela, uf_id_sigla)