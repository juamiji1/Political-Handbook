
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

*WJP data
import excel "${rdata}\WJP\2024_wjp_rule_of_law_index_HISTORICAL_DATA_FILE.xlsx", sheet("Historical Data") firstrow case(lower) clear

ren countrycode iso

replace year="2013" if year=="2012-2013"
replace year="2018" if year=="2017-2018"
destring year, replace

merge 1:1 year iso using `VDEMINDEX', keep(1 3) keepus(vdem_regime) nogen 
merge 1:1 year iso using `VDEMINDEX2', keep(1 3) keepus(vdem_index) nogen
merge m:1 iso using `REGIONFE', keep(1 3) keepus(regionfe subregionfe) nogen 
merge 1:1 year iso using `GDP', keep(1 3) nogen 

save "${idata}\wjp_13_24_country_lvl.dta", replace





