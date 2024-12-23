
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
	
	mat C2=J(3,3,.)
	mat coln C2 ="Closed/Electoral autocracy" "Electoral democracy" "Liberal democracy"

	reghdfe `var' i.vdem_regime_v2, abs(i.year i.regionfe) keepsingleton
	lincom _cons
	mat C2[1,1]=`r(estimate)'
	mat C2[2,1]=`r(lb)'
	mat C2[3,1]=`r(ub)'

	forval i=2/3{
		local c=`i'	

		lincom _cons + `i'.vdem_regime_v2
		mat C2[1,`c']=`r(estimate)'
		mat C2[2,`c']=`r(lb)'
		mat C2[3,`c']=`r(ub)'
		
	}

	local varlabel : variable label `var' 
	coefplot (mat(C2[1]), ci((2 3))), vert ciopts(recast(rcap)) b2title("Regime Classification (VDEM Index)", size(medium)) ytitle("`varlabel'", size(medsmall)) xlabel(, labsize(medsmall))
	gr export "${plots}/coefplot_`var'_vdem_v2.pdf", as(pdf) replace

}


*-------------------------------------------------------------------------------
*	ACCOUNTABILITY
*-------------------------------------------------------------------------------
gl account "d_corruption d_parties d_elections d_reduce_corrup d_rleader_corruption d_local_corruption d_nat_corruption d_courts d_corrup_politicians"

*Using Vdem Index Classification
foreach var of global account {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' vdem_index if regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' vdem_index, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("Regime Classification (VDEM Index)", size(medium)) ytitle("`varlabel'", size(medsmall))  xtitle("") 
	gr export "${plots}/scatter_`var'_vdem_index.pdf", as(pdf) replace

}

*Using Vdem Index Classification
foreach var of global account {
	
	mat C2=J(3,3,.)
	mat coln C2 ="Closed/Electoral autocracy" "Electoral democracy" "Liberal democracy"

	reghdfe `var' i.vdem_regime_v2, abs(i.year i.regionfe) keepsingleton
	lincom _cons
	mat C2[1,1]=`r(estimate)'
	mat C2[2,1]=`r(lb)'
	mat C2[3,1]=`r(ub)'

	forval i=2/3{
		local c=`i'	

		cap lincom _cons + `i'.vdem_regime_v2
		cap mat C2[1,`c']=`r(estimate)'
		cap mat C2[2,`c']=`r(lb)'
		cap mat C2[3,`c']=`r(ub)'
		
	}

	local varlabel : variable label `var' 
	coefplot (mat(C2[1]), ci((2 3))), vert ciopts(recast(rcap)) b2title("Regime Classification (VDEM Index)", size(medium)) ytitle("`varlabel'", size(medsmall)) xlabel(, labsize(medsmall))
	gr export "${plots}/coefplot_`var'_vdem_v2.pdf", as(pdf) replace

}



	

*END
	
	