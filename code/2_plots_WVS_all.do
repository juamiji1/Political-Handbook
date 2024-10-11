
*-------------------------------------------------------------------------------
*	MAKING SCATTER PLOTS
*
*-------------------------------------------------------------------------------
use "${idata}\wvs_series_gdp_country_year_lvl.dta", clear 

*Predict gdp with FEs
ren iso iso_string
encode iso_string, gen(iso)

reg ln_gdp i.year i.regionfe i.iso
predict gdp_u if ln_gdp!=., resid

la var gdp_u "ln(GDP pc)"

*-------------------------------------------------------------------------------
*	TRUST IN INSTITUTIONS 
*-------------------------------------------------------------------------------
gl trust_inv "q65_inv q66_inv q69_inv q70_inv q71_inv q72_inv q73_inv q76_inv sum_trust_inv z_index_trust"

foreach var of global trust_inv {
	
	reg `var' i.year i.regionfe i.iso
	predict `var'_u, resid

	local varlabel : variable label `var'
	binscatter `var'_u gdp_u, nbins(70) mcolor("stc1") lcolor("stc2") ytitle("`varlabel'", size(medium)) xtitle("ln(GDP pc)")
	gr export "${plots}/binscatter_`var'_u_all.pdf", as(pdf) replace
}

*-------------------------------------------------------------------------------
*	POLITICAL PERCEPTIONS  
*-------------------------------------------------------------------------------
gl percep_inv "q224_inv q225_inv q227_inv q229_inv q232_inv sum_percep_inv z_index_percep"

foreach var of global percep_inv {
	reg `var' i.year i.regionfe i.iso
	predict `var'_u, resid
	
	summ `var'_u, d
	*replace `var'_u=. if `var'_u>= r(p99) |  `var'_u<= r(p1)
	
	local varlabel : variable label `var'
	binscatter `var'_u gdp_u, nbins(70) mcolor("stc1") lcolor("stc2") ytitle("`varlabel'", size(medium)) xtitle("ln(GDP pc)")
	gr export "${plots}/binscatter_`var'_u_all.pdf", as(pdf) replace
}

gl corrup "q113 q115 sum_corrup z_index_corrup"

foreach var of global corrup {
	reg `var' i.year i.regionfe i.iso
	predict `var'_u, resid
	
	summ `var'_u, d
	*replace `var'_u=. if `var'_u>= r(p99) |  `var'_u<= r(p1)
	
	local varlabel : variable label `var'
	binscatter `var'_u gdp_u, nbins(70) mcolor("stc1") lcolor("stc2") ytitle("`varlabel'", size(medium)) xtitle("ln(GDP pc)")
	gr export "${plots}/binscatter_`var'_u_all.pdf", as(pdf) replace
}

*-------------------------------------------------------------------------------
*	POLITICAL ACTION  
*-------------------------------------------------------------------------------
gl action_inv "q221_inv q222_inv sum_action_inv z_index_action"

foreach var of global action_inv {
	reg `var' i.year i.regionfe i.iso
	predict `var'_u, resid
	
	summ `var'_u, d
	*replace `var'_u=. if `var'_u>= r(p99) |  `var'_u<= r(p1)
	
	local varlabel : variable label `var'
	binscatter `var'_u gdp_u, nbins(70) mcolor("stc1") lcolor("stc2") ytitle("`varlabel'", size(medium)) xtitle("ln(GDP pc)")
	gr export "${plots}/binscatter_`var'_u_all.pdf", as(pdf) replace
}

*-------------------------------------------------------------------------------
*	OTHER PERCEPTIONS  
*-------------------------------------------------------------------------------
gl insec_inv "q131_inv q132_inv q133_inv q134_inv q135_inv q136_inv sum_insec_inv z_index_insec"

foreach var of global insec_inv {
	reg `var' i.year i.regionfe i.iso
	predict `var'_u, resid
	
	summ `var'_u, d
	*replace `var'_u=. if `var'_u>= r(p99) |  `var'_u<= r(p1)
	
	local varlabel : variable label `var'
	binscatter `var'_u gdp_u, nbins(70) mcolor("stc1") lcolor("stc2") ytitle("`varlabel'", size(medium)) xtitle("ln(GDP pc)")
	gr export "${plots}/binscatter_`var'_u_all.pdf", as(pdf) replace
}

gl labored_inv "q142_inv q143_inv sum_labored_inv z_index_labored"

foreach var of global labored_inv {
	reg `var' i.year i.regionfe i.iso
	predict `var'_u, resid
	
	summ `var'_u, d
	*replace `var'_u=. if `var'_u>= r(p99) |  `var'_u<= r(p1)
	
	local varlabel : variable label `var'
	binscatter `var'_u gdp_u, nbins(70) mcolor("stc1") lcolor("stc2") ytitle("`varlabel'", size(medium)) xtitle("ln(GDP pc)")
	gr export "${plots}/binscatter_`var'_u_all.pdf", as(pdf) replace
}

*-------------------------------------------------------------------------------
*	POLITICAL/CITIZEN CULTURE  
*-------------------------------------------------------------------------------
gl polviol "q192 q194 sum_polviol_inv z_index_polviol"

foreach var of global polviol {
	reg `var' i.year i.regionfe i.iso
	predict `var'_u, resid
	
	summ `var'_u, d
	*replace `var'_u=. if `var'_u>= r(p99) |  `var'_u<= r(p1)
	
	local varlabel : variable label `var'
	binscatter `var'_u gdp_u, nbins(70) mcolor("stc1") lcolor("stc2") ytitle("`varlabel'", size(medium)) xtitle("ln(GDP pc)")
	gr export "${plots}/binscatter_`var'_u_all.pdf", as(pdf) replace
}

gl citcult "q177 q178 q179 q180 q181 sum_citcult_inv z_index_citcult"

foreach var of global citcult {
	reg `var' i.year i.regionfe i.iso
	predict `var'_u, resid
	
	summ `var'_u, d
	*replace `var'_u=. if `var'_u>= r(p99) |  `var'_u<= r(p1)
	
	local varlabel : variable label `var'
	binscatter `var'_u gdp_u, nbins(70) mcolor("stc1") lcolor("stc2") ytitle("`varlabel'", size(medium)) xtitle("ln(GDP pc)")
	gr export "${plots}/binscatter_`var'_u_all.pdf", as(pdf) replace
}

*-------------------------------------------------------------------------------
*	POLITICAL REGIMES 
*-------------------------------------------------------------------------------
gl polreg "q235 q236 q237 q238 q243 q245 q250 q251"	

foreach var of global polreg {
	reg `var' i.year i.regionfe i.iso
	predict `var'_u, resid
	
	summ `var'_u, d
	*replace `var'_u=. if `var'_u>= r(p99) |  `var'_u<= r(p1)
	
	local varlabel : variable label `var'
	binscatter `var'_u gdp_u, nbins(70) mcolor("stc1") lcolor("stc2") ytitle("`varlabel'", size(medium)) xtitle("ln(GDP pc)")
	gr export "${plots}/binscatter_`var'_u_all.pdf", as(pdf) replace
}




*END