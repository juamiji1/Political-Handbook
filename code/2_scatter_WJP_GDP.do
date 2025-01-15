
use "${idata}\wjp_wb_vhda_13_24_country_lvl.dta", clear

*-------------------------------------------------------------------------------
*	ACCOUNTABILITY (FOR VARIOUS MEASURES)
*-------------------------------------------------------------------------------
gl account "factor1constraintsongovernm i at bd va_index ida_index"

*Using Vdem Index Classification
foreach var of global account {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' vdem_index if year==2022 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if year==2022 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if year==2022 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if year==2022 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' vdem_index, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("Regime Classification (VDEM Index)", size(medium)) ytitle("`varlabel'", size(small))  xtitle("") 
	gr export "${plots}/scatter_`var'_WJP_vdem_index.pdf", as(pdf) replace

}

gl vhda "accountability_index vertical_index horizontal_index diagonal_index"

foreach var of global vhda {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' vdem_index if year==2016 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if year==2016 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if year==2016 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if year==2016 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' vdem_index, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("Regime Classification (VDEM Index)", size(medium)) ytitle("`varlabel'", size(small))  xtitle("") 
	gr export "${plots}/scatter_`var'_WJP_vdem_index.pdf", as(pdf) replace

}

*-------------------------------------------------------------------------------
*	ACCOUNTABILITY (FOR COURTS & GDP)
*-------------------------------------------------------------------------------
*Using Vdem Index Classification
foreach var of global account {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' ln_gdp if year==2022 & vdem_index>.42 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if year==2022 & vdem_index>.42 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if year==2022 & vdem_index>.42 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if year==2022 & vdem_index>.42 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' ln_gdp if vdem_regime>1, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("ln(GDP)", size(medium)) ytitle("`varlabel'", size(small))  xtitle("") 
	gr export "${plots}/scatter_`var'_WJP_GDP.pdf", as(pdf) replace

}

foreach var of global vhda {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' ln_gdp if year==2016 & vdem_index>.42 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if year==2016 & vdem_index>.42 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if year==2016 & vdem_index>.42 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if year==2016 & vdem_index>.42 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' ln_gdp if vdem_regime>1, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("ln(GDP)", size(medium)) ytitle("`varlabel'", size(small))  xtitle("") 
	gr export "${plots}/scatter_`var'_WJP_GDP.pdf", as(pdf) replace

}




*END