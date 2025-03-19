
*-------------------------------------------------------------------------------
* WVS DATA
*
*-------------------------------------------------------------------------------
use "${idata}\wvs_series_gdp_country_year_lvl.dta", clear 

keep if iso=="BRA"

sort year

*-------------------------------------------------------------------------------
*	TRUST IN INSTITUTIONS 
*-------------------------------------------------------------------------------
gl trust_inv "q65_inv q66_inv q69_inv q70_inv q71_inv q72_inv q73_inv q76_inv"

foreach var of global trust_inv{
		
		replace d_`var'=. if d_`var'==0
}

foreach var of global trust_inv{	
				
	tempvar rvar
	gen `rvar'=round(d_`var', .001)
	
	two (scatter d_`var' year if !missing(d_`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
	(bar d_`var' year if !missing(d_`var'), fcolor(gs8) lcolor(gs8)) ///
	(line d_`var' year if !missing(d_`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
	legend(off) b2title("Year of WVS survey", size(medium)) ///
	l2title("`: var label d_`var''", size(medium)) xtitle("") ytitle("") 
	
	gr export "${plots}/brazil_trend_d_`var'.pdf", as(pdf) replace

}

la var index_trust "Trust index (ICW)"
local var index_trust 
			
tempvar rvar
gen `rvar'=round(`var', .001)
	
two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
(bar `var' year if !missing(`var'), fcolor(gs8) lcolor(gs8)) ///
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year of WVS survey", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 
	
gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace
	
*-------------------------------------------------------------------------------
*	POLITICAL PERCEPTIONS  
*-------------------------------------------------------------------------------
gl percep_inv "q224_inv q225_inv q227_inv q229_inv q231_inv q232_inv"

foreach var of global percep_inv{
		
		replace d_`var'=. if d_`var'==0
}

foreach var of global percep_inv{
			
	tempvar rvar
	gen `rvar'=round(d_`var', .001)

	two (scatter d_`var' year if !missing(d_`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
	(bar d_`var' year if !missing(d_`var'), fcolor(gs8) lcolor(gs8)) ///
	(line d_`var' year if !missing(d_`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
	legend(off) b2title("Year of WVS survey", size(medium)) ///
	l2title("`: var label d_`var''", size(medium)) xtitle("") ytitle("") 
	
	gr export "${plots}/brazil_trend_d_`var'.pdf", as(pdf) replace
}

la var index_percep "Political perception index (ICW)"
local var index_percep 

tempvar rvar
gen `rvar'=round(`var', .001)

two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
(bar `var' year if !missing(`var'), fcolor(gs8) lcolor(gs8)) ///
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year of WVS survey", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 
	
gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace


*-------------------------------------------------------------------------------
*	POLITICAL ACTION  
*-------------------------------------------------------------------------------
gl action_inv "q221_inv q222_inv"
	
foreach var of global action_inv{
		
		replace d_`var'=. if d_`var'==0
}

foreach var of global action_inv{
	
	tempvar rvar
	gen `rvar'=round(d_`var', .001)

	two (scatter d_`var' year if !missing(d_`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
	(bar d_`var' year if !missing(d_`var'), fcolor(gs8) lcolor(gs8)) ///
	(line d_`var' year if !missing(d_`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
	legend(off) b2title("Year of WVS survey", size(medium)) ///
	l2title("`: var label d_`var''", size(medium)) xtitle("") ytitle("") 
	
	gr export "${plots}/brazil_trend_d_`var'.pdf", as(pdf) replace
}

la var index_action "Politicial action index (ICW)"
local var index_action 

tempvar rvar
gen `rvar'=round(`var', .001)

two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
(bar `var' year if !missing(`var'), fcolor(gs8) lcolor(gs8)) ///
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year of WVS survey", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 
	
gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
*	INFORMATION
*-------------------------------------------------------------------------------
gl info "q201 q202 q206 q207 q208"

foreach var of global info{
		
		replace d_`var'=. if d_`var'==0
}

foreach var of global info{
	
	tempvar rvar
	gen `rvar'=round(d_`var', .001)

	two (scatter d_`var' year if !missing(d_`var'), mlab(`rvar') mlabsize(medsmall) mlabcolor(black) mcolor(black) msize(*0) mlabposition(12)) /// Bigger markers
	(bar d_`var' year if !missing(d_`var'), fcolor(gs8) lcolor(gs8)) ///
	(line d_`var' year if !missing(d_`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
	legend(off) b2title("Year of WVS survey", size(medium)) ///
	l2title("`: var label d_`var''", size(medium)) xtitle("") ytitle("") 
	
	gr export "${plots}/brazil_trend_d_`var'.pdf", as(pdf) replace
}


*-------------------------------------------------------------------------------
* VDEM DATA
*
*-------------------------------------------------------------------------------

*-------------------------------------------------------------------------------
* Democracy index
*-------------------------------------------------------------------------------
import delimited "${rdata}\Vdem\electoral-democracy-index.csv", clear
ren (code electoraldemocracyindexbestestim) (iso vdem_index)

la var vdem_index "Electoral democracy index"

keep if iso=="BRA" & year >1999
keep iso year vdem_index
sort year


local var vdem_index

tempvar rvar
gen `rvar'=round(`var', .01)

two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(small) mlabcolor(black) mcolor(black) msize(*0.5) mlabposition(12)) /// Bigger markers
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("")

gr export "${plots}/brazil_trend_vdem_index.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Accountability and Corruption indexes
*-------------------------------------------------------------------------------
import excel "${rdata}\WB\VDEM-CORE.xlsx", sheet("Data") firstrow case(lower) clear

gen indicator_type = "a" if indicator==  "Accountability index"
replace indicator_type = "ha" if indicator==  "Horizontal accountability index"
replace indicator_type = "va" if indicator==  "Vertical accountability index"
replace indicator_type = "da" if indicator==  "Diagonal accountability index"
replace indicator_type = "pc" if indicator==  "Political corruption index"
replace indicator_type = "ec" if indicator==  "Executive corruption index"
replace indicator_type = "jc" if indicator==  "Judicial constraints on the executive index"
replace indicator_type = "c" if indicator==  "Clientelism Index"

drop if indicator_type == ""  // Drop rows without relevant indicators

ren economyiso3 iso
keep iso indicator_type  i-bt // Retain only relevant columns

foreach var of varlist i - bt { 
	local lbl: var label `var'
	local numlbl = substr("`lbl'", strpos("`lbl'", "#")+1, .) // Extract number
	rename `var' x_`numlbl'_
}

levelsof indicator_type, local(itype)

reshape wide x_1960 - x_2023, i(iso) j(indicator_type) string 

foreach i of local itype{
	ren *_`i' `i'_=
	ren *_`i' *
}

reshape long a_x_ ha_x_ va_x_ da_x_ pc_x_ ec_x_ jc_x_ c_x_, i(iso) j(year)

ren *x_ *vdemcore

la var a_vdemcore "Overall Accountability Index (VDEM)"
la var ha_vdemcore "Horizontal Accountability Index (VDEM)"
la var va_vdemcore "Vertical Accountability Index (VDEM)"
la var da_vdemcore "Diagonal Accountability Index (VDEM)"
la var pc_vdemcore "Political Corruption Index (VDEM)"
la var ec_vdemcore "Executive Corruption Index (VDEM)"
la var jc_vdemcore "Judicial Constraints on the Executive Index (VDEM)"
la var c_vdemcore "Clientelism Index (VDEM)"

keep if iso=="BRA" & year >1999
sort year

gl account "a_vdemcore ha_vdemcore va_vdemcore da_vdemcore pc_vdemcore ec_vdemcore jc_vdemcore c_vdemcore"

foreach var of global account{
	
	tempvar rvar
	gen `rvar'=round(`var', .001)

	two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(small) mlabcolor(black) mcolor(black) msize(*0.5) mlabposition(12)) /// 
	(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
	legend(off) b2title("Year", size(medium)) ///
	l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 
	
	gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace
}

*-------------------------------------------------------------------------------
* Turnout (VDEM)
*-------------------------------------------------------------------------------
import delimited "${rdata}\Vdem\voter-turnout-of-registered-voters.csv", clear
ren (code voterturnoutofregisteredvoters) (iso turnout_vdemcore)

drop if iso==""
keep if year >1979
keep iso year turnout_vdemcore

la var turnout_vdemcore "Turnout (VDEM)"

encode iso, gen(iso_code)
tsset iso_code year 
tsfill, full 

by iso_code: carryforward iso turnout_vdemcore, replace
drop if turnout_vdemcore==.
replace turnout_vdemcore=turnout_vdemcore/100

keep if iso=="BRA" & year >1999
sort year

local var turnout_vdemcore

tempvar rvar
gen `rvar'=round(`var', .01)

two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(small) mlabcolor(black) mcolor(black) msize(*0.5) mlabposition(12)) /// 
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 

gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace


*-------------------------------------------------------------------------------
* WB DATA
*
*-------------------------------------------------------------------------------

*-------------------------------------------------------------------------------
* Load data on GDP PP at US$ 2015
*-------------------------------------------------------------------------------
import delimited "${rdata}\GDP_PPP\GDP_PPP.csv", clear

ren countrycode iso
reshape long gdp_, i(iso) j(year)
ren gdp_ gdp 

gen ln_gdp=ln(gdp)

keep iso year gdp ln_gdp

la var ln_gdp "Log(GDP PP)"

keep if iso=="BRA" & year >1999
sort year

local var ln_gdp

tempvar rvar
gen `rvar'=round(`var', .1)

two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(small) mlabcolor(black) mcolor(black) msize(*0.5) mlabposition(12)) /// 
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 

gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace


*-------------------------------------------------------------------------------
* Corruption perception index score (WB)
*-------------------------------------------------------------------------------
import excel "${rdata}\WB\TI-CPI.xlsx", sheet("Data") firstrow case(lower) clear

keep if indicator=="Corruption Perceptions Index Score"

foreach var of varlist i - t { 
	local lbl: var label `var'
	local numlbl = substr("`lbl'", strpos("`lbl'", "#")+1, .) // Extract number
	rename `var' cp_index`numlbl'
}

ren economyiso3 iso
keep iso cp_index*

reshape long cp_index, i(iso) j(year)
replace cp_index=cp_index/100

la var cp_index "Corruption Perceptions Index (WB)"

keep if iso=="BRA" & year >1999
sort year

local var cp_index

tempvar rvar
gen `rvar'=round(`var', .001)

two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(small) mlabcolor(black) mcolor(black) msize(*0.5) mlabposition(12)) /// 
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 

gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace
	
*-------------------------------------------------------------------------------
* Human Development Index (UNDP)
*-------------------------------------------------------------------------------
import delimited "${rdata}\UNDP\human-development-index.csv", clear

keep if code!=""
ren (code humandevelopmentindex) (iso hd_index)

la var hd_index "Human Development Index (UNDP)"

keep if iso=="BRA" & year >1999
sort year

local var hd_index

tempvar rvar
gen `rvar'=round(`var', .01)

two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(small) mlabcolor(black) mcolor(black) msize(*0.5) mlabposition(12)) /// 
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 

gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Harmonized Learning Outcomes Scores (WB)
*-------------------------------------------------------------------------------
import delimited "${rdata}\WB\average-harmonized-learning-outcome-scores.csv", clear

keep if code!=""
ren (code harmonizedtestscores) (iso hlo_index)
replace hlo_index=hlo_index/1000

la var hlo_index "Harmonized Learning Outcomes Score (WB)"

keep if iso=="BRA" & year >1999
sort year

local var hlo_index

tempvar rvar
gen `rvar'=round(`var', .001)

two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(small) mlabcolor(black) mcolor(black) msize(*0.5) mlabposition(12)) /// 
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 

gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* VA index
*-------------------------------------------------------------------------------
import excel "${rdata}\WB\WB-WWGI.xlsx", sheet("Data") firstrow case(lower) clear
keep if indicator=="Voice and Accountability: Estimate"

foreach var of varlist i - af { 
    local lbl: var label `var'
    local numlbl = substr("`lbl'", strpos("`lbl'", "#")+1, .) // Extract number
    rename `var' va`numlbl'
}

ren economyiso3 iso
keep iso va*

reshape long va, i(iso) j(year)

ren va va_index

keep if iso=="BRA" & year >1999
sort year

local var va_index

tempvar rvar
gen `rvar'=round(`var', .001)

two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(small) mlabcolor(black) mcolor(black) msize(*0.5) mlabposition(12)) /// 
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 

gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace

*-------------------------------------------------------------------------------
* Control of Corruption index
*-------------------------------------------------------------------------------
import excel "${rdata}\WB\WB-WWGI.xlsx", sheet("Data") firstrow case(lower) clear
keep if indicator=="Control of Corruption: Estimate"

foreach var of varlist i - af { 
    local lbl: var label `var'
    local numlbl = substr("`lbl'", strpos("`lbl'", "#")+1, .) // Extract number
    rename `var' cc`numlbl'
}

ren economyiso3 iso
keep iso cc*

reshape long cc, i(iso) j(year)

ren cc cc_index

la var cc_index "Control of Corruption index"

keep if iso=="BRA" & year >1999
sort year

local var cc_index

tempvar rvar
gen `rvar'=round(`var', .001)

two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(small) mlabcolor(black) mcolor(black) msize(*0.5) mlabposition(12)) /// 
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 

gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace


*-------------------------------------------------------------------------------
* OTHER DATA
*
*-------------------------------------------------------------------------------

*-------------------------------------------------------------------------------
* WJP data
*-------------------------------------------------------------------------------
import excel "${rdata}\WJP\2024_wjp_rule_of_law_index_HISTORICAL_DATA_FILE.xlsx", sheet("Historical Data") firstrow case(lower) clear

ren (countrycode wjpruleoflawindexoveralls factor1constraintsongovernm) (iso wjp_index const_gov)

la var wjp_index "Rule of law index"
la var const_gov "Constraints on government index"

replace year="2013" if year=="2012-2013"
replace year="2018" if year=="2017-2018"
destring year, replace

keep if iso=="BRA" & year >1999
sort year

gl wjp "wjp_index const_gov"

foreach var of global wjp{
	
	tempvar rvar
	gen `rvar'=round(`var', .01)

	two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(small) mlabcolor(black) mcolor(black) msize(*0.5) mlabposition(12)) /// 
	(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
	legend(off) b2title("Year", size(medium)) ///
	l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 
	
	gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace
}

*-------------------------------------------------------------------------------
* Press Freedom Index (RSF-WB)
*-------------------------------------------------------------------------------
import excel "${rdata}\WB\RWB-PFI.xlsx", sheet("Data") firstrow case(lower) clear

keep if indicator=="Press Freedom Index - Score"

foreach var of varlist i - ac { 
    local lbl: var label `var'
    local numlbl = substr("`lbl'", strpos("`lbl'", "#")+1, .) // Extract number
    rename `var' pf`numlbl'
}

ren economyiso3 iso
keep iso pf*

reshape long pf, i(iso) j(year)

ren pf pf_index
replace pf_index=pf_index/100

la var pf_index "Press Freedom Index (RSF)"

keep if iso=="BRA" & year >1999
sort year

local var pf_index

tempvar rvar
gen `rvar'=round(`var', .01)

two (scatter `var' year if !missing(`var'), mlab(`rvar') mlabsize(small) mlabcolor(black) mcolor(black) msize(*0.5) mlabposition(12)) /// 
(line `var' year if !missing(`var'), lcolor(gs8) lwidth(medthick) lp(dash)), /// Wider line
legend(off) b2title("Year", size(medium)) ///
l2title("`: var label `var''", size(medium)) xtitle("") ytitle("") 

gr export "${plots}/brazil_trend_`var'.pdf", as(pdf) replace




*END