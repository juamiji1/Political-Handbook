*Making Scatter plots 
use "${idata}\wvs7_gdp_country_lvl.dta", clear 

*-------------------------------------------------------------------------------
*	AGGREGATE MEASURES
*-------------------------------------------------------------------------------
gl wvs_sums "sum_trust_inv sum_percep_inv sum_corrup sum_action_inv sum_insec_inv sum_labored_inv sum_polviol_inv sum_citcult_inv"
gl wvs_zindex "z_index_trust z_index_percep z_index_corrup z_index_action z_index_insec z_index_labored z_index_polviol z_index_citcult"

foreach var of global wvs_sums {
	summ `var', d
	replace `var'=. if `var'>= r(p99) |  `var'<= r(p1)
	
	local varlabel : variable label `var'
	two (scatter `var' ln_gdp1723) (lowess `var' ln_gdp1723) (lfit `var' ln_gdp1723), ytitle("`varlabel'", size(medium)) legend(off)
	gr export "${plots}/scatter_`var'.pdf", as(pdf) replace
}

foreach var of global wvs_zindex {
	summ `var', d
	replace `var'=. if `var'>=r(p99) |  `var'<= r(p1)
	
	local varlabel : variable label `var'
	two (scatter `var' ln_gdp1723) (lowess `var' ln_gdp1723) (lfit `var' ln_gdp1723), ytitle("`varlabel'", size(medium)) legend(off)
	gr export "${plots}/scatter_`var'.pdf", as(pdf) replace
}




*END

