/*------------------------------------------------------------------------------
PROJECT: Guerrillas & Development
AUTHOR: JMJR
TOPIC: Master do-file
DATE:

NOTES: 
------------------------------------------------------------------------------*/

clear all 

*Setting directories 
if c(username) == "juami" {
	gl localpath "C:\Users/`c(username)'\Dropbox\RAships\1-Political-Claudio-Project"
	gl overleafpath "C:\Users/`c(username)'\Dropbox\Overleaf\Claudio-Handbook"
	gl code "C:\Github\Political-Handbook\code"
	
}
else {
	*gl path "C:\Users/`c(username)'\Dropbox\"
}

gl data "${localpath}/data"
gl rdata "${localpath}/data\raw"
gl idata "${localpath}\data\interim"
gl maps "${localpath}\data\maps"
gl tables "${overleafpath}\tables"
gl plots "${overleafpath}\plots"

cd "${data}"

*Setting a pre-scheme for plots
set scheme stcolor 
grstyle init
grstyle title color black
grstyle color background white
grstyle color major_grid dimgray
grstyle linewidth major_grid 0.07
*grstyle color major_grid white

*-------------------------------------------------------------------------------
* Replication Pipeline
*
*-------------------------------------------------------------------------------

*-------------------------------------------------------------------------------
* Preparing Data 
*-------------------------------------------------------------------------------
do "${code}/0_master.do"
do "${code}/1_prepare_WVS_series.do"
do "${code}/1_prepare_Barometers.do"
do "${code}/1_prepare_WJP.do"

*-------------------------------------------------------------------------------
* Plots correlating surveys and VDEM 
*-------------------------------------------------------------------------------
do "${code}/2_scatter_coefplots_WVS_vdem.do"
do "${code}/2_scatter_coefplots_Barometers_vdem.do"

*-------------------------------------------------------------------------------
* Plots correlating surveys and GDP 
*-------------------------------------------------------------------------------
*NOTE: I took out autocracies as requested 
do "${code}/2_scatter_WVS_GDP.do"
do "${code}/2_scatter_barometer_GDP.do"
do "${code}/2_scatter_WJP_GDP.do"


*END


