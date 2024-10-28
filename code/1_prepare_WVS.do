
*-------------------------------------------------------------------------------
*	PREPARING WBI GDP PP
*
*-------------------------------------------------------------------------------
*Load data on GDP PP a US$ 2021
import delimited "${rdata}\GDP_PPP\GDP_US15.csv", clear

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


*-------------------------------------------------------------------------------
*	PREPARING WVS7 DATA
*
*-------------------------------------------------------------------------------
*Load WVS7
use "${rdata}\WVS\wvs7\WVS_Cross-National_Wave_7_stata_v6_0.dta", clear

*keep A_YEAR B_COUNTRY B_COUNTRY_ALPHA D_INTERVIEW pwght Q69 Q73 Q71 Q72 Q70 Q76 Q252 Q238 Q243 Q245 Q250 Q251 Q221 Q222 Q224 Q225 Q227 Q229 Q232 Q112 Q113 Q115 Q179 Q192 Q180 Q181 Q131 Q142

ren _all, low
ren b_country_alpha iso

*Globals per topic:
gl trust "q65 q66 q69 q70 q71 q72 q73 q76"
gl percep "q224 q225 q227 q229 q232"
gl corrup "q113 q115"
gl action "q221 q222"
gl insec "q131 q132 q133 q134 q135 q136 q137 q138"
gl labored "q142 q143"
gl polviol "q192 q194"
gl citcult "q177 q178 q179 q180 q181"
gl polreg "q235 q236 q237 q238 q243 q245 q250 q251"
gl account "q292a q292b q292c q292e q292g q292i q292j q292k q292l"
gl allvars "${trust} ${percep} ${corrup} ${action} ${insec} ${labored} ${polviol} ${citcult} ${polreg} ${account} q252 q112"

/*Taking out outliers: 
foreach var of global allvars{
	summ `var', d
	replace `var'=. if `var'>= r(p99) |  `var'<= r(p1)	
}
*/

*Merging region FEs
merge m:1 iso using `REGIONFE', keep(1 3) keepus(regionfe subregionfe) nogen 
replace regionfe=4 if iso=="NIR"
replace regionfe=3 if iso=="TWN"

*-------------------------------------------------------------------------------
*	TRUST IN INSTITUTIONS 
*-------------------------------------------------------------------------------
gl trust "q65 q66 q69 q70 q71 q72 q73 q76"		// For now not including churches q64 and banks q78
gl trust_inv "q65_inv q66_inv q69_inv q70_inv q71_inv q72_inv q73_inv q76_inv"

*Inverting the scales so most is better 
foreach var of global trust {
	replace `var' =. if `var'<0
	gen `var'_inv=-(`var'-5)
}

*Creating total sum  
egen sum_trust_inv=rowtotal(${trust_inv}), missing

*Creating ICW index
gen wgt=1
gen stdgroup=1

do "${do}\make_index_gr.do"
make_index_gr trust wgt stdgroup ${trust_inv}

*-------------------------------------------------------------------------------
*	POLITICAL PERCEPTIONS  
*-------------------------------------------------------------------------------
* DO THIS ONE: q252
gl percep "q224 q225 q227 q229 q232"
gl percep_inv "q224_inv q225_inv q227_inv q229_inv q232_inv"

*DO THIS ONE: q112
gl corrup "q113 q115"

recode q252 q112 (-5 -4 -3 -2 -1 =.)

*Inverting the scales so most is better 
foreach var of global percep {
	replace `var' =. if `var'<0
	gen `var'_inv=-(`var'-5)
}

*Creating total sum  
egen sum_percep_inv=rowtotal(${percep_inv}), missing
egen sum_corrup=rowtotal(${corrup}), missing

*Creating ICW index
make_index_gr percep wgt stdgroup ${percep_inv}
make_index_gr corrup wgt stdgroup ${corrup}

*-------------------------------------------------------------------------------
*	POLITICAL ACTION  
*-------------------------------------------------------------------------------
gl action "q221 q222"
gl action_inv "q221_inv q222_inv"

*Inverting the scales so most is better 
foreach var of global action {
	replace `var' =. if `var'<0 | `var'==4		// In this case 4 is not "allowed to vote"
	gen `var'_inv=-(`var'-4)
}

*Creating total sum  
egen sum_action_inv=rowtotal(${action_inv}), missing

*Creating ICW index
make_index_gr action wgt stdgroup ${action_inv}

*-------------------------------------------------------------------------------
*	OTHER PERCEPTIONS  
*-------------------------------------------------------------------------------
gl insec "q131 q132 q133 q134 q135 q136 q137 q138"
gl insec_inv "q131_inv q132_inv q133_inv q134_inv q135_inv q136_inv q137_inv q138_inv"

gl labored "q142 q143"
gl labored_inv "q142_inv q143_inv"

foreach var of global insec {
	replace `var' =. if `var'<0
	gen `var'_inv=-(`var'-5)
}

foreach var of global labored {
	replace `var' =. if `var'<0
	gen `var'_inv=-(`var'-5)
}

egen sum_insec_inv=rowtotal(${insec_inv}), missing
egen sum_labored_inv=rowtotal(${labored_inv}), missing

make_index_gr insec wgt stdgroup ${insec_inv}
make_index_gr labored wgt stdgroup ${labored_inv}

*-------------------------------------------------------------------------------
*	POLITICAL/CITIZEN CULTURE  
*-------------------------------------------------------------------------------
gl polviol "q192 q194"
gl citcult "q177 q178 q179 q180 q181"

foreach var of global polviol {
	replace `var' =. if `var'<0
}

foreach var of global citcult {
	replace `var' =. if `var'<0
}

egen sum_polviol_inv=rowtotal(${polviol}), missing
egen sum_citcult_inv=rowtotal(${citcult}), missing

make_index_gr polviol wgt stdgroup ${polviol}
make_index_gr citcult wgt stdgroup ${citcult}

*-------------------------------------------------------------------------------
*	POLITICAL REGIMES 
*-------------------------------------------------------------------------------
gl polreg "q235 q236 q237 q238 q243 q245 q250 q251"	//Make them apart q238 is directly about democray 
*CHECK WHICH ONES TO INVERT SCALE 

foreach var of global polreg {
	replace `var' =. if `var'<0
}

*check these ones!!!!!! negative values

*-------------------------------------------------------------------------------
*	ACCOUNTABILITY
*-------------------------------------------------------------------------------
end
gl account "q292a q292b q292c q292e q292g q292i q292j q292k q292l"

foreach var of global account {
	replace `var' =. if `var'<0
	gen d_`var'=(`var'>3) if `var'!=.
}

end
*-------------------------------------------------------------------------------
*	COLLAPSING DATA ATT COUNTRY (WEIGHTING)
*-------------------------------------------------------------------------------
*Standardizing ICW indexes
foreach var in index_trust index_percep index_corrup index_action index_insec index_polviol index_labored index_citcult{
	egen z_`var'=std(`var')
}

*Capturing labels of the raw variables 
gl allvars "${trust} ${percep} ${corrup} ${action} ${insec} ${labored} ${polviol} ${citcult} ${polreg} q252 q112 ${account}"
foreach var of global allvars {
	local label_`var' : variable label `var'	
	dis "`label_`var''"
}

*Collapsing data at the coutnry level (using population weights - pweights)
collapse (mean) ${trust_inv} sum_trust_inv index_trust ${percep_inv} sum_percep_inv index_percep q252 ${corrup} sum_corrup index_corrup q112 ${action_inv} sum_action_inv index_action ${insec_inv} sum_insec_inv index_insec ${labored_inv} sum_labored_inv index_labored ${polviol} sum_polviol_inv index_polviol ${citcult} sum_citcult_inv index_citcult ${polreg} z_index_* d_* [aw=w_weight], by(regionfe a_year iso)
ren a_year year 

*-------------------------------------------------------------------------------
*Merging and labelling 
*-------------------------------------------------------------------------------
merge 1:1 year iso using `GDP', keep(1 3) nogen 

*Labelling
gl allvars_inv "${trust} ${percep} ${action} ${insec} ${labored}"
foreach var of global allvars_inv{
	la var `var'_inv "`label_`var''"
}

gl allvars_noinv "${corrup} ${polviol} ${citcult} ${polreg} q252 q112 ${account}"
foreach var of global allvars_noinv{
	cap la var `var' "`label_`var''"
	cap la var d_`var' "`label_`var''"
}

label var sum_trust_inv "Trust in Institutions (Sum)"
label var sum_percep_inv "Political Perceptions (Sum)"
label var sum_corrup "Perceptions on Corruption (Sum)"
label var sum_action_inv "Political Action (Sum)"
label var sum_insec_inv "Perceptions on Insecurity (Sum)"
label var sum_labored_inv "Labor and Ed. Perceptions (Sum)"
label var sum_polviol_inv "Political Violence Culture (Sum)"
label var sum_citcult_inv "Citizen Culture (Sum)"

label var z_index_trust "Trust in Institutions (ICW)"
label var z_index_percep "Political Perceptions (ICW)"
label var z_index_corrup "Perceptions on Corruption (ICW)"
label var z_index_action "Political Action (ICW)"
label var z_index_insec "Perceptions on Insecurity (ICW)"
label var z_index_labored "Labor and Ed. Perceptions (ICW)"
label var z_index_polviol "Political Violence Culture (ICW)"
label var z_index_citcult "Citizen Culture (ICW)"

la var gdp "GDP PC"
la var ln_gdp "Ln(GDP PC)"

save "${idata}\wvs7_gdp_country_year_lvl.dta", replace

  

*END