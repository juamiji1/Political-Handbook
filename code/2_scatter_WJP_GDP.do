
use "${idata}\wjp_wb_vhda_13_24_country_lvl.dta", clear

*-------------------------------------------------------------------------------
*	ACCOUNTABILITY (FOR VARIOUS MEASURES)
*-------------------------------------------------------------------------------
gl account "factor1constraintsongovernm factor2absenceofcorruption i at bd va_index ida_index a_vdemcore va_vdemcore ha_vdemcore da_vdemcore"

*Using Vdem Index Classification
foreach var of global account {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' vdem_index if year==2022 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if year==2022 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if year==2022 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if year==2022 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' vdem_index if year==2022, lc("stc2")), ///
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
		(lowess `var' ln_gdp if year==2022 & vdem_index>.42 , lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("ln(GDP)", size(medium)) ytitle("`varlabel'", size(small))  xtitle("") 
	gr export "${plots}/scatter_`var'_WJP_GDP.pdf", as(pdf) replace

}

*-------------------------------------------------------------------------------
* Correlations of accountability and corruption measures 
*-------------------------------------------------------------------------------
gl accountability "factor1constraintsongovernm i h va_index ida_index a_vdemcore va_vdemcore ha_vdemcore da_vdemcore"
gl corruption "factor2absenceofcorruption pc_vdemcore ec_vdemcore cp_index"

foreach avar of global accountability {
	
	local avarlabel : variable label `avar' 
	
	foreach cvar of global corruption {
	
		local cvarlabel : variable label `cvar' 
		
		two (scatter `avar' `cvar' if year==2022 & vdem_index>.42 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
			(scatter `avar' `cvar' if year==2022 & vdem_index>.42 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
			(scatter `avar' `cvar' if year==2022 & vdem_index>.42 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
			(scatter `avar' `cvar' if year==2022 & vdem_index>.42 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
			(lowess `avar' `cvar' if year==2022 & vdem_index>.42 , lc("stc2")), ///
			legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("`cvarlabel'", size(medium)) ytitle("`avarlabel'", size(small))  xtitle("") 
		gr export "${plots}/scatter_`avar'_`cvar'.pdf", as(pdf) replace
		
	}

}

*-------------------------------------------------------------------------------
* Correlations of accountability and media capture measures 
*-------------------------------------------------------------------------------
gl accountability "factor1constraintsongovernm i h va_index ida_index a_vdemcore va_vdemcore ha_vdemcore da_vdemcore"
gl media "pf_index"

foreach avar of global accountability {
	
	local avarlabel : variable label `avar' 
	
	foreach cvar of global media {
	
		local cvarlabel : variable label `cvar' 
		
		two (scatter `avar' `cvar' if year==2022 & vdem_index>.42 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
			(scatter `avar' `cvar' if year==2022 & vdem_index>.42 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
			(scatter `avar' `cvar' if year==2022 & vdem_index>.42 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
			(scatter `avar' `cvar' if year==2022 & vdem_index>.42 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
			(lowess `avar' `cvar' if year==2022 & vdem_index>.42 , lc("stc2")), ///
			legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("`cvarlabel'", size(medium)) ytitle("`avarlabel'", size(small))  xtitle("") 
		gr export "${plots}/scatter_`avar'_`cvar'.pdf", as(pdf) replace
		
	}

}

*-------------------------------------------------------------------------------
* Media capture & GDP correlations
*-------------------------------------------------------------------------------
gl media "pf_index"

*Using Vdem Index Classification
foreach var of global media {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' ln_gdp if year==2022 & vdem_index>.42 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if year==2022 & vdem_index>.42 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if year==2022 & vdem_index>.42 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if year==2022 & vdem_index>.42 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' ln_gdp if year==2022 & vdem_index>.42 , lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("ln(GDP)", size(medium)) ytitle("`varlabel'", size(small))  xtitle("") 
	gr export "${plots}/scatter_`var'_WJP_GDP.pdf", as(pdf) replace

}

*-------------------------------------------------------------------------------
* Correlations of accountability and judicial independence measures 
*-------------------------------------------------------------------------------
gl accountability "factor1constraintsongovernm i h va_index ida_index a_vdemcore va_vdemcore ha_vdemcore da_vdemcore"
gl judicial "wjpruleoflawindexoveralls au be jc_vdemcore"
foreach avar of global accountability {
	
	local avarlabel : variable label `avar' 
	
	foreach cvar of global judicial {
	
		local cvarlabel : variable label `cvar' 
		
		two (scatter `avar' `cvar' if year==2022 & vdem_index>.42 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
			(scatter `avar' `cvar' if year==2022 & vdem_index>.42 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
			(scatter `avar' `cvar' if year==2022 & vdem_index>.42 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
			(scatter `avar' `cvar' if year==2022 & vdem_index>.42 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
			(lowess `avar' `cvar' if year==2022 & vdem_index>.42 , lc("stc2")), ///
			legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("`cvarlabel'", size(medium)) ytitle("`avarlabel'", size(small))  xtitle("") 
		gr export "${plots}/scatter_`avar'_`cvar'.pdf", as(pdf) replace
		
	}

}

*-------------------------------------------------------------------------------
* Judicial independence & GDP correlations
*-------------------------------------------------------------------------------
gl judicial "wjpruleoflawindexoveralls au be jc_vdemcore"

*Using Vdem Index Classification
foreach var of global judicial {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' ln_gdp if year==2022 & vdem_index>.42 & regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if year==2022 & vdem_index>.42 & regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if year==2022 & vdem_index>.42 & regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' ln_gdp if year==2022 & vdem_index>.42 & regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' ln_gdp if year==2022 & vdem_index>.42 , lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("ln(GDP)", size(medium)) ytitle("`varlabel'", size(small))  xtitle("") 
	gr export "${plots}/scatter_`var'_WJP_GDP.pdf", as(pdf) replace

}







*END



