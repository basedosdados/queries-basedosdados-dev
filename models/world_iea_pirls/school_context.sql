SELECT
SAFE_CAST(country_iso3_code AS STRING) country_iso3_code,
SAFE_CAST(country_id AS STRING) country_id,
SAFE_CAST(population_id AS STRING) population_id,
SAFE_CAST(standardized_grade_id AS STRING) standardized_grade_id,
SAFE_CAST(grade_id AS STRING) grade_id,
SAFE_CAST(school_id AS STRING) school_id,
SAFE_CAST(language_school_questionnaire AS STRING) language_school_questionnaire,
SAFE_CAST(locale_school_questionnaire_id AS STRING) locale_school_questionnaire_id,
SAFE_CAST(acbg03a AS STRING) acbg03a,
SAFE_CAST(acbg03b AS STRING) acbg03b,
SAFE_CAST(acbg04 AS STRING) acbg04,
SAFE_CAST(acbg05a AS STRING) acbg05a,
SAFE_CAST(acbg05b AS STRING) acbg05b,
SAFE_CAST(acbg06a AS INT64) acbg06a,
SAFE_CAST(acbg06b AS INT64) acbg06b,
SAFE_CAST(acbg06c AS STRING) acbg06c,
SAFE_CAST(acbg07a AS BOOL) acbg07a,
SAFE_CAST(acbg07b AS STRING) acbg07b,
SAFE_CAST(acbg07c AS BOOL) acbg07c,
SAFE_CAST(acbg08 AS BOOL) acbg08,
SAFE_CAST(acbg09 AS INT64) acbg09,
SAFE_CAST(acbg10aa AS STRING) acbg10aa,
SAFE_CAST(acbg10ab AS STRING) acbg10ab,
SAFE_CAST(acbg10ac AS STRING) acbg10ac,
SAFE_CAST(acbg10ad AS STRING) acbg10ad,
SAFE_CAST(acbg10ae AS STRING) acbg10ae,
SAFE_CAST(acbg10af AS STRING) acbg10af,
SAFE_CAST(acbg10ag AS STRING) acbg10ag,
SAFE_CAST(acbg10ah AS STRING) acbg10ah,
SAFE_CAST(acbg10ai AS STRING) acbg10ai,
SAFE_CAST(acbg10aj AS STRING) acbg10aj,
SAFE_CAST(acbg10ba AS STRING) acbg10ba,
SAFE_CAST(acbg10bb AS STRING) acbg10bb,
SAFE_CAST(acbg10bc AS STRING) acbg10bc,
SAFE_CAST(acbg10bd AS STRING) acbg10bd,
SAFE_CAST(acbg11a AS STRING) acbg11a,
SAFE_CAST(acbg11b AS STRING) acbg11b,
SAFE_CAST(acbg11c AS STRING) acbg11c,
SAFE_CAST(acbg11d AS STRING) acbg11d,
SAFE_CAST(acbg11e AS STRING) acbg11e,
SAFE_CAST(acbg11f AS STRING) acbg11f,
SAFE_CAST(acbg11g AS STRING) acbg11g,
SAFE_CAST(acbg11h AS STRING) acbg11h,
SAFE_CAST(acbg11i AS STRING) acbg11i,
SAFE_CAST(acbg11j AS STRING) acbg11j,
SAFE_CAST(acbg11k AS STRING) acbg11k,
SAFE_CAST(acbg11l AS STRING) acbg11l,
SAFE_CAST(acbg12a AS STRING) acbg12a,
SAFE_CAST(acbg12b AS STRING) acbg12b,
SAFE_CAST(acbg12c AS STRING) acbg12c,
SAFE_CAST(acbg12d AS STRING) acbg12d,
SAFE_CAST(acbg12e AS STRING) acbg12e,
SAFE_CAST(acbg12f AS STRING) acbg12f,
SAFE_CAST(acbg12g AS STRING) acbg12g,
SAFE_CAST(acbg12h AS STRING) acbg12h,
SAFE_CAST(acbg12i AS STRING) acbg12i,
SAFE_CAST(acbg12j AS STRING) acbg12j,
SAFE_CAST(acbg13 AS STRING) acbg13,
SAFE_CAST(acbg14a AS STRING) acbg14a,
SAFE_CAST(acbg14b AS STRING) acbg14b,
SAFE_CAST(acbg14c AS STRING) acbg14c,
SAFE_CAST(acbg14d AS STRING) acbg14d,
SAFE_CAST(acbg14e AS STRING) acbg14e,
SAFE_CAST(acbg14f AS STRING) acbg14f,
SAFE_CAST(acbg14g AS STRING) acbg14g,
SAFE_CAST(acbg14h AS STRING) acbg14h,
SAFE_CAST(acbg14i AS STRING) acbg14i,
SAFE_CAST(acbg14j AS STRING) acbg14j,
SAFE_CAST(acbg14k AS STRING) acbg14k,
SAFE_CAST(acbg14l AS STRING) acbg14l,
SAFE_CAST(acbg14m AS STRING) acbg14m,
SAFE_CAST(acbg14n AS STRING) acbg14n,
SAFE_CAST(acbg15 AS INT64) acbg15,
SAFE_CAST(acbg16 AS INT64) acbg16,
SAFE_CAST(acbg17 AS STRING) acbg17,
SAFE_CAST(acbg18a AS BOOL) acbg18a,
SAFE_CAST(acbg18b AS BOOL) acbg18b,
SAFE_CAST(acbg18c AS BOOL) acbg18c,
SAFE_CAST(acbg19 AS STRING) acbg19,
SAFE_CAST(acbg20 AS STRING) acbg20,
SAFE_CAST(acbg21a AS BOOL) acbg21a,
SAFE_CAST(acbg21b AS BOOL) acbg21b,
SAFE_CAST(acbg21c AS BOOL) acbg21c,
SAFE_CAST(acbg21d AS BOOL) acbg21d,
SAFE_CAST(acbg21e AS BOOL) acbg21e,
SAFE_CAST(acbg21f AS BOOL) acbg21f,
SAFE_CAST(school_level_weight AS FLOAT64) school_level_weight,
SAFE_CAST(sum_student_weights AS FLOAT64) sum_student_weights,
SAFE_CAST(school_weight_adjustment AS FLOAT64) school_weight_adjustment,
SAFE_CAST(school_weight_factor AS FLOAT64) school_weight_factor,
SAFE_CAST(replicate_code AS STRING) replicate_code,
SAFE_CAST(zone_code AS STRING) zone_code,
SAFE_CAST(acbgrrs AS FLOAT64) acbgrrs,
SAFE_CAST(acdgrrs AS STRING) acdgrrs,
SAFE_CAST(acbgeas AS FLOAT64) acbgeas,
SAFE_CAST(acdgeas AS STRING) acdgeas,
SAFE_CAST(acbgdas AS FLOAT64) acbgdas,
SAFE_CAST(acdgdas AS STRING) acdgdas,
SAFE_CAST(acdgsbc AS STRING) acdgsbc,
SAFE_CAST(acdgtihy AS FLOAT64) acdgtihy,
SAFE_CAST(version AS STRING) version,
SAFE_CAST(scope AS STRING) scope,
SAFE_CAST(pirls_type AS STRING) pirls_type,
FROM basedosdados-dev.world_iea_pirls_staging.school_context AS t

