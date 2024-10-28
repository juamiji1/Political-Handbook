
*-------------------------------------------------------------------------------
*	PREPARING DATA (LEAVING LAST TIME COUNTRY APPEARED)
*
*-------------------------------------------------------------------------------
use "${idata}\wvs_series_gdp_country_year_lvl.dta", clear 

bys iso: egen max_year=max(year)
keep if max_year==year


*-------------------------------------------------------------------------------
*	MAKING MEAN PLOTS
*
*-------------------------------------------------------------------------------

*-------------------------------------------------------------------------------
*	VOTING AND CONSTRAINTS
*-------------------------------------------------------------------------------
gl voting "d_q221_inv d_q222_inv d_q224_inv d_q225_inv d_q227_inv d_q229_inv d_q231_inv d_q232_inv"

*Using Polity Index Classification
foreach var of global voting {
	
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
foreach var of global voting {
	
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
*	INFORMATION
*-------------------------------------------------------------------------------
gl info "d_q201 d_q202 d_q206 d_q207 d_q208"

*Using Polity Index Classification
foreach var of global info {
	
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
foreach var of global info {
	
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
gl account "d_q292a d_q292b d_q292c d_q292e d_q292g d_q292i d_q292j d_q292k d_q292l"

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

	reghdfe `var' 1.vdem_regime, abs(i.year i.regionfe) keepsingleton
	lincom _cons
	mat C2[1,1]=`r(estimate)'
	mat C2[2,1]=`r(lb)'
	mat C2[3,1]=`r(ub)'

	local c=2	

	lincom _cons + 1.vdem_regime
	mat C2[1,`c']=`r(estimate)'
	mat C2[2,`c']=`r(lb)'
	mat C2[3,`c']=`r(ub)'
	

	local varlabel : variable label `var' 
	coefplot (mat(C2[1]), ci((2 3))), vert b2title("Regime Classification (VDEM Index)", size(medium)) ytitle("`varlabel'", size(small)) xlabel(, labsize(medsmall))
	gr export "${plots}/coefplot_`var'_vdem.pdf", as(pdf) replace

}


*END
