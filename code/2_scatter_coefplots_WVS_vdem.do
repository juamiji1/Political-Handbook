
*-------------------------------------------------------------------------------
*	PREPARING DATA (LEAVING LAST TIME COUNTRY APPEARED)
*
*-------------------------------------------------------------------------------
use "${idata}\wvs_series_gdp_country_year_lvl.dta", clear 

bys iso: egen max_year=max(year)
keep if max_year==year

gen vdem_regime_v2=vdem_regime
replace vdem_regime_v2=1 if vdem_regime_v2==0

*-------------------------------------------------------------------------------
*	MAKING MEAN PLOTS
*
*-------------------------------------------------------------------------------

*-------------------------------------------------------------------------------
*	VOTING AND CONSTRAINTS
*-------------------------------------------------------------------------------
forval c=0/3{
	levelsof iso if vdem_regime==`c' & dm_q224_inv>0, local(rnames)

	tabstat dm_q224_inv if vdem_regime==`c' & dm_q224_inv>0, by(iso) nototal save
	tabstatmat S

	mata: st_matrix("R", st_matrix("S")); st_matrixrowstripe("S", J(0,2,""))

	mat coln R = "Response Rate"
	mat rown R = `rnames'

	tempfile X X1
	frmttable using `X', statmat(R) sdec(3) fragment tex nocenter 
	filefilter `X' "${tables}\response_rate_vdem`c'.tex", from("r}\BS\BS") to("r}") replace
}

*Cases to consider
foreach var in d_q221_inv d_q224_inv{
	
	local varlabel : variable label `var' 
	
	two (scatter `var' vdem_regime if regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
	(scatter `var' vdem_regime if regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
	(scatter `var' vdem_regime if regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
	(scatter `var' vdem_regime if regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)), legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("Regime Classification (VDEM Index)", size(medium)) ytitle("`varlabel'", size(medsmall)) xlabel(0 "Closed autocracy" 1 "Electoral autocracy" 2 "Electoral democracy" 3 "Liberal democracy" 3.5 ".", labsize(small)) xtitle("") 
gr export "${plots}/scatter_`var'_vdem_regime.pdf", as(pdf) replace
	
}

gl voting "d_q221_inv d_q222_inv d_q224_inv d_q225_inv d_q227_inv d_q229_inv d_q231_inv d_q232_inv"

*Using Vdem Index Classification
foreach var of global voting {
	
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
foreach var of global voting {
	
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
*	INFORMATION
*-------------------------------------------------------------------------------
gl info "d_q201 d_q202 d_q206 d_q207 d_q208"

*Using Vdem Index Classification
foreach var of global info {
	local varlabel : variable label `var' 

	two (scatter `var' vdem_index if regionfe==1 & `var'>0, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if regionfe==2 & `var'>0, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if regionfe==3 & `var'>0, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if regionfe==4 & `var'>0, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' vdem_index if `var'>0, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("Regime Classification (VDEM Index)", size(medium)) ytitle("`varlabel'", size(medsmall))  xtitle("") 
	gr export "${plots}/scatter_`var'_vdem_index.pdf", as(pdf) replace

}

*Using Vdem Index Classification
foreach var of global info {
	
	mat C2=J(3,3,.)
	mat coln C2 ="Closed/Electoral autocracy" "Electoral democracy" "Liberal democracy"

	reghdfe `var' i.vdem_regime_v2 if `var'>0, abs(i.year i.regionfe) keepsingleton
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
gl account "d_q292a d_q292b d_q292c d_q292e d_q292g d_q292i d_q292j d_q292k d_q292l"

*Using Vdem Index Classification
foreach var of global account  {
	
	local varlabel : variable label `var' 
	
	two (scatter `var' vdem_index if regionfe==1, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if regionfe==2, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if regionfe==3, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if regionfe==4, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' vdem_index, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("Regime Classification (VDEM Index)", size(medium)) ytitle("`varlabel'", size(medsmall))  xtitle("") 
	gr export "${plots}/scatter_`var'_vdem_index.pdf", as(pdf) replace

}

gl corrup "d_q113 d_q115 d_q116"

*Using Vdem Index Classification
foreach var of global corrup {
	local varlabel : variable label `var' 

	two (scatter `var' vdem_index if regionfe==1 & `var'>0, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if regionfe==2 & `var'>0, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if regionfe==3 & `var'>0, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(scatter `var' vdem_index if regionfe==4 & `var'>0, mlabel(iso) mlabcolor(black) mlabsize(vsmall) mlabsize(*.7) msymbol(Oh)) ///
		(lowess `var' vdem_index if `var'>0, lc("stc2")), ///
		legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe") label(5 "Lowess")) b2title("Regime Classification (VDEM Index)", size(medium)) ytitle("`varlabel'", size(medsmall))  xtitle("") 
	gr export "${plots}/scatter_`var'_vdem_index.pdf", as(pdf) replace

}

*Using Vdem Index Classification
foreach var of global corrup {
	
	mat C2=J(3,3,.)
	mat coln C2 ="Closed/Electoral autocracy" "Electoral democracy" "Liberal democracy"

	reghdfe `var' i.vdem_regime_v2 if `var'>0, abs(i.year i.regionfe) keepsingleton
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





*END