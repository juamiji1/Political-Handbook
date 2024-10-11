

*-------------------------------------------------------------------------------
*	PREPARING DATA
*
*-------------------------------------------------------------------------------
*Preparing globals to match names with the WVS7
gl newvars "q152	q153	q154	q155	q156	q157	q151	q43	q44	q45	q199	q209	q210	q211	q212	q240	q42	q106	q107	q108	q109	q110	q64	q65	q66	q68	q69	q73	q74	q67	q71	q72	q77	q79	q80	q70	q82_eu	q82	q86	q83	q82_arableague	q82_asean	q82_nafta	q82_mercosur	q82_saarc	q82_apec	q82_tlc	q81	q78	q82_cis	q84	q75	q82_islcoop	q82_oas	q82_gulfcoop	q89	q88	q87	q76	q85	q82_undp	q82_africanunion		q235	q236	q237	q238	q239	q253	q130	q223_local	q223	q158	q159	q160	q241	q242	q243	q244	q245	q246	q249	q247	q248	q163	q250	q251	q201	q207	q208	q202	q203	q204	q205	q206	q221	q222	q224	q225	q226	q227	q228	q229	q230	q231	q232	q233	q234	q112	q113	q114	q115	q116	q117	q118	q119	q120	q56	q90	q91	q92	q93	q217	q218	q219	q220	q213	q214	q215	q216	q194	q234a	q289	q289cs9	q171	q172	q173	q165	q166	q167	q168	q164	q177	q179	q190	q191	q192	q178	q180	q181	q182	q183	q184	q185	q188	q187	q193	q186	q195	q189	q174	q175	q169	q170	q176	q254	q59	q60	q61	q62	q63	q272	q264	q265	q263	q269	q121	q122	q123	q124	q125	q126	q127	q128	q129	q258	q259	q255	q131	q132	q133	q134	q135	q136	q139	q140	q141	q144	q145	q142	q143 iso a_year w_weight wave"

gl oldvars "e001	e002	e003	e004	e005	e006	e012	e015	e016	e018	e023	e025	e026	e027	e028	e033	e034	e035	e036	e037	e039	e040	e069_01	e069_02	e069_04	e069_05	e069_06	e069_07	e069_08	e069_10	e069_11	e069_12	e069_13	e069_14	e069_15	e069_17	e069_18	e069_18a	e069_19	e069_20	e069_21	e069_22	e069_24	e069_26	e069_27	e069_29	e069_30	e069_40	e069_41	e069_43	e069_45	e069_54	e069_55	e069_56	e069_59	e069_61	e069_62	e069_63	e069_64	e069_65	e069_66	e069_67		e114	e115	e116	e117	e117b	e124	e143	e179_wvs7loc	e179wvs	e217	e218	e220	e224	e225	e226	e227	e228	e229	e233	e233a	e233b	e234	e235	e236	e248b	e253b	e254b	e258b	e259b	e260b	e261b	e262b	e263	e264	e265_01	e265_02	e265_03	e265_04	e265_05	e265_06	e265_07	e265_08	e265_09	e265_10	e266	e268	e269	e270	e271	e272	e273	e274	e275	e276	e277	e278	e279	e280	e281	e282	e283	e284	e285	e286	e287	e288	e289	e290	e291	f025	f025_wvs	f028	f028b	f034	f050	f051	f053	f054	f063	f114a	f114b	f114c	f114d	f114e	f115	f116	f117	f118	f119	f120	f121	f122	f123	f132	f135a	f144_02	f199	f200	f201	f202	f203	f206	g006	g007_18_b	g007_33_b	g007_34_b	g007_35_b	g007_36_b	g016	g026	g027	g027a	g027b	g052	g053	g054	g055	g056	g057	g058	g059	g060	g062	g063	g255	h001	h002_01	h002_02	h002_03	h002_04	h002_05	h003_01	h003_02	h003_03	h004	h005	h006_01	h006_02 country_alpha s020 s017 s002vs"
*look q252 q137 q138

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
gl allvars "${trust} ${percep} ${corrup} ${action} ${insec} ${labored} ${polviol} ${citcult} ${polreg} q252 q112"

*Prepare region FE (IMPROVE THIS)
import delimited "${rdata}\ISO-region.csv", clear
ren _all, low
ren alpha3 iso

encode region, gen(regionfe)
encode subregion, gen(subregionfe)

tempfile REGIONFE
save `REGIONFE', replace 


*-------------------------------------------------------------------------------
*	PREPARING WBI GDP PP and POLITY 
*
*-------------------------------------------------------------------------------
*Load data on GDP PP at US$ 2015
import delimited "${rdata}\GDP_PPP\GDP_PPP.csv", clear

ren countrycode iso
reshape long gdp_, i(iso) j(year)
ren gdp_ gdp 

gen ln_gdp=ln(gdp)

keep iso year gdp ln_gdp

tempfile GDP
save `GDP', replace 

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

	
*-------------------------------------------------------------------------------
*	PREPARING WVS SERIES DATA
*
*-------------------------------------------------------------------------------
*Load WVS7
use "${rdata}\WVS\time_series_81_22\WVS_Time_Series_1981-2022_stata_v5_0.dta", clear

ren _all, low
keep ${oldvars} 

ren (${oldvars}) (${newvars})

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
	tab `var' 
}

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

recode q112 (-5 -4 -3 -2 -1 =.)

*Inverting the scales so most is better 
foreach var of global percep {
	tab `var' 
}

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
gl insec "q131 q132 q133 q134 q135 q136 "
gl insec_inv "q131_inv q132_inv q133_inv q134_inv q135_inv q136_inv"
*q137_inv q138_inv

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
*	COLLAPSING DATA ATT COUNTRY (WEIGHTING)
*-------------------------------------------------------------------------------
*Standardizing ICW indexes
foreach var in index_trust index_percep index_corrup index_action index_insec index_polviol index_labored index_citcult{
	egen z_`var'=std(`var')
}

*Capturing labels of the raw variables 
gl allvars "${trust} ${percep} ${corrup} ${action} ${insec} ${labored} ${polviol} ${citcult} ${polreg} q112" //q252
foreach var of global allvars {
	local label_`var' : variable label `var'	
	dis "`label_`var''"
}

*Collapsing data at the coutnry level (using population weights - pweights)
collapse (mean) ${trust_inv} sum_trust_inv index_trust ${percep_inv} sum_percep_inv index_percep ${corrup} sum_corrup index_corrup q112 ${action_inv} sum_action_inv index_action ${insec_inv} sum_insec_inv index_insec ${labored_inv} sum_labored_inv index_labored ${polviol} sum_polviol_inv index_polviol ${citcult} sum_citcult_inv index_citcult ${polreg} z_index_* [pw=w_weight], by(regionfe wave a_year iso)
* q252

ren a_year year 

*-------------------------------------------------------------------------------
*Merging and labelling 
*-------------------------------------------------------------------------------
merge 1:1 year iso using `GDP', keep(1 3) nogen 
merge 1:1 year iso using `POLITYINDEX', keep(1 3) keepus(polity_index) nogen 
merge m:1 iso using `POLITYINDEX18', keep(1 3 4 5) keepus(polity_index) update nogen

*Definitions of democracy
gen democracy=1 if polity_index>=6 & polity_index!=.
replace democracy=0 if polity_index<6 

*Labelling
gl allvars_inv "${trust} ${percep} ${action} ${insec} ${labored}"
foreach var of global allvars_inv{
	la var `var'_inv "`label_`var''"
}

gl allvars_noinv "${corrup} ${polviol} ${citcult} ${polreg} q112"
foreach var of global allvars_noinv{
	la var `var' "`label_`var''"
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

save "${idata}\wvs_series_gdp_country_year_lvl.dta", replace



*END