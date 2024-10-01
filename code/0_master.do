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
	gl localpath "C:\Users/`c(username)'\Dropbox\1-Political-Claudio-Project"
	gl overleafpath "C:\Users/`c(username)'\Dropbox\Overleaf\Claudio-Handbook"
	gl do "C:\Github\Political-Handbook\code"
	
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