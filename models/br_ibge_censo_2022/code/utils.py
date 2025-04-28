import aiohttp
import os
import json
from tqdm.asyncio import tqdm
from aiohttp import ClientTimeout, TCPConnector
from tqdm import tqdm
from typing import Dict, Any, List
import asyncio
import pandas as pd
from unicodedata import normalize
import pyarrow as pa
import pyarrow.parquet as pq
from tqdm import tqdm


async def fetch(session: aiohttp.ClientSession, url: str) -> Dict[str, Any]:
    """
    Faz uma requisição GET à API e retorna a resposta em formato JSON.

    Parâmetros:
    - session (aiohttp.ClientSession): A sessão do cliente aiohttp.
    - url (str): A URL da API para a qual a requisição será feita.

    Retorna:
    - Dict[str, Any]: A resposta da API em formato JSON.
    """
    async with session.get(url) as response:
        return await response.json()

async def async_crawler_ibge_municipio(
    year: List[int], 
    variables: List[str],
    api_url_base: str, 
    agregado: str, 
    nivel_geografico: str, 
    localidades: pd.DataFrame, 
    classificacao: List[str],
    nome_tabela: str
    ) -> None:
    """
    Faz requisições para a API para cada ano, variável e categoria, salvando as respostas em arquivos JSON.
    Processa municípios em grupos de 30 para otimizar as requisições.
    Este crawler foi idealizado para extrair dados por município. Essa foi a forma mais geral utilizada
    para contornar a limitação da API do IBGE. 
    """
    
    all_municipios = localidades['id_municipio'].tolist()
    
    
    batch_size = 30
    
    for i in range(0, len(all_municipios), batch_size):
        batch_municipios = all_municipios[i:i+batch_size]
        print(f'Consultando dados dos municípios: {i+1}-{min(i+batch_size, len(all_municipios))} de {len(all_municipios)}')
        
        async with aiohttp.ClientSession(
            connector=TCPConnector(limit=100, force_close=True), 
            timeout=ClientTimeout(total=1200)
        ) as session:
            tasks = []
            
            for localidade in batch_municipios:
                url = api_url_base.format(
                    agregado, 
                    year, 
                    variables, 
                    nivel_geografico, 
                    localidade,
                    classificacao, 
                )
                print(f"URL for municipio {localidade}: {url}")
                task = fetch(session, url)
                tasks.append((localidade, asyncio.ensure_future(task)))
            
            for localidade, future in tqdm(tasks, total=len(tasks)):
                try:
                    response = await future
                    os.makedirs(f'../tmp/{nome_tabela}', exist_ok=True)
                    with open(f'../tmp/{nome_tabela}/{localidade}.json', 'w') as f:
                        json.dump(response, f)
                except asyncio.TimeoutError:
                    print(f"Request timed out for municipality {localidade}")
                except Exception as e:
                    print(f"Error processing municipality {localidade}: {str(e)}")
        
        await asyncio.sleep(1)
        
        

def parse_ibge_json(data:json) -> pd.DataFrame:
    
    rows = []

    for variavel in data:
        variavel_nome = variavel.get('variavel', '')
        unidade = variavel.get('unidade', '')
        variavel_id = variavel.get('id', '')

        for resultado in variavel.get('resultados', []):
            row = {
                'variavel_id': variavel_id,
                'variavel_nome': variavel_nome,
                'unidade': unidade
            }
            
            # Parse classificações
            for classificacao in resultado.get('classificacoes', []):
                class_nome = classificacao.get('nome', '')
                categoria_dict = classificacao.get('categoria', {})
                categoria_id, categoria_nome = next(iter(categoria_dict.items()))
                
                # Add classification fields dynamically
                row[f'{class_nome}_id'] = categoria_id
                row[f'{class_nome}_categoria'] = categoria_nome
            
            # Parse series
            for serie in resultado.get('series', []):
                row['id_municipio'] = serie.get('localidade', {}).get('id', '')
                row['nome_municipio'] = serie.get('localidade', {}).get('nome', '')
                row['ano'] = next(iter(serie.get('serie', {}).keys()))
                row['valor'] = next(iter(serie.get('serie', {}).values()))
            
            rows.append(row)

    # Convert to a DataFrame
    df = pd.DataFrame(rows)

    import unicodedata

    df.columns = [
        unicodedata.normalize('NFKD', col).encode('ASCII', 'ignore').decode('ASCII').lower().strip()
        for col in df.columns
    ]

    
    return df


                

def parse_files_save_parquet(nome_tabela: str, uf_id_sigla: dict) -> None:
    """
            Função para processar os arquivos JSON e salvar em formato Parquet particionado por UF.
        Esta função assume arquivos JSON extraídos do IBGE, onde cada arquivo contém dados de um município.
        O nome de cada arquivo JSON deve ser o ID_MUNICIPIO de 7 dígitos do IBGE.
        
        Parâmetros:
        nome_tabela (str): Nome da tabela a ser processada.
        uf_id_sigla (dict): Dicionário com IDs e siglas dos estados.
    """
    files = os.listdir(f'../tmp/{nome_tabela}')
    
    for id_uf, sigla_uf in uf_id_sigla.items():
        print(f'Processando {sigla_uf}')
        files_uf = [f for f in files if f.startswith(str(id_uf))]

        path_dir = f'../tmp/output/{nome_tabela}/sigla_uf={sigla_uf}'
        os.makedirs(path_dir, exist_ok=True)
        path_file = os.path.join(path_dir, f'{nome_tabela}.parquet')

        writer = None  # vai ser usado para escrever múltiplos chunks
        
        for file in tqdm(files_uf, desc=f'Processando arquivos de {sigla_uf}'):
            with open(f'../tmp/{nome_tabela}/{file}', 'r') as f:
                data_json = json.load(f)
                df = parse_ibge_json(data_json)

            if not df.empty:
                df = df.astype(str)
                table = pa.Table.from_pandas(df, preserve_index=False)
                
                schema = pa.schema([
                    (col, pa.string()) for col in df.columns
                ])
                
                if writer is None:
                    # Define o schema na primeira vez
                    writer = pq.ParquetWriter(path_file, schema)
                
                writer.write_table(table)
                
                del df 
        if writer:
            writer.close() 


                
uf_id_sigla = {
    11: 'RO',  # Rondônia
    12: 'AC',  # Acre
    13: 'AM',  # Amazonas
    14: 'RR',  # Roraima
    15: 'PA',  # Pará
    16: 'AP',  # Amapá
    17: 'TO',  # Tocantins
    21: 'MA',  # Maranhão
    22: 'PI',  # Piauí
    23: 'CE',  # Ceará
    24: 'RN',  # Rio Grande do Norte
    25: 'PB',  # Paraíba
    26: 'PE',  # Pernambuco
    27: 'AL',  # Alagoas
    28: 'SE',  # Sergipe
    29: 'BA',  # Bahia
    31: 'MG',  # Minas Gerais
    32: 'ES',  # Espírito Santo
    33: 'RJ',  # Rio de Janeiro
    35: 'SP',  # São Paulo
    41: 'PR',  # Paraná
    42: 'SC',  # Santa Catarina
    43: 'RS',  # Rio Grande do Sul
    50: 'MS',  # Mato Grosso do Sul
    51: 'MT',  # Mato Grosso
    52: 'GO',  # Goiás
    53: 'DF'   # Distrito Federal
}
