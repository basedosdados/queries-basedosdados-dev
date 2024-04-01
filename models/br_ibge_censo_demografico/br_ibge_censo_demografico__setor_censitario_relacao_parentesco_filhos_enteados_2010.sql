{{
    config(
        alias="setor_censitario_relacao_parentesco_filhos_enteados_2010",
        schema="br_ibge_censo_demografico",
        materialized="table",
        partition_by={
            "field": "sigla_uf",
            "data_type": "string",
        },
    )
}}
select
    safe_cast(id_setor_censitario as string) id_setor_censitario,
    safe_cast(sigla_uf as string) sigla_uf,
    safe_cast(v001 as int64) v001,
    safe_cast(v002 as int64) v002,
    safe_cast(v003 as int64) v003,
    safe_cast(v004 as int64) v004,
    safe_cast(v005 as int64) v005,
    safe_cast(v006 as int64) v006,
    safe_cast(v007 as int64) v007,
    safe_cast(v008 as int64) v008,
    safe_cast(v009 as int64) v009,
    safe_cast(v010 as int64) v010,
    safe_cast(v011 as int64) v011,
    safe_cast(v012 as int64) v012,
    safe_cast(v013 as int64) v013,
    safe_cast(v014 as int64) v014,
    safe_cast(v015 as int64) v015,
    safe_cast(v016 as int64) v016,
    safe_cast(v017 as int64) v017,
    safe_cast(v018 as int64) v018,
    safe_cast(v019 as int64) v019,
    safe_cast(v020 as int64) v020,
    safe_cast(v021 as int64) v021,
    safe_cast(v022 as int64) v022,
    safe_cast(v023 as int64) v023,
    safe_cast(v024 as int64) v024,
    safe_cast(v025 as int64) v025,
    safe_cast(v026 as int64) v026,
    safe_cast(v027 as int64) v027,
    safe_cast(v028 as int64) v028,
    safe_cast(v029 as int64) v029,
    safe_cast(v030 as int64) v030,
    safe_cast(v031 as int64) v031,
    safe_cast(v032 as int64) v032,
    safe_cast(v033 as int64) v033,
    safe_cast(v034 as int64) v034,
    safe_cast(v035 as int64) v035,
    safe_cast(v036 as int64) v036,
    safe_cast(v037 as int64) v037,
    safe_cast(v038 as int64) v038,
    safe_cast(v039 as int64) v039,
    safe_cast(v040 as int64) v040,
    safe_cast(v041 as int64) v041,
    safe_cast(v042 as int64) v042,
    safe_cast(v043 as int64) v043,
    safe_cast(v044 as int64) v044,
    safe_cast(v045 as int64) v045,
    safe_cast(v046 as int64) v046,
    safe_cast(v047 as int64) v047,
    safe_cast(v048 as int64) v048,
    safe_cast(v049 as int64) v049,
    safe_cast(v050 as int64) v050,
    safe_cast(v051 as int64) v051,
    safe_cast(v052 as int64) v052,
    safe_cast(v053 as int64) v053,
    safe_cast(v054 as int64) v054,
    safe_cast(v055 as int64) v055,
    safe_cast(v056 as int64) v056,
    safe_cast(v057 as int64) v057,
    safe_cast(v058 as int64) v058,
    safe_cast(v059 as int64) v059,
    safe_cast(v060 as int64) v060,
    safe_cast(v061 as int64) v061,
    safe_cast(v062 as int64) v062,
    safe_cast(v063 as int64) v063,
    safe_cast(v064 as int64) v064,
    safe_cast(v065 as int64) v065,
    safe_cast(v066 as int64) v066,
    safe_cast(v067 as int64) v067,
    safe_cast(v068 as int64) v068,
    safe_cast(v069 as int64) v069,
    safe_cast(v070 as int64) v070,
    safe_cast(v071 as int64) v071,
    safe_cast(v072 as int64) v072,
    safe_cast(v073 as int64) v073,
    safe_cast(v074 as int64) v074,
    safe_cast(v075 as int64) v075,
    safe_cast(v076 as int64) v076,
    safe_cast(v077 as int64) v077,
    safe_cast(v078 as int64) v078,
    safe_cast(v079 as int64) v079,
    safe_cast(v080 as int64) v080,
    safe_cast(v081 as int64) v081,
    safe_cast(v082 as int64) v082,
    safe_cast(v083 as int64) v083,
    safe_cast(v084 as int64) v084,
    safe_cast(v085 as int64) v085,
    safe_cast(v086 as int64) v086,
    safe_cast(v087 as int64) v087,
    safe_cast(v088 as int64) v088,
    safe_cast(v089 as int64) v089,
    safe_cast(v090 as int64) v090,
    safe_cast(v091 as int64) v091,
    safe_cast(v092 as int64) v092,
    safe_cast(v093 as int64) v093,
    safe_cast(v094 as int64) v094,
    safe_cast(v095 as int64) v095,
    safe_cast(v096 as int64) v096,
    safe_cast(v097 as int64) v097,
    safe_cast(v098 as int64) v098,
    safe_cast(v099 as int64) v099,
    safe_cast(v100 as int64) v100,
    safe_cast(v101 as int64) v101,
    safe_cast(v102 as int64) v102,
    safe_cast(v103 as int64) v103,
    safe_cast(v104 as int64) v104,
    safe_cast(v105 as int64) v105,
    safe_cast(v106 as int64) v106,
    safe_cast(v107 as int64) v107,
    safe_cast(v108 as int64) v108,
    safe_cast(v109 as int64) v109,
    safe_cast(v110 as int64) v110,
    safe_cast(v111 as int64) v111,
    safe_cast(v112 as int64) v112,
    safe_cast(v113 as int64) v113,
    safe_cast(v114 as int64) v114,
    safe_cast(v115 as int64) v115,
    safe_cast(v116 as int64) v116,
    safe_cast(v117 as int64) v117,
    safe_cast(v118 as int64) v118,
    safe_cast(v119 as int64) v119,
    safe_cast(v120 as int64) v120,
    safe_cast(v121 as int64) v121,
    safe_cast(v122 as int64) v122,
    safe_cast(v123 as int64) v123,
    safe_cast(v124 as int64) v124,
    safe_cast(v125 as int64) v125,
    safe_cast(v126 as int64) v126,
    safe_cast(v127 as int64) v127,
    safe_cast(v128 as int64) v128,
    safe_cast(v129 as int64) v129,
    safe_cast(v130 as int64) v130,
    safe_cast(v131 as int64) v131,
    safe_cast(v132 as int64) v132,
    safe_cast(v133 as int64) v133,
    safe_cast(v134 as int64) v134,
    safe_cast(v135 as int64) v135,
    safe_cast(v136 as int64) v136,
    safe_cast(v137 as int64) v137,
    safe_cast(v138 as int64) v138,
    safe_cast(v139 as int64) v139,
    safe_cast(v140 as int64) v140,
    safe_cast(v141 as int64) v141,
    safe_cast(v142 as int64) v142,
    safe_cast(v143 as int64) v143,
    safe_cast(v144 as int64) v144,
    safe_cast(v145 as int64) v145,
    safe_cast(v146 as int64) v146,
    safe_cast(v147 as int64) v147,
    safe_cast(v148 as int64) v148,
    safe_cast(v149 as int64) v149,
    safe_cast(v150 as int64) v150,
    safe_cast(v151 as int64) v151,
    safe_cast(v152 as int64) v152,
    safe_cast(v153 as int64) v153,
    safe_cast(v154 as int64) v154,
    safe_cast(v155 as int64) v155,
    safe_cast(v156 as int64) v156,
    safe_cast(v157 as int64) v157,
    safe_cast(v158 as int64) v158,
    safe_cast(v159 as int64) v159,
    safe_cast(v160 as int64) v160,
    safe_cast(v161 as int64) v161,
    safe_cast(v162 as int64) v162,
    safe_cast(v163 as int64) v163,
    safe_cast(v164 as int64) v164,
    safe_cast(v165 as int64) v165,
    safe_cast(v166 as int64) v166,
    safe_cast(v167 as int64) v167,
    safe_cast(v168 as int64) v168,
    safe_cast(v169 as int64) v169,
    safe_cast(v170 as int64) v170,
    safe_cast(v171 as int64) v171,
    safe_cast(v172 as int64) v172,
    safe_cast(v173 as int64) v173,
    safe_cast(v174 as int64) v174,
    safe_cast(v175 as int64) v175,
    safe_cast(v176 as int64) v176,
    safe_cast(v177 as int64) v177,
    safe_cast(v178 as int64) v178,
    safe_cast(v179 as int64) v179,
    safe_cast(v180 as int64) v180,
    safe_cast(v181 as int64) v181,
    safe_cast(v182 as int64) v182,
    safe_cast(v183 as int64) v183,
    safe_cast(v184 as int64) v184,
    safe_cast(v185 as int64) v185,
    safe_cast(v186 as int64) v186,
    safe_cast(v187 as int64) v187,
    safe_cast(v188 as int64) v188,
    safe_cast(v189 as int64) v189,
    safe_cast(v190 as int64) v190,
    safe_cast(v191 as int64) v191,
    safe_cast(v192 as int64) v192,
    safe_cast(v193 as int64) v193,
    safe_cast(v194 as int64) v194,
    safe_cast(v195 as int64) v195,
    safe_cast(v196 as int64) v196,
    safe_cast(v197 as int64) v197,
    safe_cast(v198 as int64) v198,
    safe_cast(v199 as int64) v199,
    safe_cast(v200 as int64) v200,
    safe_cast(v201 as int64) v201,
    safe_cast(v202 as int64) v202,
    safe_cast(v203 as int64) v203,
    safe_cast(v204 as int64) v204,
    safe_cast(v205 as int64) v205,
    safe_cast(v206 as int64) v206,
    safe_cast(v207 as int64) v207,
    safe_cast(v208 as int64) v208,
    safe_cast(v209 as int64) v209,
    safe_cast(v210 as int64) v210,
    safe_cast(v211 as int64) v211,
    safe_cast(v212 as int64) v212,
    safe_cast(v213 as int64) v213,
    safe_cast(v214 as int64) v214,
    safe_cast(v215 as int64) v215,
    safe_cast(v216 as int64) v216,
    safe_cast(v217 as int64) v217,
    safe_cast(v218 as int64) v218,
    safe_cast(v219 as int64) v219,
    safe_cast(v220 as int64) v220,
    safe_cast(v221 as int64) v221,
    safe_cast(v222 as int64) v222,
    safe_cast(v223 as int64) v223,
    safe_cast(v224 as int64) v224,
    safe_cast(v225 as int64) v225,
    safe_cast(v226 as int64) v226,
    safe_cast(v227 as int64) v227,
    safe_cast(v228 as int64) v228,
    safe_cast(v229 as int64) v229,
    safe_cast(v230 as int64) v230,
    safe_cast(v231 as int64) v231,
    safe_cast(v232 as int64) v232,
    safe_cast(v233 as int64) v233,
    safe_cast(v234 as int64) v234,
    safe_cast(v235 as int64) v235,
    safe_cast(v236 as int64) v236,
    safe_cast(v237 as int64) v237,
    safe_cast(v238 as int64) v238,
    safe_cast(v239 as int64) v239,
    safe_cast(v240 as int64) v240,
    safe_cast(v241 as int64) v241,
    safe_cast(v242 as int64) v242,
    safe_cast(v243 as int64) v243,
    safe_cast(v244 as int64) v244,
    safe_cast(v245 as int64) v245,
    safe_cast(v246 as int64) v246,
    safe_cast(v247 as int64) v247,
    safe_cast(v248 as int64) v248,
    safe_cast(v249 as int64) v249,
    safe_cast(v250 as int64) v250,
    safe_cast(v251 as int64) v251,
    safe_cast(v252 as int64) v252,
    safe_cast(v253 as int64) v253,
    safe_cast(v254 as int64) v254
from
    `basedosdados-dev.br_ibge_censo_demografico_staging.setor_censitario_relacao_parentesco_filhos_enteados_2010`
    as t
