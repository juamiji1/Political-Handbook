
*Load data on polity index
import delimited "${rdata}\Vdem\political-regime.csv", clear
ren (code politicalregime) (iso vdem_regime)

drop if iso==""
keep if year >1979
keep iso year vdem_regime

tempfile VDEMINDEX
save `VDEMINDEX', replace 

import delimited "${rdata}\Vdem\electoral-democracy-index.csv", clear
ren (code electoraldemocracyindexbestestim) (iso vdem_index)

drop if iso==""
keep if year >1979
keep iso year vdem_index

tempfile VDEMINDEX2
save `VDEMINDEX2', replace 

*Load data on GDP PP at US$ 2015
import delimited "${rdata}\GDP_PPP\GDP_PPP.csv", clear

ren countrycode iso
reshape long gdp_, i(iso) j(year)
ren gdp_ gdp 

gen ln_gdp=ln(gdp)

keep iso year gdp ln_gdp

tempfile GDP
save `GDP', replace

*Prepare region FE (IMPROVE THIS)
import delimited "${rdata}\ISO-region.csv", clear
ren _all, low
ren alpha3 iso

encode region, gen(regionfe)
encode subregion, gen(subregionfe)

tempfile REGIONFE
save `REGIONFE', replace 

*WB data (VA and IDA indexes)
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

tempfile VAINDEX
save `VAINDEX', replace 

import excel "${rdata}\WB\P_Data_Extract_From_Country_Policy_and_Institutional_Assessment.xlsx", sheet("Data") firstrow case(lower) clear
ren countrycode iso 
keep iso yr*

drop if iso==""

reshape long yr, i(iso) j(year)

ren yr ida_index
destring ida_index, force replace 

tempfile IDAINDEX
save `IDAINDEX', replace 

*WJP data
import excel "${rdata}\WJP\2024_wjp_rule_of_law_index_HISTORICAL_DATA_FILE.xlsx", sheet("Historical Data") firstrow case(lower) clear

ren countrycode iso

replace year="2013" if year=="2012-2013"
replace year="2018" if year=="2017-2018"
destring year, replace

tempfile WJPINDEX
save `WJPINDEX', replace 

*VHDA data (paper from FRED about VDEM accountability)
use "${rdata}\VHDA\accountability_data_regressions.dta", clear
ren country_text_id iso 
ren _all, low 

keep iso year vertical diagonal horizontal accountability v2x_corr violence_domestic loggdp lnpop

ren (vertical diagonal horizontal accountability) (vertical_index diagonal_index horizontal_index accountability_index)

tempfile VHDAINDEX
save `VHDAINDEX', replace

* VDEM CORE Accountability and Corruption
import excel "${rdata}\WB\VDEM-CORE.xlsx", sheet("Data") firstrow case(lower) clear

gen indicator_type = "a" if indicator==  "Accountability index"
replace indicator_type = "ha" if indicator==  "Horizontal accountability index"
replace indicator_type = "va" if indicator==  "Vertical accountability index"
replace indicator_type = "da" if indicator==  "Diagonal accountability index"
replace indicator_type = "pc" if indicator==  "Political corruption index"
replace indicator_type = "ec" if indicator==  "Executive corruption index"
replace indicator_type = "jc" if indicator==  "Judicial constraints on the executive index"

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

reshape long a_x_ ha_x_ va_x_ da_x_ pc_x_ ec_x_ jc_x_, i(iso) j(year)

ren *x_ *vdemcore

la var a_vdemcore "Accountability Index (VDEM)"
la var ha_vdemcore "Horizontal Accountability Index (VDEM)"
la var va_vdemcore "Vertical Accountability Index (VDEM)"
la var da_vdemcore "Diagonal Accountability Index (VDEM)"
la var pc_vdemcore "Political Corruption Index (VDEM)"
la var ec_vdemcore "Executive Corruption Index (VDEM)"
la var jc_vdemcore "Judicial Constraints on the Executive Index (VDEM)"

tempfile VDEMCORE
save `VDEMCORE', replace

*Corruption perception index score (WB)
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

la var cp_index "Corruption Perceptions Index (WB)"

tempfile CPINDEX
save `CPINDEX', replace 

*Press Freedom Index (RSF-WB)
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

la var pf_index "Press Freedom Index (RSF)"

tempfile PFINDEX
save `PFINDEX', replace 

*-------------------------------------------------------------------------------
*Merging everything together
*
*-------------------------------------------------------------------------------
use `VAINDEX', clear

merge 1:1 year iso using `VHDAINDEX', nogen
merge 1:1 year iso using `WJPINDEX', nogen 
merge 1:1 year iso using `IDAINDEX', nogen 
merge 1:1 year iso using `VDEMCORE', nogen 
merge 1:1 year iso using `CPINDEX', keep(1 3) nogen
merge 1:1 year iso using `PFINDEX', keep(1 3) nogen
merge 1:1 year iso using `VDEMINDEX', keep(1 3) keepus(vdem_regime) nogen 
merge 1:1 year iso using `VDEMINDEX2', keep(1 3) keepus(vdem_index) nogen
merge m:1 iso using `REGIONFE', keep(1 3) keepus(regionfe subregionfe) nogen 
merge 1:1 year iso using `GDP', keep(1 3) nogen 

la var va_index "Voice and Accountability Index (WB)"
la var ida_index "IDA Resource Allocation Index (WB)"
la var accountability_index "Accountability Index (VDEM)"
la var vertical_index "Vertical Accountability Index (VDEM)"
la var horizontal_index "Horizontal Accountability Index (VDEM)"
la var diagonal_index "Diagonal Accountability Index (VDEM)"

save "${idata}\wjp_wb_vhda_13_24_country_lvl.dta", replace




*END
