import json
from lib2to3.pgen2.pgen import DFAState
import pandas as pd
import aiohttp
import os
import basedosdados as bd
import re
from constants import constants
import logging
from tqdm import tqdm
import asyncio

def municipalities_as_chunks(chunk_size: int = 100):
    query = """
    SELECT * FROM `basedosdados.br_bd_diretorios_brasil.municipio`
    """
    df_municipios = bd.read_sql(query, billing_project_id="casebd", reauth=True)
    input_list = list(df_municipios.id_municipio.unique())
    
    # Converter os valores para inteiros
    input_list = [int(value) for value in input_list]

    return [input_list[i:i + chunk_size] for i in range(0, len(input_list), chunk_size)]

async def fetch(session, url):
    async with session.get(url) as response:
        print(response.status)
        if response.status >= 400 and response.status <= 599:
            print(f"Tabela grande demais: {url}")
            raise Exception(f"Erro de requisição: status code {response.status}")
        return await response.json()

async def sidra_to_dataframe(session, url):
    try:
        json_data = await fetch(session, url)
    except aiohttp.ClientError as e:
        raise Exception(f"Erro de requisição: status code {e}")
    return pd.json_normalize(json_data)

def rename_dataframe(df):
    df.columns = df.loc[0, :].values.flatten().tolist()
    return df.iloc[1: , :]

def dataframe_to_parquet(df, mkdir, table_id):
    if mkdir:
        os.makedirs("/tmp/data/br_ibge_censo_2022/input", exist_ok=True)
    return df.to_parquet(path=f"/tmp/data/br_ibge_censo_2022/input/{table_id}.parquet", compression="gzip")


def json_to_dir(df, mkdir, table_id):
    if mkdir:
        os.makedirs("/tmp/data/br_ibge_censo_2022/input", exist_ok=True)
    with open(f"/tmp/data/br_ibge_censo_2022/input/{table_id}.json", 'w') as f:
        json.dump(df, f, ensure_ascii=False)         
    #return df.to_parquet(path=f"/tmp/data/br_ibge_censo_2022/input/{table_id}.parquet", compression="gzip")

async def download_data(k, v, session, output_list):
    print(f"Baixando dados da tabela: {k}")
    df_final = pd.DataFrame()
    try:
        print(f"Baixando dados NÃO CHUNKS da tabela: {k}")
        df = await fetch(session, v)
        json_to_dir(df,mkdir=True, table_id = k)
        #df = rename_dataframe(df)
        print("finalizado") 
    except:
        print("Não foi, baixando em chunks:")  
        #tasks1 = [fetch(session,"https://servicodados.ibge.gov.br/api/v3/agregados/4711/periodos/-6/variaveis/617?localidades=N6[{}]&classificacao=3[9697,2504,59998,59999,60000,60001,60002,60003,103995,10004,10005]".format(','.join(map(str, n)))) for n in output_list]
        #jsons = await asyncio.gather(*tasks1) 
        #json_to_dir(jsons,mkdir=True, table_id = k)

async def main():
    #output_list = municipalities_as_chunks()
    output_list = []
    async with aiohttp.ClientSession() as session:
        tasks = [download_data(k, v, session, output_list) for k, v in constants.URLS.value.items()]
        await asyncio.gather(*tasks)        

if __name__ == "__main__":
    #output_list = municipalities_as_chunks()
    #print(output_list)

    #for n in output_list:
    #    print(n)
    asyncio.run(main())        