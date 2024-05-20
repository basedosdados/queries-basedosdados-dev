{{ config(alias="aihs_reduzidas", schema="br_ms_sih") }}
select
    safe_cast(ano as int64) ano,
    safe_cast(mes as int64) mes,
    safe_cast(n_aih as int64) id_aih,
    safe_cast(ident as string) tipo_aih,
    safe_cast(gestor_cod as int64) motivo_autorizacao_aih,
    safe_cast(ltrim(sequencia) as string) sequencial_aih,
    safe_cast(espec as int64) especialidade_leito,
    safe_cast(cobranca as int64) motivo_saida,
    safe_cast(marca_uti as int64) tipo_uti,
    safe_cast(marca_uci as int64) tipo_uci,
    safe_cast(car_int as int64) carater_internacao,
    safe_cast(
        format_date('%Y-%m-%d', safe.parse_date('%Y%m%d', dt_inter)) as date
    ) data_internacao,
    safe_cast(
        format_date('%Y-%m-%d', safe.parse_date('%Y%m%d', dt_saida)) as date
    ) data_saida,
    safe_cast(munic_mov as string) id_municipio_estabelecimento,
    safe_cast(cnes as string) id_estabelecimento_cnes,
    safe_cast(nat_jur as int64) natureza_juridica_estabelecimento,
    safe_cast(natureza as int64) natureza_juridica_estabelecimento_ate_2012,
    safe_cast(regexp_replace(cgc_hosp, '0{14}', '') as string),
    safe_cast(gestao as string) tipo_gestao_estabelecimento,
    safe_cast(uf_zi as string) id_municipio_gestor,
    safe_cast(gestor_tp as string) tipo_gestor,
    safe_cast(gestor_cpf as string) cpf_gestor,
    safe_cast(gestor_dt as date) data_autorizacao_gestor,
    safe_cast(cnpj_mant as string) cnpj_mantenedora,
    safe_cast(munic_res as string) id_municipio_paciente,
    safe_cast(cep as string) cep_paciente,
    safe_cast(nasc as date) data_nascimento_paciente,
    safe_cast(idade as int64) idade_paciente,
    safe_cast(cod_idade as string) unidade_medida_idade_paciente,
    case
        safe_cast(sexo as int64)
        when 0
        then 'Ignorado'
        when 9
        then 'Não definida'
        when 1
        then 'Masculino'
        when 2
        then 'Feminino'
        when 3
        then 'Feminino'
    end as sexo_paciente,
    case
        safe_cast(raca_cor as int64)
        when 0
        then 'Sem Informação'
        when 99
        then 'Sem Informação'
        when 1
        then 'Branca'
        when 2
        then 'Preta'
        when 3
        then 'Parda'
        when 4
        then 'Amarela'
        when 5
        then 'Indígena'
    end as raca_cor_paciente,
    safe_cast(etnia as string) etnia_paciente,
    safe_cast(nacional as string) codigo_nacionalidade_paciente,
    safe_cast(cbor as string) cbo_2002_paciente,
    safe_cast(homonimo as string) indicador_paciente_homonimo,
    safe_cast(instru as string) grau_instrucao_paciente,
    safe_cast(num_filhos as int64) quantidade_filhos_paciente,
    safe_cast(cnaer as string) id_acidente_trabalho,
    safe_cast(vincprev as string) indicador_vinculo_previdencia,
    safe_cast(insc_pn as string) id_gestante_pre_natal,
    safe_cast(gestrisco as string) indicador_gestante_risco,
    safe_cast(contracep1 as string) tipo_contraceptivo_principal,
    safe_cast(contracep2 as string) tipo_contraceptivo_secundario,
    safe_cast(seq_aih5 as string) sequencial_longa_permanencia,
    safe_cast(proc_solic as string) procedimento_solicitado,
    safe_cast(proc_rea as string) procedimento_realizado,
    safe_cast(infehosp as string) indicador_infeccao_hospitalar,
    safe_cast(complex as string) complexidade,
    safe_cast(ind_vdrl as string) indicador_exame_vdrl,
    safe_cast(financ as string) tipo_financiamento,
    safe_cast(faec_tp as string) subtipo_financiamento,
    safe_cast(regct as string) regra_contratual,
    safe_cast(cid_notif as string) cid_notificacao_subcategoria,
    safe_cast(cid_asso as string) cid_causa_subcategoria,
    safe_cast(diag_princ as string) cid_principal_subcategoria,
    safe_cast(diag_secun as string) cid_secundario_subcategoria,
    safe_cast(diagsec1 as string) diagnostico_secundario_1,
    safe_cast(diagsec2 as string) diagnostico_secundario_2,
    safe_cast(diagsec3 as string) diagnostico_secundario_3,
    safe_cast(diagsec4 as string) diagnostico_secundario_4,
    safe_cast(diagsec5 as string) diagnostico_secundario_5,
    safe_cast(diagsec6 as string) diagnostico_secundario_6,
    safe_cast(diagsec7 as string) diagnostico_secundario_7,
    safe_cast(diagsec8 as string) diagnostico_secundario_8,
    safe_cast(diagsec9 as string) diagnostico_secundario_9,
    safe_cast(tpdisec1 as string) tipo_diagnostico_secundario_1,
    safe_cast(tpdisec2 as string) tipo_diagnostico_secundario_2,
    safe_cast(tpdisec3 as string) tipo_diagnostico_secundario_3,
    safe_cast(tpdisec4 as string) tipo_diagnostico_secundario_4,
    safe_cast(tpdisec5 as string) tipo_diagnostico_secundario_5,
    safe_cast(tpdisec6 as string) tipo_diagnostico_secundario_6,
    safe_cast(tpdisec7 as string) tipo_diagnostico_secundario_7,
    safe_cast(tpdisec8 as string) tipo_diagnostico_secundario_8,
    safe_cast(tpdisec9 as string) tipo_diagnostico_secundario_9,
    safe_cast(cid_morte as string) cid_morte_subcategoria,
    safe_cast(morte as int64) indicador_obito,
    safe_cast(remessa as int64) remessa,
    safe_cast(aud_just as string) justificativa_auditor,
    safe_cast(sis_just as string) justificativa_estabelecimento,
    safe_cast(uti_mes_to as int64) quantidade_dias_uti_mes,
    safe_cast(uti_int_to as int64) quantidade_dias_unidade_intermediaria,
    safe_cast(diar_acom as int64) quantidade_dias_acompanhate,
    safe_cast(qt_diarias as int64) quantidade_dias,
    safe_cast(dias_perm as int64) quantidade_dias_permanencia,
    safe_cast(val_sh_fed as float64) valor_complemento_federal_servicos_hospitalares,
    safe_cast(val_sp_fed as float64) valor_complemento_federal_servicos_profissionais,
    safe_cast(val_sh_ges as float64) valor_complemento_gestor_servicos_hospitalares,
    safe_cast(val_sp_ges as float64) valor_complemento_gestor_servicos_profissionais,
    safe_cast(val_uci as float64) valor_uci,
    safe_cast(val_sh as float64) valor_serivico_hospitalar,
    safe_cast(val_sp as float64) valor_servico_profissional,
    safe_cast(val_uti as float64) valor_uti,
    safe_cast(us_tot as float64) valor_dolar,
    safe_cast(val_tot as float64) valor_aih,
from `basedosdados-dev.br_ms_sih_staging.aihs_reduzidas` as t
