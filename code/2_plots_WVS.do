
*-------------------------------------------------------------------------------
*	MAKING SCATTER PLOTS
*
*-------------------------------------------------------------------------------
use "${idata}\wvs7_gdp_country_lvl.dta", clear 

*-------------------------------------------------------------------------------
*	TRUST IN INSTITUTIONS 
*-------------------------------------------------------------------------------
gl trust_inv "q65_inv q66_inv q69_inv q70_inv q71_inv q72_inv q73_inv q76_inv sum_trust_inv z_index_trust"

foreach var of global trust_inv {
	summ `var', d
	*replace `var'=. if `var'>= r(p99) |  `var'<= r(p1)
	
	local varlabel : variable label `var'
	two (scatter `var' ln_gdp1723) (lowess `var' ln_gdp1723) (lfit `var' ln_gdp1723), ytitle("`varlabel'", size(medsmall)) legend(off)
	gr export "${plots}/scatter_`var'.pdf", as(pdf) replace
}

*-------------------------------------------------------------------------------
*	POLITICAL PERCEPTIONS  
*-------------------------------------------------------------------------------
gl percep_inv "q224_inv q225_inv q227_inv q229_inv q232_inv q252 sum_percep_inv z_index_percep"

foreach var of global percep_inv {
	summ `var', d
	*replace `var'=. if `var'>= r(p99) |  `var'<= r(p1)
	
	local varlabel : variable label `var'
	two (scatter `var' ln_gdp1723) (lowess `var' ln_gdp1723) (lfit `var' ln_gdp1723), ytitle("`varlabel'", size(medsmall)) legend(off)
	gr export "${plots}/scatter_`var'.pdf", as(pdf) replace
}

gl corrup "q113 q115 sum_corrup z_index_corrup"

foreach var of global corrup {
	summ `var', d
	*replace `var'=. if `var'>= r(p99) |  `var'<= r(p1)
	
	local varlabel : variable label `var'
	two (scatter `var' ln_gdp1723) (lowess `var' ln_gdp1723) (lfit `var' ln_gdp1723), ytitle("`varlabel'", size(medsmall)) legend(off)
	gr export "${plots}/scatter_`var'.pdf", as(pdf) replace
}

*-------------------------------------------------------------------------------
*	POLITICAL ACTION  
*-------------------------------------------------------------------------------
gl action_inv "q221_inv q222_inv sum_action_inv z_index_action"

foreach var of global action_inv {
	summ `var', d
	*replace `var'=. if `var'>= r(p99) |  `var'<= r(p1)
	
	local varlabel : variable label `var'
	two (scatter `var' ln_gdp1723) (lowess `var' ln_gdp1723) (lfit `var' ln_gdp1723), ytitle("`varlabel'", size(medsmall)) legend(off)
	gr export "${plots}/scatter_`var'.pdf", as(pdf) replace
}

*-------------------------------------------------------------------------------
*	OTHER PERCEPTIONS  
*-------------------------------------------------------------------------------
gl insec_inv "q131_inv q132_inv q133_inv q134_inv q135_inv q136_inv q137_inv q138_inv sum_insec_inv z_index_insec"

foreach var of global insec_inv {
	summ `var', d
	*replace `var'=. if `var'>= r(p99) |  `var'<= r(p1)
	
	local varlabel : variable label `var'
	two (scatter `var' ln_gdp1723) (lowess `var' ln_gdp1723) (lfit `var' ln_gdp1723), ytitle("`varlabel'", size(medsmall)) legend(off)
	gr export "${plots}/scatter_`var'.pdf", as(pdf) replace
}

gl labored_inv "q142_inv q143_inv sum_labored_inv z_index_labored"

foreach var of global labored_inv {
	summ `var', d
	*replace `var'=. if `var'>= r(p99) |  `var'<= r(p1)
	
	local varlabel : variable label `var'
	two (scatter `var' ln_gdp1723) (lowess `var' ln_gdp1723) (lfit `var' ln_gdp1723), ytitle("`varlabel'", size(medsmall)) legend(off)
	gr export "${plots}/scatter_`var'.pdf", as(pdf) replace
}

*-------------------------------------------------------------------------------
*	POLITICAL/CITIZEN CULTURE  
*-------------------------------------------------------------------------------
gl polviol "q192 q194 sum_polviol_inv z_index_polviol"

foreach var of global polviol {
	summ `var', d
	*replace `var'=. if `var'>= r(p99) |  `var'<= r(p1)
	
	local varlabel : variable label `var'
	two (scatter `var' ln_gdp1723) (lowess `var' ln_gdp1723) (lfit `var' ln_gdp1723), ytitle("`varlabel'", size(medsmall)) legend(off)
	gr export "${plots}/scatter_`var'.pdf", as(pdf) replace
}

gl citcult "q177 q178 q179 q180 q181 sum_citcult_inv z_index_citcult"

foreach var of global citcult {
	summ `var', d
	*replace `var'=. if `var'>= r(p99) |  `var'<= r(p1)
	
	local varlabel : variable label `var'
	two (scatter `var' ln_gdp1723) (lowess `var' ln_gdp1723) (lfit `var' ln_gdp1723), ytitle("`varlabel'", size(medsmall)) legend(off)
	gr export "${plots}/scatter_`var'.pdf", as(pdf) replace
}

*-------------------------------------------------------------------------------
*	POLITICAL REGIMES 
*-------------------------------------------------------------------------------
gl polreg "q235 q236 q237 q238 q243 q245 q250 q251"	

foreach var of global polreg {
	summ `var', d
	*replace `var'=. if `var'>= r(p99) |  `var'<= r(p1)
	
	local varlabel : variable label `var'
	two (scatter `var' ln_gdp1723) (lowess `var' ln_gdp1723) (lfit `var' ln_gdp1723), ytitle("`varlabel'", size(medsmall)) legend(off)
	gr export "${plots}/scatter_`var'.pdf", as(pdf) replace
}




*END

