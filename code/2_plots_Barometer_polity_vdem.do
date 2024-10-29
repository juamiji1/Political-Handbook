
use "${idata}\barometer_22_23_country_lvl.dta", clear

*-------------------------------------------------------------------------------
*	MAKING MEAN PLOTS
*
*-------------------------------------------------------------------------------

*-------------------------------------------------------------------------------
*	PERCEPTIONS
*-------------------------------------------------------------------------------
gl percep "d_political d_crime d_economic d_unemployment"

*Using Polity Index Classification
foreach var of global percep {
	
	mat C1=J(3,3,.)
	mat coln C1 = "Autocracy" "Anocracy" "Democracy"

	reghdfe `var' i.polity_regime, abs(i.year i.regionfe) keepsingleton
	lincom _cons
	mat C1[1,1]=`r(estimate)'
	mat C1[2,1]=`r(lb)'
	mat C1[3,1]=`r(ub)'

	forval i=1/2{
		local c=`i'+1	

		lincom _cons + `i'.polity_regime
		mat C1[1,`c']=`r(estimate)'
		mat C1[2,`c']=`r(lb)'
		mat C1[3,`c']=`r(ub)'
		
	}

	local varlabel : variable label `var' 
	coefplot (mat(C1[1]), ci((2 3))), vert b2title("Regime Classification (Polity Index)", size(medium)) ytitle("`varlabel'", size(medsmall)) xlabel(, labsize(small))
	gr export "${plots}/coefplot_`var'_polity.pdf", as(pdf) replace
		
}

*Using Vdem Index Classification
foreach var of global percep {
	
	mat C2=J(3,4,.)
	mat coln C2 = "Closed autocracy" "Electoral autocracy" "Electoral democracy" "Liberal democracy"

	reghdfe `var' i.vdem_regime, abs(i.year i.regionfe) keepsingleton
	lincom _cons
	mat C2[1,1]=`r(estimate)'
	mat C2[2,1]=`r(lb)'
	mat C2[3,1]=`r(ub)'

	forval i=1/3{
		local c=`i'+1	

		lincom _cons + `i'.vdem_regime
		mat C2[1,`c']=`r(estimate)'
		mat C2[2,`c']=`r(lb)'
		mat C2[3,`c']=`r(ub)'
		
	}

	local varlabel : variable label `var' 
	coefplot (mat(C2[1]), ci((2 3))), vert b2title("Regime Classification (VDEM Index)", size(medium)) ytitle("`varlabel'", size(medsmall)) xlabel(, labsize(medsmall))
	gr export "${plots}/coefplot_`var'_vdem.pdf", as(pdf) replace

}


*-------------------------------------------------------------------------------
*	ACCOUNTABILITY
*-------------------------------------------------------------------------------
gl account "d_corruption d_parties d_elections d_reduce_corrup d_rleader_corruption d_local_corruption d_nat_corruption"

*Using Polity Index Classification
foreach var of global account {
	
	mat C1=J(3,3,.)
	mat coln C1 = "Autocracy" "Anocracy" "Democracy"

	reghdfe `var' i.polity_regime, abs(i.year i.regionfe) keepsingleton
	lincom _cons
	mat C1[1,1]=`r(estimate)'
	mat C1[2,1]=`r(lb)'
	mat C1[3,1]=`r(ub)'

	forval i=1/2{
		local c=`i'+1	

		lincom _cons + `i'.polity_regime
		mat C1[1,`c']=`r(estimate)'
		mat C1[2,`c']=`r(lb)'
		mat C1[3,`c']=`r(ub)'
		
	}

	local varlabel : variable label `var' 
	coefplot (mat(C1[1]), ci((2 3))), vert b2title("Regime Classification (Polity Index)", size(medium)) ytitle("`varlabel'", size(medsmall)) xlabel(, labsize(small))
	gr export "${plots}/coefplot_`var'_polity.pdf", as(pdf) replace
		
}

*Using Vdem Index Classification
foreach var of global account {
	
	mat C2=J(3,4,.)
	mat coln C2 = "Closed autocracy" "Electoral autocracy" "Electoral democracy" "Liberal democracy"

	reghdfe `var' i.vdem_regime, abs(i.year i.regionfe) keepsingleton
	lincom _cons
	mat C2[1,1]=`r(estimate)'
	mat C2[2,1]=`r(lb)'
	mat C2[3,1]=`r(ub)'

	forval i=1/3{
		local c=`i'+1	

		cap lincom _cons + `i'.vdem_regime
		cap mat C2[1,`c']=`r(estimate)'
		cap mat C2[2,`c']=`r(lb)'
		cap mat C2[3,`c']=`r(ub)'
		
	}

	local varlabel : variable label `var' 
	coefplot (mat(C2[1]), ci((2 3))), vert b2title("Regime Classification (VDEM Index)", size(medium)) ytitle("`varlabel'", size(medsmall)) xlabel(, labsize(medsmall))
	gr export "${plots}/coefplot_`var'_vdem.pdf", as(pdf) replace

}



*END

