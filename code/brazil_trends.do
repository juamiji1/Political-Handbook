use "${idata}\wvs_series_gdp_country_year_lvl.dta", clear 

keep if iso=="BRA"

sort year

*-------------------------------------------------------------------------------
*	TRUST IN INSTITUTIONS 
*-------------------------------------------------------------------------------
gl trust_inv "q65_inv q66_inv q69_inv q70_inv q71_inv q72_inv q73_inv q76_inv"

foreach var of global trust_inv{
		
		replace d_`var'=. if d_`var'==0
}

foreach var of global trust_inv{	
				
	tempvar rvar
	gen `rvar'=round(d_`var', .001)
	
	two (scatter d_`var' year if !missing(d_`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
	(bar d_`var' year if !missing(d_`var'), fcolor(gs8) lcolor(gs8)) ///
	(line d_`var' year if !missing(d_`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
	legend(off) b2title("Year of WVS survey", size(medium)) ///
	l2title("`: var label d_`var''", size(medium)) xtitle("") ytitle("") 
	
	gr export "${plots}/brazil_trend_d_`var'.pdf", as(pdf) replace

}

la var index_trust "Trust index (ICW)"
local var index_trust 
			
tempvar rvar
gen `rvar'=round(`var', .001)
	
two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
(bar `var' year if !missing(`var'), fcolor(gs8) lcolor(gs8)) ///
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year of WVS survey", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 
	
gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace
	
*-------------------------------------------------------------------------------
*	POLITICAL PERCEPTIONS  
*-------------------------------------------------------------------------------
gl percep_inv "q224_inv q225_inv q227_inv q229_inv q231_inv q232_inv"

foreach var of global percep_inv{
		
		replace d_`var'=. if d_`var'==0
}

foreach var of global percep_inv{
			
	tempvar rvar
	gen `rvar'=round(d_`var', .001)

	two (scatter d_`var' year if !missing(d_`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
	(bar d_`var' year if !missing(d_`var'), fcolor(gs8) lcolor(gs8)) ///
	(line d_`var' year if !missing(d_`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
	legend(off) b2title("Year of WVS survey", size(medium)) ///
	l2title("`: var label d_`var''", size(medium)) xtitle("") ytitle("") 
	
	gr export "${plots}/brazil_trend_d_`var'.pdf", as(pdf) replace
}

la var index_percep "Political perception index (ICW)"
local var index_percep 

tempvar rvar
gen `rvar'=round(`var', .001)

two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
(bar `var' year if !missing(`var'), fcolor(gs8) lcolor(gs8)) ///
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year of WVS survey", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 
	
gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace


*-------------------------------------------------------------------------------
*	POLITICAL ACTION  
*-------------------------------------------------------------------------------
gl action_inv "q221_inv q222_inv"
	
foreach var of global action_inv{
		
		replace d_`var'=. if d_`var'==0
}

foreach var of global action_inv{
	
	tempvar rvar
	gen `rvar'=round(d_`var', .001)

	two (scatter d_`var' year if !missing(d_`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
	(bar d_`var' year if !missing(d_`var'), fcolor(gs8) lcolor(gs8)) ///
	(line d_`var' year if !missing(d_`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
	legend(off) b2title("Year of WVS survey", size(medium)) ///
	l2title("`: var label d_`var''", size(medium)) xtitle("") ytitle("") 
	
	gr export "${plots}/brazil_trend_d_`var'.pdf", as(pdf) replace
}

la var index_action "Politicial action index (ICW)"
local var index_action 

tempvar rvar
gen `rvar'=round(`var', .001)

two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
(bar `var' year if !missing(`var'), fcolor(gs8) lcolor(gs8)) ///
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year of WVS survey", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 
	
gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
*	INFORMATION
*-------------------------------------------------------------------------------
gl info "q201 q202 q206 q207 q208"

foreach var of global info{
		
		replace d_`var'=. if d_`var'==0
}

foreach var of global info{
	
	tempvar rvar
	gen `rvar'=round(d_`var', .001)

	two (scatter d_`var' year if !missing(d_`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
	(bar d_`var' year if !missing(d_`var'), fcolor(gs8) lcolor(gs8)) ///
	(line d_`var' year if !missing(d_`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
	legend(off) b2title("Year of WVS survey", size(medium)) ///
	l2title("`: var label d_`var''", size(medium)) xtitle("") ytitle("") 
	
	gr export "${plots}/brazil_trend_d_`var'.pdf", as(pdf) replace
}


	
	
*END