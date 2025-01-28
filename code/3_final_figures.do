/*------------------------------------------------------------------------------
PROJECT: POLECON HANDBOOK

TOPIC: Final figures
AUTHORS: Claudio Ferraz, Fred Finan 
RA: JMJR
-------------------------------------------------------------------------------*/

*Setting a pre-scheme for plots
set scheme s2mono
grstyle init
grstyle title color black
grstyle color background white
grstyle color major_grid dimgray

*-------------------------------------------------------------------------------
* Program for figures 
*-------------------------------------------------------------------------------
* Define the program
cap program drop make_plot

program define make_plot

    syntax, yvar(name) xvar(name) condition(string) tposition(integer)

    * Perform regression
    quietly reg `yvar' `xvar' if `condition', robust

    * Extract regression coefficients and R-squared
    matrix B = e(b)
    local b = string(round(B[1,1], .001), "%9.3f")
    local r2 = string(round(e(r2), .001), "%9.2f")

    * Calculate max and min for positioning
	if `tposition' == 1 {
		qui summ `yvar' if `condition', d
		local ycoord = r(max)-.3*r(sd)
		local ymin = r(min)
		local ymax = r(max)
		
		qui summ `xvar' if `condition', d
		local xcoord = r(min)+.5*r(sd)
		local xmin = r(min)
		local xmax = r(max)
	} 
	
	else {
		qui summ `yvar' if `condition', d
		local ycoord = r(min)
		local ymin = r(min)
		local ymax = r(max)
		
		qui summ `xvar' if `condition', d
		local xcoord = r(min)+.5*r(sd)
		local xmin = r(min)
		local xmax = r(max)
	}   

    * Create the graph
    two (lfitci `yvar' `xvar' if `condition', ciplot(rarea)) /// 
    (scatter `yvar' `xvar' if `condition', mlabel(iso) mlabcolor(black) mcolor(%95 black) msize(*.7) mlabsize(vsmall) mlabsize(*.6) msymbol(Oh)), ///
    legend(off) b2title("`: variable label `xvar''", size(medsmall)) ytitle("`: variable label `yvar''", size(medsmall)) xtitle("") ///
    text(`ycoord' `xcoord' "{&beta} = `b'" " " "R{sup:2} = `r2'", size(small)) xscale(range(`xmin' `xmax')) yscale(range(`ymin' `ymax'))
	
end

*-------------------------------------------------------------------------------
* Figure 1a
*-------------------------------------------------------------------------------
use "${idata}\wjp_wb_vhda_13_24_country_lvl.dta", clear

* Set globals for your variables and condition
global yvar = "cc_index"
global xvar = "a_vdemcore"
global condition = "year==2022 & vdem_index>.42"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig1a_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 1b
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "c_vdemcore"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(2)
gr export "${plots}/fig1b_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 1c
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "hd_index"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig1c_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 1d
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "a_vdemcore"
global xvar = "ln_gdp"

summ ln_gdp gdp, d
xtile gdp_decile = ln_gdp if ${condition}, nq(8)

preserve
	keep if ${condition}
	collapse (mean) ${yvar}, by(gdp_decile)
	
	* Graph the mean of a_vdemcore per GDP decile
	graph bar ${yvar}, over(gdp_decile) ///
    ylabel(, grid) ytitle("Mean of Overall Accountability Index (VDEM)", size(medsmall)) b2title("Quantiles of GDP Per Capita", size(medsmall)) bar(1, fcolor(gray))
	gr export "${plots}/fig1d_${yvar}_${xvar}.pdf", as(pdf) replace
restore 

*-------------------------------------------------------------------------------
* Figure 2a
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "cc_index"
global xvar = "va_vdemcore"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig2a_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 2b
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "c_vdemcore"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(2)
gr export "${plots}/fig2b_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 2c
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "hd_index"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig2c_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 2d
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "va_vdemcore"
global xvar = "ln_gdp"

preserve
	keep if ${condition}
	collapse (mean) ${yvar}, by(gdp_decile)
	
	* Graph the mean of a_vdemcore per GDP decile
	graph bar ${yvar}, over(gdp_decile) ///
    ylabel(, grid) ytitle("Mean of Vertical Accountability Index (VDEM)", size(medsmall)) b2title("Quantiles of GDP Per Capita", size(medsmall)) bar(1, fcolor(gray))
	gr export "${plots}/fig2d_${yvar}_${xvar}.pdf", as(pdf) replace
restore 

*-------------------------------------------------------------------------------
* Figure 3a
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "cc_index"
global xvar = "ha_vdemcore"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig3a_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 3b
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "c_vdemcore"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(2)
gr export "${plots}/fig3b_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 3c
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "hd_index"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig3c_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 3d
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "ha_vdemcore"
global xvar = "ln_gdp"

preserve
	keep if ${condition}
	collapse (mean) ${yvar}, by(gdp_decile)
	
	* Graph the mean of a_vdemcore per GDP decile
	graph bar ${yvar}, over(gdp_decile) ///
    ylabel(, grid) ytitle("Mean of Horizontal Accountability Index (VDEM)", size(medsmall)) b2title("Quantiles of GDP Per Capita", size(medsmall)) bar(1, fcolor(gray))
	gr export "${plots}/fig3d_${yvar}_${xvar}.pdf", as(pdf) replace
restore 

*-------------------------------------------------------------------------------
* Figure 4a
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "cc_index"
global xvar = "da_vdemcore"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig4a_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 4b
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "c_vdemcore"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(2)
gr export "${plots}/fig4b_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 4c
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "hd_index"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig4c_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 4d
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "da_vdemcore"
global xvar = "ln_gdp"

preserve
	keep if ${condition}
	collapse (mean) ${yvar}, by(gdp_decile)
	
	* Graph the mean of a_vdemcore per GDP decile
	graph bar ${yvar}, over(gdp_decile) ///
    ylabel(, grid) ytitle("Mean of Diagonal Accountability Index (VDEM)", size(medsmall)) b2title("Quantiles of GDP Per Capita", size(medsmall)) bar(1, fcolor(gray))
	gr export "${plots}/fig4d_${yvar}_${xvar}.pdf", as(pdf) replace
restore 

*-------------------------------------------------------------------------------
* Figure 5
*-------------------------------------------------------------------------------
use "${idata}\wvs_series_gdp_country_year_lvl.dta", clear 

bys iso: egen max_year=max(year)
keep if max_year==year

gen vdem_regime_v2=vdem_regime
replace vdem_regime_v2=1 if vdem_regime_v2==0

la var q71_inv "Confidence in Government (WVS)"
la var d_q224_inv "Electoral Integrity (WVS)"

* Set globals for your variables and condition
global yvar = "q71_inv"
global xvar = "d_q224_inv"
global condition = "q71_inv!=."

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig5_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 6
*-------------------------------------------------------------------------------
la var q72_inv "Confidence in Political Parties (WVS)"

* Set globals for your variables and condition
global yvar = "q72_inv"
global condition = "q72_inv!=."

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig6_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 7
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "turnout_vdemcore"
global condition = "turnout_vdemcore!=."

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig7_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 8
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
la var q250 "Democracy is Important (WVS)"

global yvar = "q250"
global condition = "q250!=."

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig8_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 9
*-------------------------------------------------------------------------------
*Creating lack of electoral integrity 
gen d_q224=1-d_q224_inv

la var vdem_index "Regime Classification Index (VDEM)"
la var d_q224 "Lack of Electoral Integrity (WVS)"

global yvar = "d_q224"
global xvar = "vdem_index"

two (qfitci ${yvar} ${xvar}) (scatter ${yvar} ${xvar}, mlabel(iso) mlabcolor(black) mcolor(%95 black) msize(*.7) mlabsize(vsmall) mlabsize(*.6) msymbol(Oh)), /// 
legend(off) b2title("`: variable label ${xvar}'", size(medsmall)) ytitle("`: variable label ${yvar}'", size(medsmall)) xtitle("")
gr export "${plots}/fig9_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 10
*-------------------------------------------------------------------------------
la var d_q227_inv "Voters are Bribed (Share)"

global yvar = "d_q227_inv"

two (qfitci ${yvar} ${xvar}) (scatter ${yvar} ${xvar}, mlabel(iso) mlabcolor(black) mcolor(%95 black) msize(*.7) mlabsize(vsmall) mlabsize(*.6) msymbol(Oh)), /// 
legend(off) b2title("`: variable label ${xvar}'", size(medsmall)) ytitle("`: variable label ${yvar}'", size(medsmall)) xtitle("")
gr export "${plots}/fig10_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 11
*-------------------------------------------------------------------------------
la var d_q231_inv "Voters are Threathened (Share)"

global yvar = "d_q231_inv"

two (qfitci ${yvar} ${xvar}) (scatter ${yvar} ${xvar}, mlabel(iso) mlabcolor(black) mcolor(%95 black) msize(*.7) mlabsize(vsmall) mlabsize(*.6) msymbol(Oh)), /// 
legend(off) b2title("`: variable label ${xvar}'", size(medsmall)) ytitle("`: variable label ${yvar}'", size(medsmall)) xtitle("")
gr export "${plots}/fig11_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 12
*-------------------------------------------------------------------------------
use "${idata}\wjp_wb_vhda_13_24_country_lvl.dta", clear

la var ln_gdp "Log of GDP Per Capita (WB)"

* Set globals for your variables and condition
global yvar = "pf_index"
global xvar = "ln_gdp"
global condition = "year==2022 & vdem_index>.42"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig12_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 13
*-------------------------------------------------------------------------------
la var wjpruleoflawindexoveralls "Rule of Law Index (WJP)"

* Set globals for your variables and condition
global yvar = "wjpruleoflawindexoveralls"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig13_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 14
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "pf_index"
global xvar = "da_vdemcore"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig14_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 15
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "wjpruleoflawindexoveralls"
global xvar = "ha_vdemcore"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig15_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 16
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "pf_index"
global xvar = "cc_index"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig16_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 17
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "wjpruleoflawindexoveralls"
global xvar = "cc_index"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig17_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 18
*-------------------------------------------------------------------------------
la var vdem_index "Regime Classification Index (VDEM)"

* Set globals for your variables and condition
global yvar = "wjpruleoflawindexoveralls"
global xvar = "vdem_index"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig18_${yvar}_${xvar}.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Figure 19
*-------------------------------------------------------------------------------
* Set globals for your variables and condition
global yvar = "a_vdemcore"
global xvar = "ln_gdp"
global condition = "year==2022 & vdem_index>.42"

* Call the program
make_plot, yvar(${yvar}) xvar(${xvar}) condition(${condition}) tposition(1)
gr export "${plots}/fig19_${yvar}_${xvar}.pdf", as(pdf) replace







*END
