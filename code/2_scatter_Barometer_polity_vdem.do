
use "${idata}\barometer_22_23_country_lvl.dta", clear

la def polity 0 "Autocracy" 1 "Anocracy" 2 "Democracy"
la val polity_regime polity

la def vdem 0 "Closed autocracy" 1 "Electoral autocracy" 2 "Electoral democracy" 3 "Liberal democracy"
la val vdem_regime vdem


*-------------------------------------------------------------------------------
*	MAKING PLOTS of classifications
*
*-------------------------------------------------------------------------------
tabstat vdem_index, by(vdem_regime) s(mean min max N)
tabstat polity_index, by(polity_regime) s(mean min max N)

hist polity_index, frac fcolor(%40 "stc2") lcolor(%70 "stc2") lwidth(vthin) xline(-6, lc("gray")) xline(6, lc("gray")) b2title("Polity Index", size(medium)) xtitle("")
gr export "${plots}/hist_polity_index.pdf", as(pdf) replace

hist vdem_index, frac fcolor(%40 "stc2") lcolor(%70 "stc2") lwidth(vthin) xline(.25, lc("gray")) xline(.5, lc("gray")) xline(.75, lc("gray")) b2title("VDEM Index", size(medium)) xtitle("")
gr export "${plots}/hist_vdem_index.pdf", as(pdf) replace

hist polity_regime, frac fcolor(%40 "stc2") lcolor(%70 "stc2") lwidth(vthin) xline(-6, lc("gray")) xline(6, lc("gray")) b2title("Polity Regime", size(medium)) xtitle("")
gr export "${plots}/hist_polity_regime.pdf", as(pdf) replace

hist vdem_regime, frac fcolor(%40 "stc2") lcolor(%70 "stc2") lwidth(vthin) xline(-6, lc("gray")) xline(6, lc("gray")) b2title("Polity Regime", size(medium)) xtitle("")
gr export "${plots}/hist_vdem_regime.pdf", as(pdf) replace

two (scatter polity_index vdem_index if regionfe==1, mlabel(country) mlabcolor(black) mlabsize(tiny) mlabposition(6) mfcolor(none)) ///
(scatter polity_index vdem_index if regionfe==2, mlabel(country) mlabcolor(black) mlabsize(tiny) mlabposition(6) mfcolor(none)) ///
(scatter polity_index vdem_index if regionfe==3, mlabel(country) mlabcolor(black) mlabsize(tiny) mlabposition(6) mfcolor(none)) ///
(scatter polity_index vdem_index if regionfe==4, mlabel(country) mlabcolor(black) mlabsize(tiny) mlabposition(12) mfcolor(none)) ///
(qfit polity_index vdem_index, lc("stc2")), legend(off) ytitle("Polity Index") xtitle("VDEM Index")
gr export "${plots}/scatter_vdem_polity_indexes.pdf", as(pdf) replace

* I would believe more VDEM!!!!!!!!


*-------------------------------------------------------------------------------
*	MAKING MEAN PLOTS
*
*-------------------------------------------------------------------------------

*-------------------------------------------------------------------------------
*	ACCOUNTABILITY
*-------------------------------------------------------------------------------
gl account "d_corruption"


foreach var of global account {
	
	*Using Polity Index Classification
	local varlabel : variable label `var' 
	
	two (scatter `var' polity_regime if regionfe==1, mlabel(country) mlabcolor(black) mlabsize(vsmall) xlabel(0(1)2.5) mlabsize(*.7) msymbol(Oh)) ///
	(scatter `var' polity_regime if regionfe==2, mlabel(country) mlabcolor(black) mlabsize(vsmall) xlabel(0(1)2.5) mlabsize(*.7) msymbol(Oh)) ///
	(scatter `var' polity_regime if regionfe==3, mlabel(country) mlabcolor(black) mlabsize(vsmall) xlabel(0(1)2.5) mlabsize(*.7) msymbol(Oh)) ///
	(scatter `var' polity_regime if regionfe==4, mlabel(country) mlabcolor(black) mlabsize(vsmall) xlabel(0(1)2.5, val) mlabsize(*.7) msymbol(Oh)), legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe")) b2title("Regime Classification (Polity Index)", size(medium)) ytitle("`varlabel'", size(medsmall)) xlabel(, labsize(medsmall)) xtitle("")
	
	gr export "${plots}/scatter_`var'_polity_regime.pdf", as(pdf) replace
	
	*Using Vdem Index Classification
	two (scatter `var' vdem_regime if regionfe==1, mlabel(country) mlabcolor(black) mlabsize(vsmall) xlabel(0(1)3.5) mlabsize(*.7) msymbol(Oh)) ///
	(scatter `var' vdem_regime if regionfe==2, mlabel(country) mlabcolor(black) mlabsize(vsmall) xlabel(0(1)3.5) mlabsize(*.7) msymbol(Oh)) ///
	(scatter `var' vdem_regime if regionfe==3, mlabel(country) mlabcolor(black) mlabsize(vsmall) xlabel(0(1)3.5) mlabsize(*.7) msymbol(Oh)) ///
	(scatter `var' vdem_regime if regionfe==4, mlabel(country) mlabcolor(black) mlabsize(vsmall) xlabel(0(1)3.5, val) mlabsize(*.7) msymbol(Oh)), legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe")) b2title("Regime Classification (VDEM Index)", size(medium)) ytitle("`varlabel'", size(medsmall)) xlabel(, labsize(medsmall)) xtitle("")
	gr export "${plots}/scatter_`var'_vdem_regime.pdf", as(pdf) replace

}


foreach var of global account {
	
	*Using Polity Index
	local varlabel : variable label `var' 
	
	two (scatter `var' polity_index if regionfe==1, msymbol(Oh) mlabel(country) mlabcolor(black) mlabsize(vsmall)) ///
	(scatter `var' polity_index if regionfe==2, msymbol(Oh) mlabel(country) mlabcolor(black) mlabsize(vsmall))  ///
	(scatter `var' polity_index if regionfe==3, msymbol(Oh) mlabel(country) mlabcolor(black) mlabsize(vsmall)) ///
	(scatter `var' polity_index if regionfe==4, msymbol(Oh) mlabel(country) mlabcolor(black) mlabsize(vsmall) xlab(-10(5)12)) ///
	(lfit `var' polity_index, xlab(-10(5)12) lc("stc2")), legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe")) b2title("Polity Index", size(medium)) ytitle("`varlabel'", size(medsmall)) xlabel(, labsize(medsmall)) xtitle("")
	gr export "${plots}/scatter_`var'_polity_index.pdf", as(pdf) replace
	
	*Using Vdem Index 
	two (scatter `var' vdem_index if regionfe==1, msymbol(Oh) mlabel(country) mlabcolor(black) mlabsize(vsmall)) ///
	(scatter `var' vdem_index if regionfe==2, msymbol(Oh) mlabel(country) mlabcolor(black) mlabsize(vsmall))  ///
	(scatter `var' vdem_index if regionfe==3, msymbol(Oh) mlabel(country) mlabcolor(black) mlabsize(vsmall)) ///
	(scatter `var' vdem_index if regionfe==4, msymbol(Oh) mlabel(country) mlabcolor(black) mlabsize(vsmall) xlab(-10(5)12)) ///
	(lfit `var' vdem_index, xlab(0(.1)1) lc("stc2")), legend(position(6) row(1) label( 1 "Africa") label( 2 "Americas") label(3 "Asia") label(4 "Europe")) b2title("VDEM Index", size(medium)) ytitle("`varlabel'", size(medsmall)) xlabel(, labsize(medsmall)) xtitle("")
	gr export "${plots}/scatter_`var'_vdem_index.pdf", as(pdf) replace

}

*With resids
local var d_corruption
local varlabel : variable label `var' 

cap drop u_y u_x 
reghdfe d_corruption, abs(i.year i.regionfe) keepsingleton resid(u_y)
reghdfe polity_index, abs(i.year i.regionfe) keepsingleton resid(u_x)

two (scatter u_y u_x, mlabel(country) mlabcolor(black) mlabsize(vsmall)) (lfit u_y u_x), legend(off)  b2title("Polity Index", size(medium)) ytitle("`varlabel'", size(medsmall)) xlabel(, labsize(medsmall)) xtitle("")
gr export "${plots}/scatter_`var'_polity_resid.pdf", as(pdf) replace

cap drop u_y u_x 
reghdfe d_corruption, abs(i.year i.regionfe) keepsingleton resid(u_y)
reghdfe polity_index, abs(i.year i.regionfe) keepsingleton resid(u_x)

two (scatter u_y u_x, mlabel(country) mlabcolor(black) mlabsize(vsmall)) (lfit u_y u_x) , legend(off) b2title("VDEM Index", size(medium)) ytitle("`varlabel'", size(medsmall)) xlabel(, labsize(medsmall)) xtitle("")
gr export "${plots}/scatter_`var'_vdem_resid.pdf", as(pdf) replace


/*
foreach var of global account {
	*Using Polity Index Classification
	gr box d_corruption, over(polity_regime) box(1,fcolor(none))
	stripplot d_corruption, over(polity_regime) box( barwidth(0.4) blwidth(thin) blcolor("stc1") barw(0.2)) iqr whiskers(lcolor("stc1")) vert addplot( scatter d_corruption polity_regime if regionfe==1, msymbol(Oh) mlabel(country) mlabcolor(black) mlabsize(vsmall) || scatter d_corruption polity_regime if regionfe==2, msymbol(Oh) mlabel(country) mlabcolor(black) mlabsize(vsmall) || scatter d_corruption polity_regime if regionfe==3, msymbol(Oh) mlabel(country) mlabcolor(black) mlabsize(vsmall) || scatter d_corruption polity_regime if regionfe==4, msymbol(Oh) mlabel(country) mlabcolor(black) mlabsize(vsmall))
	
		
		
	*Using Vdem Index Classification
	gr box d_corruption, over(vdem_regime)
}


END