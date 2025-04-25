import basedosdados as bd
from utils import async_crawler_ibge_municipio
import asyncio

API_URL_BASE        = "https://servicodados.ibge.gov.br/api/v3/agregados/{}/periodos/{}/variaveis/{}?localidades={}[{}]&classificacao={}"
AGREGADO            = "10061" 
PERIODOS            = 'all'
VARIAVEIS           = "|".join(["2667", "1002667"]) 
NIVEL_GEOGRAFICO    = "N6" 
LOCALIDADES         = "all"
#NOTE: Seleciona todas as variáveis possíveis
CLASSIFICACAO       = "1568[all]|58[all]|2[all]|86[all]" 


BILLING_ID = "pisagab-staging"
nome_tabela = "br_ibge_censo_2022_fpt"	

if __name__ == "__main__":

    municipios = bd.read_sql(
            """
            SELECT id_municipio
            FROM `basedosdados.br_bd_diretorios_brasil.municipio`
            WHERE amazonia_legal = 1
            """,
            billing_project_id=BILLING_ID,
        )
    
    print('------ Baixando dados da API ------')
    asyncio.run(
        async_crawler_ibge_municipio(
            year=PERIODOS, 
            variables=VARIAVEIS,
            api_url_base=API_URL_BASE,
            agregado=AGREGADO,
            nivel_geografico=NIVEL_GEOGRAFICO,
            localidades=municipios,
            classificacao=CLASSIFICACAO,
            nome_tabela=nome_tabela,
        )
    )