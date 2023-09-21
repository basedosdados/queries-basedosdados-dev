{{ 
  config(
    alias='setor_censitario_relacao_parentesco_outros_2010',
    schema='br_ibge_censo_demografico',
    materialized='table',
    )
 }}
SELECT 
SAFE_CAST(id_setor_censitario AS STRING) id_setor_censitario,
SAFE_CAST(sigla_uf AS STRING) sigla_uf,
SAFE_CAST(v001 AS INT64) v001,
SAFE_CAST(v002 AS INT64) v002,
SAFE_CAST(v003 AS INT64) v003,
SAFE_CAST(v004 AS INT64) v004,
SAFE_CAST(v005 AS INT64) v005,
SAFE_CAST(v006 AS INT64) v006,
SAFE_CAST(v007 AS INT64) v007,
SAFE_CAST(v008 AS INT64) v008,
SAFE_CAST(v009 AS INT64) v009,
SAFE_CAST(v010 AS INT64) v010,
SAFE_CAST(v011 AS INT64) v011,
SAFE_CAST(v012 AS INT64) v012,
SAFE_CAST(v013 AS INT64) v013,
SAFE_CAST(v014 AS INT64) v014,
SAFE_CAST(v015 AS INT64) v015,
SAFE_CAST(v016 AS INT64) v016,
SAFE_CAST(v017 AS INT64) v017,
SAFE_CAST(v018 AS INT64) v018,
SAFE_CAST(v019 AS INT64) v019,
SAFE_CAST(v020 AS INT64) v020,
SAFE_CAST(v021 AS INT64) v021,
SAFE_CAST(v022 AS INT64) v022,
SAFE_CAST(v023 AS INT64) v023,
SAFE_CAST(v024 AS INT64) v024,
SAFE_CAST(v025 AS INT64) v025,
SAFE_CAST(v026 AS INT64) v026,
SAFE_CAST(v027 AS INT64) v027,
SAFE_CAST(v028 AS INT64) v028,
SAFE_CAST(v029 AS INT64) v029,
SAFE_CAST(v030 AS INT64) v030,
SAFE_CAST(v031 AS INT64) v031,
SAFE_CAST(v032 AS INT64) v032,
SAFE_CAST(v033 AS INT64) v033,
SAFE_CAST(v034 AS INT64) v034,
SAFE_CAST(v035 AS INT64) v035,
SAFE_CAST(v036 AS INT64) v036,
SAFE_CAST(v037 AS INT64) v037,
SAFE_CAST(v038 AS INT64) v038,
SAFE_CAST(v039 AS INT64) v039,
SAFE_CAST(v040 AS INT64) v040,
SAFE_CAST(v041 AS INT64) v041,
SAFE_CAST(v042 AS INT64) v042,
SAFE_CAST(v043 AS INT64) v043,
SAFE_CAST(v044 AS INT64) v044,
SAFE_CAST(v045 AS INT64) v045,
SAFE_CAST(v046 AS INT64) v046,
SAFE_CAST(v047 AS INT64) v047,
SAFE_CAST(v048 AS INT64) v048,
SAFE_CAST(v049 AS INT64) v049,
SAFE_CAST(v050 AS INT64) v050,
SAFE_CAST(v051 AS INT64) v051,
SAFE_CAST(v052 AS INT64) v052,
SAFE_CAST(v053 AS INT64) v053,
SAFE_CAST(v054 AS INT64) v054,
SAFE_CAST(v055 AS INT64) v055,
SAFE_CAST(v056 AS INT64) v056,
SAFE_CAST(v057 AS INT64) v057,
SAFE_CAST(v058 AS INT64) v058,
SAFE_CAST(v059 AS INT64) v059,
SAFE_CAST(v060 AS INT64) v060,
SAFE_CAST(v061 AS INT64) v061,
SAFE_CAST(v062 AS INT64) v062,
SAFE_CAST(v063 AS INT64) v063,
SAFE_CAST(v064 AS INT64) v064,
SAFE_CAST(v065 AS INT64) v065,
SAFE_CAST(v066 AS INT64) v066,
SAFE_CAST(v067 AS INT64) v067,
SAFE_CAST(v068 AS INT64) v068,
SAFE_CAST(v069 AS INT64) v069,
SAFE_CAST(v070 AS INT64) v070,
SAFE_CAST(v071 AS INT64) v071,
SAFE_CAST(v072 AS INT64) v072,
SAFE_CAST(v073 AS INT64) v073,
SAFE_CAST(v074 AS INT64) v074,
SAFE_CAST(v075 AS INT64) v075,
SAFE_CAST(v076 AS INT64) v076,
SAFE_CAST(v077 AS INT64) v077,
SAFE_CAST(v078 AS INT64) v078,
SAFE_CAST(v079 AS INT64) v079,
SAFE_CAST(v080 AS INT64) v080,
SAFE_CAST(v081 AS INT64) v081,
SAFE_CAST(v082 AS INT64) v082,
SAFE_CAST(v083 AS INT64) v083,
SAFE_CAST(v084 AS INT64) v084,
SAFE_CAST(v085 AS INT64) v085,
SAFE_CAST(v086 AS INT64) v086,
SAFE_CAST(v087 AS INT64) v087,
SAFE_CAST(v088 AS INT64) v088,
SAFE_CAST(v089 AS INT64) v089,
SAFE_CAST(v090 AS INT64) v090,
SAFE_CAST(v091 AS INT64) v091,
SAFE_CAST(v092 AS INT64) v092,
SAFE_CAST(v093 AS INT64) v093,
SAFE_CAST(v094 AS INT64) v094,
SAFE_CAST(v095 AS INT64) v095,
SAFE_CAST(v096 AS INT64) v096,
SAFE_CAST(v097 AS INT64) v097,
SAFE_CAST(v098 AS INT64) v098,
SAFE_CAST(v099 AS INT64) v099,
SAFE_CAST(v100 AS INT64) v100,
SAFE_CAST(v101 AS INT64) v101,
SAFE_CAST(v102 AS INT64) v102,
SAFE_CAST(v103 AS INT64) v103,
SAFE_CAST(v104 AS INT64) v104,
SAFE_CAST(v105 AS INT64) v105,
SAFE_CAST(v106 AS INT64) v106,
SAFE_CAST(v107 AS INT64) v107,
SAFE_CAST(v108 AS INT64) v108,
SAFE_CAST(v109 AS INT64) v109,
SAFE_CAST(v110 AS INT64) v110,
SAFE_CAST(v111 AS INT64) v111,
SAFE_CAST(v112 AS INT64) v112,
SAFE_CAST(v113 AS INT64) v113,
SAFE_CAST(v114 AS INT64) v114,
SAFE_CAST(v115 AS INT64) v115,
SAFE_CAST(v116 AS INT64) v116,
SAFE_CAST(v117 AS INT64) v117,
SAFE_CAST(v118 AS INT64) v118,
SAFE_CAST(v119 AS INT64) v119,
SAFE_CAST(v120 AS INT64) v120,
SAFE_CAST(v121 AS INT64) v121,
SAFE_CAST(v122 AS INT64) v122,
SAFE_CAST(v123 AS INT64) v123,
SAFE_CAST(v124 AS INT64) v124,
SAFE_CAST(v125 AS INT64) v125,
SAFE_CAST(v126 AS INT64) v126,
SAFE_CAST(v127 AS INT64) v127,
SAFE_CAST(v128 AS INT64) v128,
SAFE_CAST(v129 AS INT64) v129,
SAFE_CAST(v130 AS INT64) v130,
SAFE_CAST(v131 AS INT64) v131,
SAFE_CAST(v132 AS INT64) v132,
SAFE_CAST(v133 AS INT64) v133,
SAFE_CAST(v134 AS INT64) v134,
SAFE_CAST(v135 AS INT64) v135,
SAFE_CAST(v136 AS INT64) v136,
SAFE_CAST(v137 AS INT64) v137,
SAFE_CAST(v138 AS INT64) v138,
SAFE_CAST(v139 AS INT64) v139,
SAFE_CAST(v140 AS INT64) v140,
SAFE_CAST(v141 AS INT64) v141,
SAFE_CAST(v142 AS INT64) v142,
SAFE_CAST(v143 AS INT64) v143,
SAFE_CAST(v144 AS INT64) v144,
SAFE_CAST(v145 AS INT64) v145,
SAFE_CAST(v146 AS INT64) v146,
SAFE_CAST(v147 AS INT64) v147,
SAFE_CAST(v148 AS INT64) v148,
SAFE_CAST(v149 AS INT64) v149,
SAFE_CAST(v150 AS INT64) v150,
SAFE_CAST(v151 AS INT64) v151,
SAFE_CAST(v152 AS INT64) v152,
SAFE_CAST(v153 AS INT64) v153,
SAFE_CAST(v154 AS INT64) v154,
SAFE_CAST(v155 AS INT64) v155,
SAFE_CAST(v156 AS INT64) v156,
SAFE_CAST(v157 AS INT64) v157,
SAFE_CAST(v158 AS INT64) v158,
SAFE_CAST(v159 AS INT64) v159,
SAFE_CAST(v160 AS INT64) v160,
SAFE_CAST(v161 AS INT64) v161,
SAFE_CAST(v162 AS INT64) v162,
SAFE_CAST(v163 AS INT64) v163,
SAFE_CAST(v164 AS INT64) v164,
SAFE_CAST(v165 AS INT64) v165,
SAFE_CAST(v166 AS INT64) v166,
SAFE_CAST(v167 AS INT64) v167,
SAFE_CAST(v168 AS INT64) v168,
SAFE_CAST(v169 AS INT64) v169,
SAFE_CAST(v170 AS INT64) v170,
SAFE_CAST(v171 AS INT64) v171,
SAFE_CAST(v172 AS INT64) v172,
SAFE_CAST(v173 AS INT64) v173,
SAFE_CAST(v174 AS INT64) v174,
SAFE_CAST(v175 AS INT64) v175,
SAFE_CAST(v176 AS INT64) v176,
SAFE_CAST(v177 AS INT64) v177,
SAFE_CAST(v178 AS INT64) v178,
SAFE_CAST(v179 AS INT64) v179,
SAFE_CAST(v180 AS INT64) v180,
SAFE_CAST(v181 AS INT64) v181,
SAFE_CAST(v182 AS INT64) v182,
SAFE_CAST(v183 AS INT64) v183,
SAFE_CAST(v184 AS INT64) v184,
SAFE_CAST(v185 AS INT64) v185,
SAFE_CAST(v186 AS INT64) v186,
SAFE_CAST(v187 AS INT64) v187,
SAFE_CAST(v188 AS INT64) v188,
SAFE_CAST(v189 AS INT64) v189,
SAFE_CAST(v190 AS INT64) v190,
SAFE_CAST(v191 AS INT64) v191,
SAFE_CAST(v192 AS INT64) v192,
SAFE_CAST(v193 AS INT64) v193,
SAFE_CAST(v194 AS INT64) v194,
SAFE_CAST(v195 AS INT64) v195,
SAFE_CAST(v196 AS INT64) v196,
SAFE_CAST(v197 AS INT64) v197,
SAFE_CAST(v198 AS INT64) v198,
SAFE_CAST(v199 AS INT64) v199,
SAFE_CAST(v200 AS INT64) v200,
SAFE_CAST(v201 AS INT64) v201,
SAFE_CAST(v202 AS INT64) v202,
SAFE_CAST(v203 AS INT64) v203,
SAFE_CAST(v204 AS INT64) v204,
SAFE_CAST(v205 AS INT64) v205,
SAFE_CAST(v206 AS INT64) v206,
SAFE_CAST(v207 AS INT64) v207,
SAFE_CAST(v208 AS INT64) v208,
SAFE_CAST(v209 AS INT64) v209,
SAFE_CAST(v210 AS INT64) v210,
SAFE_CAST(v211 AS INT64) v211,
SAFE_CAST(v212 AS INT64) v212,
SAFE_CAST(v213 AS INT64) v213,
SAFE_CAST(v214 AS INT64) v214,
SAFE_CAST(v215 AS INT64) v215,
SAFE_CAST(v216 AS INT64) v216,
SAFE_CAST(v217 AS INT64) v217,
SAFE_CAST(v218 AS INT64) v218,
SAFE_CAST(v219 AS INT64) v219,
SAFE_CAST(v220 AS INT64) v220,
SAFE_CAST(v221 AS INT64) v221,
SAFE_CAST(v222 AS INT64) v222,
SAFE_CAST(v223 AS INT64) v223,
SAFE_CAST(v224 AS INT64) v224,
SAFE_CAST(v225 AS INT64) v225,
SAFE_CAST(v226 AS INT64) v226,
SAFE_CAST(v227 AS INT64) v227,
SAFE_CAST(v228 AS INT64) v228,
SAFE_CAST(v229 AS INT64) v229,
SAFE_CAST(v230 AS INT64) v230,
SAFE_CAST(v231 AS INT64) v231,
SAFE_CAST(v232 AS INT64) v232,
SAFE_CAST(v233 AS INT64) v233,
SAFE_CAST(v234 AS INT64) v234,
SAFE_CAST(v235 AS INT64) v235,
SAFE_CAST(v236 AS INT64) v236,
SAFE_CAST(v237 AS INT64) v237,
SAFE_CAST(v238 AS INT64) v238,
SAFE_CAST(v239 AS INT64) v239,
SAFE_CAST(v240 AS INT64) v240
from basedosdados-dev.br_ibge_censo_demografico_staging.setor_censitario_relacao_parentesco_outros_2010 as t