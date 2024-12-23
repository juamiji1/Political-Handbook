
use "${idata}\barometer_22_23_country_lvl.dta", clear

gen vdem_regime_v2=vdem_regime
replace vdem_regime_v2=1 if vdem_regime_v2==0

*-------------------------------------------------------------------------------
*	MAKING MEAN PLOTS
*
*-------------------------------------------------------------------------------

*-------------------------------------------------------------------------------
*	PERCEPTIONS
*-------------------------------------------------------------------------------
gl percep "d_political d_crime d_economic d_unemployment"

*Using Vdem Index Classification
foreach var of global percep {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' ln_gdp if vdem_regime>1 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' ln_gdp if vdem_regime>1, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("ln(GDP)", size(medium)) ytitle("`varlabel'", size(medsmall))  xtitle("") 
	gr export "${plots}/scatter_`var'_barometer_GDP.pdf", as(pdf) replace

}

*-------------------------------------------------------------------------------
*	ACCOUNTABILITY
*-------------------------------------------------------------------------------
gl account "d_corruption d_parties d_elections d_reduce_corrup d_rleader_corruption d_local_corruption d_nat_corruption d_courts d_corrup_politicians"

*Using Vdem Index Classification
foreach var of global account {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' ln_gdp if vdem_regime>1 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if vdem_regime>1 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' ln_gdp if vdem_regime>1, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("ln(GDP)", size(medium)) ytitle("`varlabel'", size(medsmall))  xtitle("") 
	gr export "${plots}/scatter_`var'_barometer_GDP.pdf", as(pdf) replace

}

local var d_corruption
local varlabel : variable label `var' 
two (scatter `var' ln_gdp if vdem_regime>1 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
	(scatter `var' ln_gdp if vdem_regime>1 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
	(lowess `var' ln_gdp if vdem_regime>1 & regionfe<3, lc("stc2")), ///
	legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("ln(GDP)", size(medium)) ytitle("`varlabel'", size(medsmall))  xtitle("") 
gr export "${plots}/scatter_`var'_barometer_GDP_v2.pdf", as(pdf) replace

local var d_corruption_spread
local varlabel : variable label `var' 
two (scatter `var' ln_gdp if vdem_regime>1 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh) mcolor("stc4")) ///
	(lowess `var' ln_gdp if vdem_regime>1 & regionfe==4, lc("stc2")), ///
	legend(position(6) row(1) label(1 "Europe") label(2 "Lowess")) b2title("ln(GDP)", size(medium)) ytitle("`varlabel'", size(medsmall))  xtitle("") 
gr export "${plots}/scatter_`var'_barometer_GDP.pdf", as(pdf) replace



*END
