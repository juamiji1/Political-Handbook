
*-------------------------------------------------------------------------------
*	MAKING SCATTER PLOTS
*
*-------------------------------------------------------------------------------
use "${idata}\wvs_series_gdp_country_year_lvl.dta", clear 

*Globals per topic:
gl trust "q65 q66 q69 q70 q71 q72 q73 q76"
gl percep "q224 q225 q227 q229 q232"
gl corrup "q113 q115"
gl action "q221 q222"
gl insec "q131 q132 q133 q134 q135 q136 q137 q138"
gl labored "q142 q143"
gl polviol "q192 q194"
gl citcult "q177 q178 q179 q180 q181"
gl polreg "q235 q236 q237 q238 q243 q245 q250 q251"
gl allvars "${trust} ${percep} ${corrup} ${action} ${insec} ${labored} ${polviol} ${citcult} ${polreg} q112"

*Some stats
preserve
	gen n=1 
	collapse (sum) n, by(iso)
	summ n, d 	// each country on average 3 rounds
restore

preserve
	gen n=1 
	collapse (sum) n, by(year)
	summ n, d	// on average 9 countries per year
restore

preserve
	gen n=1 
	collapse (sum) n, by(wave)
	summ n, d	// on average 43 countries per wave
restore

*Predict gdp with FEs
ren iso iso_string
encode iso_string, gen(iso)

reg ln_gdp i.year i.regionfe i.iso
predict gdp_u, resid

la var gdp_u "ln(GDP pc)"

*-------------------------------------------------------------------------------
*	TRUST IN INSTITUTIONS 
*-------------------------------------------------------------------------------
gl trust_inv "q65_inv q66_inv q69_inv q70_inv q71_inv q72_inv q73_inv q76_inv sum_trust_inv z_index_trust"

foreach var of global trust_inv {

	local varlabel : variable label `var'
	
	eststo x1: reghdfe `var' c.ln_gdp#i.wave if democracy==1, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	eststo x2: reghdfe `var' c.ln_gdp#i.wave if democracy==0, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	
	coefplot x1 x2, vert coeflabel(1.wave#c.ln_gdp = "1981-1984" 2.wave#c.ln_gdp ="1989-1993" 3.wave#c.ln_gdp ="1994-1998" 4.wave#c.ln_gdp ="1999-2004" 5.wave#c.ln_gdp ="2005-2009" 6.wave#c.ln_gdp ="2010-2014" 7.wave#c.ln_gdp ="2017-2022") yline(0, lc(gray)) xtitle("Wave", size(medium)) ytitle("`varlabel'", size(medsmall)) baselevels plotlabels("Democracy" "Non Democracy") legend(position(6) rows(1))
	gr export "${plots}/coefplot_`var'_bydem.pdf", as(pdf) replace
}

*-------------------------------------------------------------------------------
*	POLITICAL PERCEPTIONS  
*-------------------------------------------------------------------------------
gl percep_inv "q224_inv q225_inv q227_inv q229_inv q232_inv sum_percep_inv z_index_percep"

foreach var of global percep_inv {

	local varlabel : variable label `var'
	
	eststo x1: reghdfe `var' c.ln_gdp#i.wave if democracy==1, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	eststo x2: reghdfe `var' c.ln_gdp#i.wave if democracy==0, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	
	coefplot x1 x2, vert coeflabel(1.wave#c.ln_gdp = "1981-1984" 2.wave#c.ln_gdp ="1989-1993" 3.wave#c.ln_gdp ="1994-1998" 4.wave#c.ln_gdp ="1999-2004" 5.wave#c.ln_gdp ="2005-2009" 6.wave#c.ln_gdp ="2010-2014" 7.wave#c.ln_gdp ="2017-2022") yline(0, lc(gray)) xtitle("Wave", size(medium)) ytitle("`varlabel'", size(medsmall)) baselevels plotlabels("Democracy" "Non Democracy") legend(position(6) rows(1))
	gr export "${plots}/coefplot_`var'_bydem.pdf", as(pdf) replace
	
}

gl corrup "q113 q115 sum_corrup z_index_corrup"

foreach var of global corrup {

	local varlabel : variable label `var'
	
	eststo x1: reghdfe `var' c.ln_gdp#i.wave if democracy==1, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	eststo x2: reghdfe `var' c.ln_gdp#i.wave if democracy==0, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	
	coefplot x1 x2, vert coeflabel(1.wave#c.ln_gdp = "1981-1984" 2.wave#c.ln_gdp ="1989-1993" 3.wave#c.ln_gdp ="1994-1998" 4.wave#c.ln_gdp ="1999-2004" 5.wave#c.ln_gdp ="2005-2009" 6.wave#c.ln_gdp ="2010-2014" 7.wave#c.ln_gdp ="2017-2022") yline(0, lc(gray)) xtitle("Wave", size(medium)) ytitle("`varlabel'", size(medsmall)) baselevels plotlabels("Democracy" "Non Democracy") legend(position(6) rows(1))
	gr export "${plots}/coefplot_`var'_bydem.pdf", as(pdf) replace

}

*-------------------------------------------------------------------------------
*	POLITICAL ACTION  
*-------------------------------------------------------------------------------
gl action_inv "q221_inv q222_inv sum_action_inv z_index_action"

foreach var of global action_inv {

	local varlabel : variable label `var'
	
	eststo x1: reghdfe `var' c.ln_gdp#i.wave if democracy==1, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	eststo x2: reghdfe `var' c.ln_gdp#i.wave if democracy==0, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	
	coefplot x1 x2, vert coeflabel(1.wave#c.ln_gdp = "1981-1984" 2.wave#c.ln_gdp ="1989-1993" 3.wave#c.ln_gdp ="1994-1998" 4.wave#c.ln_gdp ="1999-2004" 5.wave#c.ln_gdp ="2005-2009" 6.wave#c.ln_gdp ="2010-2014" 7.wave#c.ln_gdp ="2017-2022") yline(0, lc(gray)) xtitle("Wave", size(medium)) ytitle("`varlabel'", size(medsmall)) baselevels plotlabels("Democracy" "Non Democracy") legend(position(6) rows(1))
	gr export "${plots}/coefplot_`var'_bydem.pdf", as(pdf) replace

}

*-------------------------------------------------------------------------------
*	OTHER PERCEPTIONS  
*-------------------------------------------------------------------------------
gl insec_inv "q131_inv q132_inv q133_inv q134_inv q135_inv q136_inv sum_insec_inv z_index_insec"

foreach var of global insec_inv {

	local varlabel : variable label `var'
	
	eststo x1: reghdfe `var' c.ln_gdp#i.wave if democracy==1, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	eststo x2: reghdfe `var' c.ln_gdp#i.wave if democracy==0, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	
	coefplot x1 x2, vert coeflabel(1.wave#c.ln_gdp = "1981-1984" 2.wave#c.ln_gdp ="1989-1993" 3.wave#c.ln_gdp ="1994-1998" 4.wave#c.ln_gdp ="1999-2004" 5.wave#c.ln_gdp ="2005-2009" 6.wave#c.ln_gdp ="2010-2014" 7.wave#c.ln_gdp ="2017-2022") yline(0, lc(gray)) xtitle("Wave", size(medium)) ytitle("`varlabel'", size(medsmall)) baselevels plotlabels("Democracy" "Non Democracy") legend(position(6) rows(1))
	gr export "${plots}/coefplot_`var'_bydem.pdf", as(pdf) replace

}

gl labored_inv "q142_inv q143_inv sum_labored_inv z_index_labored"

foreach var of global labored_inv {

	local varlabel : variable label `var'
	
	eststo x1: reghdfe `var' c.ln_gdp#i.wave if democracy==1, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	eststo x2: reghdfe `var' c.ln_gdp#i.wave if democracy==0, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	
	coefplot x1 x2, vert coeflabel(1.wave#c.ln_gdp = "1981-1984" 2.wave#c.ln_gdp ="1989-1993" 3.wave#c.ln_gdp ="1994-1998" 4.wave#c.ln_gdp ="1999-2004" 5.wave#c.ln_gdp ="2005-2009" 6.wave#c.ln_gdp ="2010-2014" 7.wave#c.ln_gdp ="2017-2022") yline(0, lc(gray)) xtitle("Wave", size(medium)) ytitle("`varlabel'", size(medsmall)) baselevels plotlabels("Democracy" "Non Democracy") legend(position(6) rows(1))
	gr export "${plots}/coefplot_`var'_bydem.pdf", as(pdf) replace

}

*-------------------------------------------------------------------------------
*	POLITICAL/CITIZEN CULTURE  
*-------------------------------------------------------------------------------
gl polviol "q192 q194 sum_polviol_inv z_index_polviol"

foreach var of global polviol {

	local varlabel : variable label `var'
	
	eststo x1: reghdfe `var' c.ln_gdp#i.wave if democracy==1, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	eststo x2: reghdfe `var' c.ln_gdp#i.wave if democracy==0, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	
	coefplot x1 x2, vert coeflabel(1.wave#c.ln_gdp = "1981-1984" 2.wave#c.ln_gdp ="1989-1993" 3.wave#c.ln_gdp ="1994-1998" 4.wave#c.ln_gdp ="1999-2004" 5.wave#c.ln_gdp ="2005-2009" 6.wave#c.ln_gdp ="2010-2014" 7.wave#c.ln_gdp ="2017-2022") yline(0, lc(gray)) xtitle("Wave", size(medium)) ytitle("`varlabel'", size(medsmall)) baselevels plotlabels("Democracy" "Non Democracy") legend(position(6) rows(1))
	gr export "${plots}/coefplot_`var'_bydem.pdf", as(pdf) replace

}

gl citcult "q177 q178 q179 q180 q181 sum_citcult_inv z_index_citcult"

foreach var of global citcult {

	local varlabel : variable label `var'
	
	eststo x1: reghdfe `var' c.ln_gdp#i.wave if democracy==1, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	eststo x2: reghdfe `var' c.ln_gdp#i.wave if democracy==0, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	
	coefplot x1 x2, vert coeflabel(1.wave#c.ln_gdp = "1981-1984" 2.wave#c.ln_gdp ="1989-1993" 3.wave#c.ln_gdp ="1994-1998" 4.wave#c.ln_gdp ="1999-2004" 5.wave#c.ln_gdp ="2005-2009" 6.wave#c.ln_gdp ="2010-2014" 7.wave#c.ln_gdp ="2017-2022") yline(0, lc(gray)) xtitle("Wave", size(medium)) ytitle("`varlabel'", size(medsmall)) baselevels plotlabels("Democracy" "Non Democracy") legend(position(6) rows(1))
	gr export "${plots}/coefplot_`var'_bydem.pdf", as(pdf) replace

}

*-------------------------------------------------------------------------------
*	POLITICAL REGIMES 
*-------------------------------------------------------------------------------
gl polreg "q235 q236 q237 q238 q243 q245 q250 q251"	

foreach var of global polreg {

	local varlabel : variable label `var'
	
	eststo x1: reghdfe `var' c.ln_gdp#i.wave if democracy==1, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	eststo x2: reghdfe `var' c.ln_gdp#i.wave if democracy==0, abs(i.year i.regionfe i.iso) nocons keepsingleton vce(cl iso)
	
	coefplot x1 x2, vert coeflabel(1.wave#c.ln_gdp = "1981-1984" 2.wave#c.ln_gdp ="1989-1993" 3.wave#c.ln_gdp ="1994-1998" 4.wave#c.ln_gdp ="1999-2004" 5.wave#c.ln_gdp ="2005-2009" 6.wave#c.ln_gdp ="2010-2014" 7.wave#c.ln_gdp ="2017-2022") yline(0, lc(gray)) xtitle("Wave", size(medium)) ytitle("`varlabel'", size(medsmall)) baselevels plotlabels("Democracy" "Non Democracy") legend(position(6) rows(1))
	gr export "${plots}/coefplot_`var'_bydem.pdf", as(pdf) replace

}

