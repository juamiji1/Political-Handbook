
*-------------------------------------------------------------------------------
*	PREPARING DATA
*
*-------------------------------------------------------------------------------
use "${idata}\wvs_series_gdp_country_year_lvl.dta", clear 

bys iso: egen max_year=max(year)
keep if max_year==year

gen vdem_regime_v2=vdem_regime
replace vdem_regime_v2=1 if vdem_regime_v2==0

*-------------------------------------------------------------------------------
*	MAKING PLOTS
*
*-------------------------------------------------------------------------------


*-------------------------------------------------------------------------------
*	VOTING AND CONSTRAINTS
*-------------------------------------------------------------------------------
gl voting "d_q221_inv d_q222_inv d_q224_inv d_q225_inv d_q227_inv d_q229_inv d_q231_inv d_q232_inv"

*Using Vdem Index Classification
foreach var of global voting {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' ln_gdp if vdem_regime>1 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' ln_gdp  if vdem_regime>1, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("ln(GDP)", size(medium)) ytitle("`varlabel'", size(medsmall))  xtitle("") 
	gr export "${plots}/scatter_`var'_WVS_GDP.pdf", as(pdf) replace

}

*-------------------------------------------------------------------------------
*	INFORMATION
*-------------------------------------------------------------------------------
gl info "d_q201 d_q202 d_q206 d_q207 d_q208"

*Using Vdem Index Classification
foreach var of global info {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' ln_gdp if vdem_regime>1 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' ln_gdp if vdem_regime>1, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("ln(GDP)", size(medium)) ytitle("`varlabel'", size(medsmall))  xtitle("") 
	gr export "${plots}/scatter_`var'_WVS_GDP.pdf", as(pdf) replace

}

*-------------------------------------------------------------------------------
*	ACCOUNTABILITY
*-------------------------------------------------------------------------------
gl account "d_q292a d_q292b d_q292c d_q292e d_q292g d_q292i d_q292j d_q292k d_q292l"

*Using Vdem Index Classification
foreach var of global account {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' ln_gdp if vdem_regime>1 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' ln_gdp if vdem_regime>1, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("ln(GDP)", size(medium)) ytitle("`varlabel'", size(medsmall))  xtitle("") 
	gr export "${plots}/scatter_`var'_WVS_GDP.pdf", as(pdf) replace

}

gl corrup "d_q113 d_q115 d_q116"

*Using Vdem Index Classification
foreach var of global corrup {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' ln_gdp if vdem_regime>1 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' ln_gdp if vdem_regime>1, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("ln(GDP)", size(medium)) ytitle("`varlabel'", size(medsmall))  xtitle("") 
	gr export "${plots}/scatter_`var'_WVS_GDP.pdf", as(pdf) replace

}



*END

