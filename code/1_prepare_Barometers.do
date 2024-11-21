*-------------------------------------------------------------------------------
*	PREPARING WBI GDP PP - POLITY - VDEM
*
*-------------------------------------------------------------------------------
*ISO Codes
import excel "${rdata}\ISO3-country.xlsx", sheet("Sheet1") firstrow clear

tempfile ISO
save `ISO', replace

*Prepare region FE (IMPROVE THIS)
import delimited "${rdata}\ISO-region.csv", clear
ren _all, low
ren alpha3 iso

encode region, gen(regionfe)
encode subregion, gen(subregionfe)

tempfile REGIONFE
save `REGIONFE', replace 

*Load data on polity index
import delimited "${rdata}\Polity\democracy-index-polity.csv", clear
ren (code democracy) (iso polity_index)

drop if iso==""
keep if year >1979
keep iso year polity_index

preserve
	keep if year==2018
	drop year
	
	tempfile POLITYINDEX18
	save `POLITYINDEX18', replace 
restore 

tempfile POLITYINDEX
save `POLITYINDEX', replace 

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


*-------------------------------------------------------------------------------
*	PREPARING LATINOBAROMETER
*
*-------------------------------------------------------------------------------
use "${rdata}\Barometers\F00017011-Latinobarometro_2023_Stata_v1_0\Latinobarometro_2023_Eng_Stata_v1_0.dta", clear
ren _all, low

recode p13st_g p13st_h p60st p4stgbs (-2 -1 =.)

*Inverting the scales so most is better 
foreach var in p13st_g p13st_h p60st{
	replace `var' =. if `var'<0
	gen `var'_inv=-(`var'-5)
	
	gen d_`var'_inv=1 if `var'_inv>2 & `var'_inv!=.
	replace d_`var'_inv=0 if `var'_inv<3
}

tab p4stgbs, g(d_)

ren (d_35 d_36 d_26 d_5 d_9 d_p13st_g_inv d_p13st_h_inv d_p60st_inv) (d_corruption d_political d_crime d_economic d_unemployment d_parties d_elections d_reduce_corrup)

decode idenpa, gen(country)
gen year=2023

collapse d_corruption d_political d_crime d_economic d_unemployment d_parties d_elections d_reduce_corrup [aw = wt], by(country year)

gen latino=1

la var d_corruption "Most important problem: Corruption"
la var d_political "Most important problem: Political"
la var d_crime "Most important problem: Crime"
la var d_economic "Most important problem: Economic"
la var d_unemployment "Most important problem: Unemployment"
la var d_parties "Confidence in: Parties"
la var d_elections "Confidence in: Elections"
la var d_reduce_corrup "Corruption has reduced"

tempfile LATINOBAROMETER
save `LATINOBAROMETER', replace
  
*-------------------------------------------------------------------------------
*	PREPARING ARAB
*
*-------------------------------------------------------------------------------
use "${rdata}\Barometers\ArabBarometer_WaveVIII_English_v1\ArabBarometer_WaveVIII_English_v1.dta", clear
ren _all, low

recode q201b_12 q104a_2_7 q606_8 q2061a q2061a_kuw (99 98 =.)

replace q211b=q211c if q211b==.

foreach var in q201b_12 q210 q211b q606_8 q211_2 {
	gen d_`var'=(`var'<3) if `var'!=.
}

replace q2061a=q2061a_kuw if q2061a==.

gen d_economic=(q2061a==1) if q2061a!=.
gen d_corruption=(q2061a==2) if q2061a!=.
gen d_political=(q2061a==6) if q2061a!=.

ren (d_q201b_12 d_q210 d_q211b d_q606_8 d_q211_2) (d_parties d_nat_corruption d_local_corruption d_rleader_corruption d_reduce_corrup)

decode country, gen(country2)
gen year=2023

collapse d_economic d_corruption d_political d_parties d_nat_corruption d_local_corruption d_rleader_corruption d_reduce_corrup [aw = wt], by(country2 year)
ren country2 country

gen arab=1

la var d_corruption "Most important problem: Corruption"
la var d_political "Most important problem: Political"
la var d_economic "Most important problem: Economic"
la var d_parties "Confidence in: Parties"
la var d_nat_corruption "Corruption in national gov"
la var d_local_corruption "Corruption in local govs"
la var d_rleader_corruption "Corruption of religious leaders"
la var d_reduce_corrup "Corruption has reduced"

tempfile ARABAROMETER
save `ARABAROMETER', replace
   
*-------------------------------------------------------------------------------
*	PREPARING AFRO
*
*-------------------------------------------------------------------------------
import spss using "${rdata}\Barometers\R9.Merge_39ctry.20Nov23.final_.release_Updated.23Aug24.sav\R9.Merge_39ctry.20Nov23.final.release_Updated.23Aug24.sav", clear
ren _all, low

recode q45pt1 (9999 9998 =.)

gen d_economic=(q45pt1==1 | q45pt1==2 | q45pt1==4  | q45pt1==5  | q45pt1==6) if q45pt1!=.
gen d_unemployment=(q45pt1==3) if q45pt1!=.
gen d_corruption=(q45pt1==24) if q45pt1!=.
gen d_political=(q45pt1==25 | q45pt1==26 | q45pt1==28 | q45pt1==29 | q45pt1==30 | q45pt1==31) if q45pt1!=.
gen d_crime=(q45pt1==23) if q45pt1!=.

recode q37e q37f q38a q38b q38d q38i q38h q39a (8 9 94 =.)

foreach var in q37e q37f q38a q38b q38d q38i q38h {
	gen d_`var'=(`var'>1) if `var'!=.
}

replace d_q37e = 1 if d_q37f==1 & d_q37e==0
replace d_q38a = 1 if d_q38b==1 & d_q38a==0
replace d_q38h = 1 if d_q38i==1 & d_q38h==0

gen d_q39a=(q39a>3) if q39a!=.

ren (d_q37e d_q38a q38d d_q38h d_q39a) (d_parties d_nat_corruption d_local_corruption d_rleader_corruption d_reduce_corrup)

decode country, gen(country2)
gen year=2022

collapse d_economic d_corruption d_political d_parties d_nat_corruption d_local_corruption d_rleader_corruption d_reduce_corrup [aw = combinwt_new_hh], by(country2 year)
ren country2 country

gen afro=1

la var d_corruption "Most important problem: Corruption"
la var d_political "Most important problem: Political"
la var d_economic "Most important problem: Economic"
la var d_parties "Confidence in: Parties"
la var d_nat_corruption "Corruption in national gov"
la var d_local_corruption "Corruption in local govs"
la var d_rleader_corruption "Corruption of religious leaders"
la var d_reduce_corrup "Corruption has reduced"

tempfile AFROBAROMETER
save `AFROBAROMETER', replace


*-------------------------------------------------------------------------------
*	PREPARING EURO
*
*-------------------------------------------------------------------------------
use "${rdata}\Barometers\EU\ZA7887_v1-0-0.dta", clear
ren _all, low

recode qa5 (6=.)
recode qa6 (7=.)
recode qa15_1 qa15_2 (5=.)

foreach var in qa5 qa15_1 qa15_2   {
	gen d_`var'=(`var'<3) if `var'!=.
}

gen d_qa6=(qa6>3) if qa6!=. ///decrease

ren (d_qa5 d_qa6 qa7_6 qa7_7 d_qa15_1 d_qa15_2) (d_corruption d_reduce_corrup d_politicians_corrup d_parties_corrup d_nat_corruption d_local_corruption)

decode tnscntry, gen(country2)
gen year=2022

collapse d_corruption d_reduce_corrup d_politicians_corrup d_parties_corrup d_nat_corruption d_local_corruption [aw = w92], by(country2 isocntry year)
ren country2 country

gen euro=1

la var d_corruption "Most important problem: Corruption"
la var d_politicians_corrup "Politician are Corrupt"
la var d_parties_corrup "Parties are Corrupt"
la var d_nat_corruption "Corruption in national gov"
la var d_local_corruption "Corruption in local govs"
la var d_reduce_corrup "Corruption has reduced"

tempfile EUROBAROMETER
save `EUROBAROMETER', replace

use "${rdata}\Barometers\EU\ZA7997_v1-0-0", clear
ren _all, low

recode qa6_2 (3=.)
gen d_qa6_2=(qa6_2==1) if qa6_2!=.

ren (qa3_1 qa3_2 qa3_5 d_qa6_2) (d_crime d_economic d_unemployment d_parties)

decode tnscntry, gen(country2)
gen year=2022

collapse d_crime d_economic d_unemployment d_parties [aw = w92], by(country2 isocntry year)
ren country2 country

gen euro=1

la var d_economic "Most important problem: Economic"
la var d_parties "Confidence in: Parties"
la var d_crime "Most important problem: Crime"
la var d_unemployment "Most important problem: Unemployment"

merge 1:1 isocntry using `EUROBAROMETER', nogen


*-------------------------------------------------------------------------------
*	APPENDING EVERYTHING
*
*-------------------------------------------------------------------------------
append using `AFROBAROMETER' `ARABAROMETER' `LATINOBAROMETER'

replace country = regexr(country, " \(.+\)", "")
replace country = trim(country)

duplicates tag country, g(dup)
tab dup

drop if dup==1 & arab==1
drop dup 

merge 1:1 country using `ISO', keep(1 3) nogen

replace iso3 = "BRA" if country == "Brasil"
replace iso3 = "CPV" if country == "Cabo Verde"
replace iso3 = "COG" if country == "Congo-Brazzaville"
replace iso3 = "CYP" if country == "Cyprus - CY"
replace iso3 = "CIV" if country == "Côte d'Ivoire"
replace iso3 = "DEU" if country == "DE"
replace iso3 = "" if country == "DW" // No ISO code for "DW"
replace iso3 = "SWZ" if country == "Eswatini"
replace iso3 = "ETH" if country == "Ethiopia"
replace iso3 = "GMB" if country == "Gambia"
replace iso3 = "XKX" if country == "Kosovo"
replace iso3 = "LUX" if country == "Luxemburg"
replace iso3 = "MKD" if country == "Macedonia"
replace iso3 = "MNE" if country == "Montenegro"
replace iso3 = "PSE" if country == "Palestine"
replace iso3 = "DOM" if country == "Rep. Dominicana"
replace iso3 = "SRB" if country == "Serbia"
replace iso3 = "SVK" if country == "Slovakia"
replace iso3 = "STP" if country == "São Tomé and Príncipe"

drop if country=="Cyprus - CY" |iso3==""

ren iso3 iso

*Merging political regime classification
merge 1:1 year iso using `POLITYINDEX', keep(1 3) keepus(polity_index) nogen 
merge m:1 iso using `POLITYINDEX18', keep(1 3 4 5) keepus(polity_index) update nogen
merge 1:1 year iso using `VDEMINDEX', keep(1 3) keepus(vdem_regime) nogen 
merge 1:1 year iso using `VDEMINDEX2', keep(1 3) keepus(vdem_index) nogen 
merge 1:1 iso using `REGIONFE', keep(1 3) keepus(regionfe subregionfe) nogen 

*Definitions of democracy
gen democracy=1 if polity_index>=6 & polity_index!=.
replace democracy=0 if polity_index<6 

gen polity_regime=0 if polity_index<-5
replace polity_regime=1 if polity_index>=-6 & polity_index<6
replace polity_regime=2 if polity_index>=6 & polity_index!=. 

*Fixing one name 
replace country="Germany" if iso=="DEU"

save "${idata}\barometer_22_23_country_lvl.dta", replace



*END
