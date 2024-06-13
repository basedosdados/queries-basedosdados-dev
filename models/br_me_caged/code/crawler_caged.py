from distutils.command.build import build
import pandas as pd
import ftplib
import os
import py7zr
from tqdm import tqdm
from glob import glob
from datetime import timedelta
from unidecode import unidecode
import re

RENAME_DICT = {
    "uf" : "sigla_uf",
    "municipio": "id_municipio",
    "secao": "cnae_2_secao",
    "subclasse": "cnae_2_subclasse",
    "cbo2002ocupacao": "cbo_2002",
    "saldomovimentacao": "saldo_movimentacao",
    "categoria": "categoria",
    "graudeinstrucao": "grau_instrucao",
    "idade": "idade",
    "horascontratuais": "horas_contratuais",
    "racacor": "raca_cor",
    "sexo": "sexo",
    "salario": "salario_mensal",
    "tipoempregador": "tipo_empregador",
    "tipoestabelecimento": "tipo_estabelecimento",
    "tipomovimentacao": "tipo_movimentacao",
    "tipodedeficiencia": "tipo_deficiencia",
    "indtrabintermitente": "indicador_trabalho_intermitente",
    "indtrabparcial": "indicador_trabalho_parcial",
    "tamestabjan": "tamanho_estabelecimento_janeiro",
    "indicadoraprendiz": "indicador_aprendiz",
    "origemdainformacao": "origem_informacao",
    "indicadordeforadoprazo": "indicador_fora_prazo",
    "indicadordeexclusao": "indicador_exclusao"


}
def download_file(ftp, remote_dir, filename, local_dir):
    """
    Downloads and extracts a .7z file from an FTP server.

    Parameters:
        ftp (ftplib.FTP): an active FTP connection
        remote_dir (str): the remote directory containing the file
        filename (str): the name of the file to download
        local_dir (str): the local directory to save and extract the file

    Returns:
        None
    """
    os.makedirs(local_dir, exist_ok=True)
    output_path = os.path.join(local_dir, filename)

    with open(output_path, 'wb') as f:
        ftp.retrbinary('RETR ' + filename, f.write)

    with py7zr.SevenZipFile(output_path, 'r') as archive:
        archive.extractall(path=local_dir)

    os.remove(output_path)

def crawler_novo_caged_ftp(yearmonth: str, ftp_host="ftp.mtps.gov.br") -> None:
    """
    Downloads all .7z files from a specified year and month in the CAGED dataset from ftp://ftp.mtps.gov.br/pdet/microdados/NOVO CAGED/

    Parameters:
        yearmonth (str): the month to download data from (e.g., '202301' for January 2023)
        ftp_host (str): the FTP host to connect to (default: "ftp.mtps.gov.br")

    Returns:
        None
    """

    if len(yearmonth) != 6 or not yearmonth.isdigit():
        raise ValueError("yearmonth must be a string in the format 'YYYYMM'")

    ftp = ftplib.FTP(ftp_host)
    ftp.login()
    ftp.cwd(f'pdet/microdados/NOVO CAGED/{int(yearmonth[0:4])}/')

    available_months = ftp.nlst()
    if yearmonth not in available_months:
        raise ValueError(f"Month {yearmonth} is not available in the directory for the year {yearmonth[0:4]}")

    ftp.cwd(yearmonth)
    print(f'Baixando para o mês: {yearmonth}')

    filenames = [f for f in ftp.nlst() if f.endswith('.7z')]
    for file in filenames:
        if file.startswith('CAGEDMOV'):
            print(f'Baixando o arquivo: {file}')
            download_file(ftp, yearmonth, file, "/tmp/caged/microdados_movimentacao/input/")
        elif file.startswith('CAGEDFOR'):
            print(f'Baixando o arquivo: {file}')
            download_file(ftp, yearmonth, file, "/tmp/caged/microdados_movimentacao_fora_prazo/input/")
        elif file.startswith('CAGEDEXC'):
            print(f'Baixando o arquivo: {file}')
            download_file(ftp, yearmonth, file, "/tmp/caged/microdados_movimentacao_excluida/input/")

    ftp.quit()

def build_partitions(table_id: str, yearmonth: str) -> str:
    """
    build partitions from gtup files
    table_id: microdados_movimentacao | microdados_movimentacao_fora_prazo | microdados_movimentacao_excluida
    """
    dict_uf = {
            "11": "RO",
            "12": "AC",
            "13": "AM",
            "14": "RR",
            "15": "PA",
            "16": "AP",
            "17": "TO",
            "21": "MA",
            "22": "PI",
            "23": "CE",
            "24": "RN",
            "25": "PB",
            "26": "PE",
            "27": "AL",
            "28": "SE",
            "29": "BA",
            "31": "MG",
            "32": "ES",
            "33": "RJ",
            "35": "SP",
            "41": "PR",
            "42": "SC",
            "43": "RS",
            "50": "MS",
            "51": "MT",
            "52": "GO",
            "53": "DF",
        }

    for uf in dict_uf.values():
        os.system(f"mkdir -p /tmp/caged/{table_id}/output/ano={yearmonth[0:4]}/mes={int(yearmonth[4:])}/sigla_uf={uf}/")

    input_files = glob(f"/tmp/caged/{table_id}/input/*txt")

    for filename in tqdm(input_files):
        df = pd.read_csv(filename, sep=";", dtype={"uf": str})
        date = re.search(r"\d+", filename).group()
        ano = date[:4]
        mes = int(date[-2:])
        df.columns = [unidecode(col) for col in df.columns]

        df["uf"] = df["uf"].map(dict_uf)

        df.rename(columns=RENAME_DICT, inplace=True)
        df.columns



        for state in dict_uf.values():
            data = df[df["sigla_uf"] == state]
            if table_id != 'microdados_movimentacao_excluida':
                data = data.drop(["competenciamov", "sigla_uf", "regiao","competenciadec", "unidadesalariocodigo", "valorsalariofixo"], axis=1)
            else:
                data = data.drop(["competenciamov", "sigla_uf", "regiao","competenciadec", "unidadesalariocodigo", "valorsalariofixo", "competenciaexc"], axis=1)
            data.to_csv(
                f"/tmp/caged/{table_id}/output/ano={ano}/mes={mes}/sigla_uf={state}/data.csv",
                index=False,
            )
            del data
        del df

if __name__ == '__main__':
    YEARMONTH = '202301'
    TABLE =  'microdados_movimentacao'
    crawler_novo_caged_ftp(yearmonth=YEARMONTH)
    build_partitions(table_id=TABLE, yearmonth=YEARMONTH)
