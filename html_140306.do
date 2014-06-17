set matsize 11000
set more off
cd "D:\E_Risk\data_acrchive"
*cd "\\Ccfp-0166\d\E_Risk"

global path D:\E_Risk\data_acrchive
global histocolor graphregion(lcolor(white) lwidth(thick) fcolor(white)) ///
	plotregion(fcolor("247 247 247")) plotregion(margin(medium)) ///
 	fcolor("163 194 255") fintensity(100) lcolor("163 194 255") lwidth(none) normopts(lcolor(orange_red)) ///
	yscale(noline) ylabel(#4, grid glwidth(medthick) glcolor(white)) ymtick(##2, noticks grid glwidth(vvvthin) glcolor(white)) ///
	xscale(noline) xlabel(#4, grid glwidth(medthick) glcolor(white)) xmtick(##2, noticks grid glwidth(vvvthin) glcolor(white)) 
	
global piecolor /*missing*/ angle(0) plabel(_all name, gap(10)) line(lcolor(white)) intensity(inten30) legend(region(lcolor(white))) ///
	graphregion(fcolor(white) lcolor(white) lwidth(none))
	
***************************************************************************
cd "$path\html\env"
capture htclose
htopen using ntype_des, replace
use "$path\data\N_type WIDE (Nov17).dta", clear
unab allvar: *
local idvars familyid atwinid btwinid SCIIurban
local lst1: list allvar - idvars
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>Urban vs. Rural </h2><h3>Descriptive Analysis of Neighborhood Type Variables </h3>
htput <h4> Neighborhood Type variables. </h4>
htput <table cellspacing=0 border=1><tr><td><table border=0 cellpadding="4" cellspacing="2"><tr class= firstline><td>Variable Names</td><td>Variable Labels</td></tr>
foreach x of local lst1 {
	htput <tr><td><a href="#`x'"><b>`x'</b></a> </td><td> `: di `"`: var label `x''"'' </td><tr>
}
htput </table></td></tr></table><br>
foreach x of local lst1 {
	htput <hr><h4> Variable Name: <a NAME="`x'"></a><span class="vname">`x'</span><br>
	htput Variable Label: `: di `"`: var label `x''"''</h4>
	quietly: ta `x'
	if r(r)>17 {
		htsummaryv `x', head format(%8.2f) test close
		*histogram `x', freq norm title("Histogram") ytitle("Frequency, # of Families") $histocolor
	}
	else {
		htsummaryv `x', head freq format(%8.2f) missing rowtotal close
		*graph pie, over(`x') $piecolor
	}
	*graph export "img/`x'.png", replace
	htput <img src="img/`x'.png">
	htput <br><a href="#top"><b>Back to Top</b></a><br>
}
htput </body>
htclose	
	
***************************************************************************
cd "$path\html\env"
!"C:\Program Files\R\R-3.0.2\bin\Rscript.exe" --slave D:/E_Risk/long_varlab.R "D:\E_Risk\Green Space\GreenSpaceJune2012" >D:/E_Risk/results.out
insheet variable question using "D:\E_Risk\Green Space\GreenSpaceJune2012_labels.txt", tab clear
drop if question==""
forvalues v = 1/`=_N' /*or `: di _N'*/ {
	local `: di variable[`v']' `: di question[`v']'
}

capture htclose
htopen using greenspace_des, replace
use "$path\data\greenspace.dta", clear
unab allvar: *
local idvars familyid 
local lst1: list allvar - idvars
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>Green Space </h2><h3>Descriptive Analysis of Green Space Variables </h3>
htput <h4> Green Space variables. </h4>
htput <table cellspacing=0 border=1><tr><td><table border=0 cellpadding="4" cellspacing="2"><tr class= firstline><td>Variable Names</td><td>Variable Labels</td></tr>
foreach x of local lst1 {
	local xl: word count ``x''
	if `xl'>0 htput <tr><td><a href="#`x'"><b>`x'</b></a> </td><td> ``x'' </td><tr>
	else htput <tr><td><a href="#`x'"><b>`x'</b></a> </td><td> `: di `"`: var label `x''"'' </td><tr>
}
htput </table></td></tr></table><br>
foreach x of local lst1 {
	htput <hr><h4> Variable Name: <a NAME="`x'"></a><span class="vname">`x'</span><br>
	local xl: word count ``x''
	if `xl'>0 htput Variable Label: ``x''</h4>
	else htput Variable Label: `: di `"`: var label `x''"''</h4>
	quietly: ta `x'
	if r(r)>5 {
		htsummaryv `x', head format(%8.2f) test close
		*histogram `x', freq norm title("Histogram") ytitle("Frequency, # of Families") $histocolor
	}
	else {
		htsummaryv `x', head freq format(%8.2f) missing rowtotal close
		*graph pie, over(`x') $piecolor
	}
	*graph export "img/`x'.png", replace
	htput <img src="img/`x'.png">
	htput <br><a href="#top"><b>Back to Top</b></a><br>
}
htput </body>
htclose	
	
***************************************************************************
cd "$path\html\acorn"
capture htclose
htopen using inequality_des, replace
use "$path\data\E-RiskIncomeInequality.dta", clear
drop atwinid
bysort familyid: keep if _n==1
save "$path\data\E-RiskIncomeInequality_clpsd", replace
unab allvar: *
local idvars familyid lowSESat12
local lst1: list allvar - idvars
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>Income Inequality </h2><h3>Descriptive Analysis of Income Inequality Variables </h3>
htput <h4> Income Inequality variables. </h4>
htput <table cellspacing=0 border=1><tr><td><table border=0 cellpadding="4" cellspacing="2"><tr class= firstline><td>Variable Names</td><td>Variable Labels</td></tr>
foreach x of local lst1 {
	htput <tr><td><a href="#`x'"><b>`x'</b></a> </td><td> `: di `"`: var label `x''"'' </td><tr>
}
htput </table></td></tr></table><br>
foreach x of local lst1 {
	htput <hr><h4> Variable Name: <a NAME="`x'"></a><span class="vname">`x'</span><br>
	htput Variable Label: `: di `"`: var label `x''"''</h4>
	*htsummaryv `x', head format(%8.2f) test close
	loc type: type `x'
	*if substr("`type'",1,3) == "str" {
	*	htsummaryv `x', head freq method(string) missing rowtotal close
	*}
	if substr("`type'", 1,4) == "byte" {
		htsummaryv `x', head freq format(%8.2f) missing rowtotal close
		*graph pie, over(`x') $piecolor
	}
	else {
		htsummaryv `x', head format(%8.2f) test close
		*histogram `x', freq norm title("Histogram") ytitle("Frequency, # of Families") $histocolor
	}
	*graph export "img/`x'.png", replace
	htput <img src="img/`x'.png">
	htput <br><a href="#top"><b>Back to Top</b></a><br>
}
htput </body>
htclose	

***************************************************************************
*** looks like could put the important vars upfront
cd "$path\html\sso"

!"C:\Program Files\R\R-3.0.2\bin\Rscript.exe" --slave D:/E_Risk/long_varlab.R "D:\E_Risk\sso\SSO-FINAL first (April2004)" >D:/E_Risk/results.out
insheet variable question using "D:\E_Risk\sso\SSO-FINAL first (April2004)_labels.txt", tab clear
drop if question==""
forvalues v = 1/`=_N' /*or `: di _N'*/ {
	local `: di variable[`v']' `: di question[`v']'
}
macro dir

capture htclose
htopen using sso_des, replace
use "$path\data\SSOeRisk_clean.dta", clear
unab allvar: *
local idvars familyid //SDWKCHAR_first_1
local lst1: list allvar - idvars
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>SSO </h2><h3>Descriptive Analysis of SSO Variables </h3>
htput <h4> SSO variables. </h4>
htput <table cellspacing=0 border=1><tr><td><table border=0 cellpadding="4" cellspacing="2"><tr class= firstline><td>Variable Names</td><td>Variable Labels</td></tr>
foreach x of local lst1 {
	*htput <tr><td><a href="#`x'"><b>`x'</b></a> </td><td> `: di `"`: var label `x''"'' </td><tr>
	local xl: word count ``x''
	if `xl'>0 htput <tr><td><a href="#`x'"><b>`x'</b></a> </td><td> ``x'' </td><tr>
	else htput <tr><td><a href="#`x'"><b>`x'</b></a> </td><td> `: di `"`: var label `x''"'' </td><tr>
}
htput </table></td></tr></table><br>
foreach x of local lst1 {
	htput <hr><h4>Variable Name: <a NAME="`x'"></a><span class="vname">`x'</span><br>
	local xl: word count ``x''
	if `xl'>0 htput Variable Label: ``x''</h4>
	else htput Variable Label: `: di `"`: var label `x''"''</h4>
	*htsummaryv `x', head format(%8.2f) test close
	loc type: type `x'
	*if substr("`type'",1,3) == "str" {
	*	htsummaryv `x', head freq method(string) missing rowtotal close
	*}
	local vl: val lab `x'
	local len: length local vl
	if `len'==0 {
		htsummaryv `x', head format(%8.2f) test close
		*histogram `x', freq norm title("Histogram") ytitle("Frequency, # of Families") $histocolor
	}
	else if substr("`type'", 1,4) == "byte" {
		htsummaryv `x', head freq format(%8.2f) missing rowtotal close
		*graph pie, over(`x') $piecolor
		piev `x'
	}
	else {
		htsummaryv `x', head format(%8.2f) test close
		*histogram `x', freq norm title("Histogram") ytitle("Frequency, # of Families") $histocolor
	}
	*graph export "img/`x'.png", replace
	htput <img src="img/`x'.png">
	htput <br><a href="#top"><b>Back to Top</b></a><br>
}
htput </body>
htclose	
	
***************************************************************************
cd "$path\html\acorn"
capture htclose
htopen using acorn_des, replace
use "$path\data\Acorn2001.dta", clear
local lst1 P5CACORNCategory P7CACORNCategory P10CACORNCategory P12CACORNCategory ///
	P5HealthACORN07Group P7HealthACORN07Group P10HealthACORN07Group P12HealthACORN07Group
local lst2 pcphase7 pcphase10 pcphase12 pcphasecurrent
local lst: list lst1 | lst2
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>Acorn / Health Acorn </h2><h3>Descriptive Analysis of Acorn/Health Acorn Variables </h3>
htput <h4> For ACORNCategory variables, it is recommended that 2 "Urban Prosperity" and 3 "Comfortably Off" are recoded as ///
	2 "Comfortably Off" and 3 "Urban Prosperity" as "Urban Prosperity" tend to do worse than "Comfortably Off" on various outcomes. </h4>
htput <table cellspacing=0 border=1><tr><td><table border=0 cellpadding="4" cellspacing="2"><tr class= firstline><td>Variable Names</td><td>Variable Labels</td></tr>
foreach x of local lst {
	htput <tr><td><a href="#`x'"><b>`x'</b></a> </td><td> `: di `"`: var label `x''"'' </td><tr>
}
htput </table></td></tr></table><br>
foreach x of local lst1 {
	htput <hr><h4> Variable Name: <a NAME="`x'"></a><span class="vname">`x'</span><br>
	htput Variable Label: `: di `"`: var label `x''"''</h4>
	*htsummaryv `x', head format(%8.2f) test close
	htsummaryv `x', head freq format(%8.2f) missing rowtotal close

	graph pie, over(`x') $piecolor
	graph export "img/`x'.png", replace
	htput <img src="img/`x'.png">
	htput <br><a href="#top"><b>Back to Top</b></a><br>
}
foreach x of local lst2 {
	htput <hr><h4> Variable Name: <a NAME="`x'"></a><span class="vname">`x'</span><br>
	htput Variable Label: `: di `"`: var label `x''"''</h4>
	*htsummaryv `x', head format(%8.2f) test close
	htsummaryv `x', head freq format(%8.2f) missing rowtotal close
	htput <br><a href="#top"><b>Back to Top</b></a><br>
}
htput </body>
htclose	
	
***************************************************************************
cd "$path\html\crime"
capture htclose
htopen using crime_des, replace
use "$path\data\crimes2011.dta", clear
local lst1a antisocial burglary violent vehicle robbery otherc ttlcrm2011
local lst1 
foreach x of loc lst1a {
	local lst1 `lst1' `x' `x'_log `x'_qrtl
}
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>Crime Data from Police Reports </h2><h3>Descriptive Analysis of Constructed Variables (Prorated) </h3>
htput <h4> For each constructed variable or scale, a pro-rated summed score was created for each resident if is less than half of the items in the scale is NOT missing. ///
	Then the summed score was aggregated across all residents of each neighborhood. </h4>
htput <table cellspacing=0 border=1><tr><td><table border=0 cellpadding="4" cellspacing="2"><tr class= firstline><td>Variable Names</td><td>Variable Labels</td></tr>
foreach x of local lst1 {
	htput <tr><td><a href="#`x'"><b>`x'</b></a> </td><td> `: di `"`: var label `x''"'' </td><tr>
}
htput </table></td></tr></table><br>
foreach x of local lst1 {
	htput <hr><h4> Variable Name: <a NAME="`x'"></a><span class="vname">`x'</span><br>
	htput Variable Label: `: di `"`: var label `x''"''</h4>
	htsummaryv `x', head format(%8.2f) test close

	*histogram `x', freq norm title("Histogram") ytitle("Frequency, # of Families") $histocolor
	*graph export "img/`x'.png", replace
	htput <img src="img/`x'.png">
	htput <br><a href="#top"><b>Back to Top</b></a><br>
}
htput </body>
htclose


*************************sci_des**************************************************
cd "$path\html\sci"
capture htclose
htopen using sci_des, replace
use "$path\data\SCIall.dta", clear
compress
local aggr haspc acratio colleff disadvan friends intclos like muttrust neighpro pctforbo pctlive pctmanpr pctunemp recpexch resstab n_break
drop `aggr' familyid
label def sc115 1 "Maybe", modify
format * %8.2g
unab lst1: *
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>Crime Data from Police Reports </h2><h3>Descriptive Analysis of Constructed Variables (Prorated) </h3>
htput <h4> For each constructed variable or scale, a pro-rated summed score was created for each resident if is less than half of the items in the scale is NOT missing. ///
	Then the summed score was aggregated across all residents of each neighborhood. </h4>
htput <table cellspacing=0 border=1><tr><td><table border=0 cellpadding="4" cellspacing="2"><tr class= firstline><td>Variable Names</td><td>Variable Labels</td></tr>
foreach x of local lst1 {
	htput <tr><td><a href="#`x'"><b>`x'</b></a> </td><td> `: var label `x'' </td><tr>
}
htput </table></td></tr></table><br>
foreach x of local lst1 {
	htput <hr><h4> Variable Name: <a NAME="`x'"></a><span class="vname">`x'</span><br>
	htput Variable Label: `: var label `x''</h4>
	quietly: ta `x'
	if r(r)<8 {
		htsummaryv `x', head freq format(%8.2f) missing rowtotal close
		graph pie, over(`x') $piecolor
	}
	else {
		htsummaryv `x', head format(%8.2f) test close
		histogram `x', freq norm title("Histogram") ytitle("Frequency, # of Families") $histocolor
	}
	graph export "img/`x'.png", replace
	htput <img src="img/`x'.png">
	htput <br><a href="#top"><b>Back to Top</b></a><br>
}
htput </body>
htclose

**********************sci_pror_des*****************************************************
cd "$path\html\sci"
capture htclose
htopen using sci_pror_des, replace
use "$path\data\SCIall.dta", clear
compress
local lst1 haspc acratio colleff disadvan friends intclos like muttrust neighpro pctforbo pctlive pctmanpr pctunemp recpexch resstab n_break
keep familyid `lst1'
format * %8.2g
bysort familyid: keep if _n==1
save "$path\data\SCIclpsdall", replace
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>Crime Data from Police Reports </h2><h3>Descriptive Analysis of Constructed Variables (Prorated) </h3>
htput <h4> For each constructed variable or scale, a pro-rated summed score was created for each resident if is less than half of the items in the scale is NOT missing. ///
	Then the summed score was aggregated across all residents of each neighborhood. </h4>
htput <table cellspacing=0 border=1><tr><td><table border=0 cellpadding="4" cellspacing="2"><tr class= firstline><td>Variable Names</td><td>Variable Labels</td></tr>
foreach x of local lst1 {
	htput <tr><td><a href="#`x'"><b>`x'</b></a> </td><td> `: var label `x'' </td><tr>
}
htput </table></td></tr></table><br>
foreach x of local lst1 {
	htput <hr><h4> Variable Name: <a NAME="`x'"></a><span class="vname">`x'</span><br>
	htput Variable Label: `: var label `x''</h4>
	quietly: ta `x'
	if r(r)<8 {
		htsummaryv `x', head freq format(%8.2f) missing rowtotal close
		*graph pie, over(`x') $piecolor
	}
	else {
		htsummaryv `x', head format(%8.2f) test close
		*histogram `x', freq norm title("Histogram") ytitle("Frequency, # of Families") $histocolor
	}
	*graph export "img/`x'.png", replace
	htput <img src="img/`x'.png">
	htput <br><a href="#top"><b>Back to Top</b></a><br>
}
htput </body>
htclose


*************************scii_des**************************************************
cd "$path\html\scii"
insheet Variable Question using "$path\data\scii_lables.txt", tab clear
replace question=subinstr(question,char(147),"",.) // left double quote replaced by normal single quote char(39)
replace question=subinstr(question,char(148),"",.) // right double quote replaced by normal single quote char(39)
split variable, gen(SC) p("II")
keep if SC1=="SC"
gen letter=substr(SC2, 1, 1)
drop SC*
local x
forvalues v = 1/`=_N' /*or `: di _N'*/ {
	local `: di variable[`v']' `: di question[`v']'
	local x `x' `: di variable[`v']'
}
*levelsof variable, clean local(x) /*does NOT work as it is ordered by the strings*/
macro dir
di "`x'"
capture htclose
htopen using scii_des, replace
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>Neighborhood Survey II </h2><h3>Descriptive Analysis of Original Variables </h3>
htput <h4> For each constructed variable or scale, a pro-rated summed score was created for each resident if is less than half of the items in the scale is NOT missing. ///
	Then the summed score was aggregated across all residents of each neighborhood. <br><a href="#nn"># of the Residental Neighbors Responded Per E-Risk Families</a></h4>
htput <table cellspacing=0 border=1><td><table border="0" cellpadding="4" cellspacing="2">
htput <tr class=firstline><td>Variable Names</td><td>Variable Labels</td></tr>
foreach y of local x {
	di "`y'"
	htput <tr><td><a NAME="l`y'"></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#`y'">`y'</a> </td><td> ``y'' </td></tr>
}
htput </table></td></table><br>

use "$path\data\SCIIfctrclpsdall_pror", clear
htput <hr><h4><a NAME="nn"></a> # of the Residental Neighbors Responded Per E-Risk Families </h4>
htsummaryv n, head format(%8.2f) test close
htput <br>
htsummaryv n, head freq format(%8.2f) missing rowtotal close
histogram n, freq norm xtitle("# of Residents") ytitle("# of E-Risk Families") $histocolor
graph export "img\scii_pror_n.png", replace
htput <img src="img\scii_pror_n.png"><br>
htput <br><a href="#top"><b>Back to List</b></a><br><br>

use "$path\data\SCII - Complete cases (Sept2008)", clear
recode SCIIA3 SCIIA3B (2/9=.)
recode SCIIA1 SCIIA2 SCIIA4 SCIIA5 SCIIB* SCIIC* SCIID* SCIIE* SCIIF* SCIIG* SCIIH* SCIII* SCIIJ* SCIIK* SCIIL* SCIIM1 (8 9=.)
foreach y of local x {
	htput <hr><h4> Variable Name: <a NAME="`y'"></a><span class="vname">`y'</span></h4>
	htput <h4> Variable Label: ``y''</h4>
	lab var `y' "`y'"
	htsummaryv `y', head freq format(%8.2f) missing rowtotal close
	quietly: ta `y'
	if r(r)>1 { 
		**histogram `y', freq xtitle("`y'") ytitle("Frequency, # of Responding Residents")
		graph pie, over(`y') $piecolor
		graph export "img\scii_des_`y'.png", replace
		htput <img src="img\scii_des_`y'.png">
	}
	htput <br><a href="#l`y'"><b>Back to List</b></a><br>
}
htput </body>
htclose
/*
capture htclose
insheet Variable Question using "D:\E_Risk\scii\scii_lables.txt", tab clear
split variable, gen(SC) p("II")
keep if SC1=="SC"
drop SC*
htopen using var_lab, replace
htput <link rel=stylesheet href="R2HTMLa.css" type=text/css>
htput <table cellspacing=0 border=1><tr><td>
htlist, noobs table(BORDER="0" CELLSPACING="2" CELLPADDING="4") align(left)
htput </td></tr></table>
htclose
*/

**********************scii_pror_des*****************************************************
cd "$path\html\scii"
insheet Variable Question using "$path\data\scii_lables.txt", tab clear
replace question=subinstr(question,char(147),"",.) // left double quote replaced by normal single quote char(39)
replace question=subinstr(question,char(148),"",.) // right double quote replaced by normal single quote char(39)
split variable, gen(SC) p("II")
keep if SC1=="SC"
drop SC*
forvalues v = 1/`=_N' /*or `: di _N'*/ {
	local `: di variable[`v']' `: di question[`v']'
}
macro dir

use "$path\data\SCIIfctrclpsdall_pror", clear
local lst1 s2contr s2cohe s2coef15 s2coef10 s2ndsrdr s2envprb s2nprob s2conect s2like s2padult s2fear s2victim s2safe

unab s2contr: SCIID*
unab s2cohe: SCIIE*
unab s2coef15: SCIID* SCIIE*
unab s2coef10: SCIID1-SCIID5 SCIIE1-SCIIE5
unab s2ndsrdr: SCIIC1-SCIIC7 SCIIC14-SCIIC17 SCIIC20-SCIIC22
unab s2envprb: SCIIC8-SCIIC10 SCIIC18 SCIIC19
unab s2nprob: SCIIC1-SCIIC10 SCIIC14-SCIIC22
unab s2conect: SCIIG*
unab s2like: SCIIH*
unab s2padult: SCIIF1 SCIIF2 SCIIF4
unab s2fear: SCIIF5-SCIIF7
unab s2victim: SCIIL*
unab s2safe: SCIIH4 SCIIJ*

local lst1_i
foreach cvar of local lst1 {
	local lst1_i `lst1_i' `cvar'_i
	local `cvar'_i
	foreach var of local `cvar' {
		local `cvar'_i ``cvar'_i' `var'_i
	}
}
macro dir


capture htclose
htopen using scii_pror_fa, replace
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>Neighborhood Survey II </h2><h3>Descriptive Analysis of Constructed Variables (Prorated) </h3>
htput <h4> For each constructed variable or scale, a pro-rated summed score was created for each resident if is less than half of the items in the scale is NOT missing. ///
	Then the summed score was aggregated across all residents of each neighborhood. </h4>
foreach cvar of local lst1 {
	htput <a NAME="`cvar'"></a><hr><b>`cvar':</b> ``cvar''
	htlog factor ``cvar''
	htput <br><a href="scii_pror_des.html#l`cvar'"><b>Back to List</b></a><br>
}
htput </body>
htclose
htopen using scii_imp_fa, replace
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>Neighborhood Survey II </h2><h3>Descriptive Analysis of Constructed Variables (Prorated) </h3>
htput <h4> For each constructed variable or scale, a pro-rated summed score was created for each resident if is less than half of the items in the scale is NOT missing. ///
	Then the summed score was aggregated across all residents of each neighborhood. </h4>
use "$path\data\SCIIfctrclpsdall_imp_i", clear
foreach cvar of local lst1_i {
	htput <a NAME="`cvar'"></a><hr><b>`cvar':</b> ``cvar''
	htlog factor ``cvar''
	htput <br><a href="scii_imp_des.html#l`cvar'"><b>Back to List</b></a><br>
}
htput </body>
htclose
use "$path\data\SCIIfctrclpsdall_pror", clear
	

capture htclose
htopen using scii_pror_des, replace
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>Neighborhood Survey II </h2><h3>Descriptive Analysis of Constructed Variables (Prorated) </h3>
htput <h4> For each constructed variable or scale, a pro-rated summed score was created for each resident if is less than half of the items in the scale is NOT missing. ///
	Then the summed score was aggregated across all residents of each neighborhood. </h4>
	
htput <table cellspacing=0 border=1><td><table border="0" cellpadding="4" cellspacing="2">
htput <tr class=firstline><td>Variable Names</td><td>Variable Labels</td><td>Factor Analysis</td><td>IntraClass Correlation</td></tr>
foreach x of local lst1 {
	htput <tr class=lightgreyback><td><a NAME="l`x'"></a><a href="#`x'"><b>`x'</b></a> </td><td> <b>`: di `"`: var label `x''"''</b> 
	htput (Constructed by Averaging the Following Variables)&nbsp;(<a href="scii_syntax_pror.html"><b>Syntax</b></a>)</td>
	htput <td><a href="scii_pror_fa.html#`x'">FA</a></td><td><a href="scii_pror_icc.html#`x'">ICC</a></td></tr>
	foreach y of local `x' {
		di "`y'"
		htput <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#`x'`y'">`y'</a> </td><td> ``y'' </td></tr>
	}
}
htput </table></td></table><br>
foreach x of local lst1 {
	htput <hr><h4> Variable Name: <a NAME="`x'"></a><span class="vname">`x'</span></h4>
	htput <h4> Variable Label: `: di `"`: var label `x''"''</h4>
	htsummaryv `x', head format(%8.2f) test close
	histogram `x', freq norm title("Histogram") xtitle("`x'") ytitle("Frequency, # of Families") $histocolor
	graph export "img\scii_`x'.png", replace
	htput <img src="img\scii_`x'.png">
	htput <br><a href="#l`x'"><b>Back to List</b></a><br>
	foreach y of local `x' {
		htput <hr><h4> Variable Name: <a NAME="`x'`y'"></a><span class="vname">`y'</span></h4>
		htput <h4> Variable Label: ``y''</h4>
		lab var `y' "`y'"
		htsummaryv `y', head format(%8.2f) test close
		histogram `y', freq norm title("Histogram") xtitle("`y'") ytitle("Frequency, # of Families") $histocolor
		graph export "img\scii_`y'.png", replace
		htput <img src="img\scii_`y'.png">
		htput <br><a href="#l`x'"><b>Back to List</b></a><br>
	}
}
htput </body>
htclose

**********************scii_imp_des*****************************************************
cd "$path\html\scii"

insheet Variable Question using "$path\data\scii_lables.txt", tab clear
replace question=subinstr(question,char(147),"",.) // left double quote replaced by normal single quote char(39)
replace question=subinstr(question,char(148),"",.) // right double quote replaced by normal single quote char(39)
split variable, gen(SC) p("II")
keep if SC1=="SC"
drop SC*
forvalues v = 1/`=_N' /*or `: di _N'*/ {
	local `: di variable[`v']'_i `: di question[`v']'
}
macro dir

capture htclose
htopen using scii_imp_des, replace
use "$path\data\SCIIfctrclpsdall_imp_i", clear


htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>Neighborhood Survey II </h2><h3>Descriptive Analysis of Constructed Variables (Imputed) </h3>
htput <h4> For each constructed variable or scale, a pro-rated summed score was created for each resident if is less than half of the items in the scale is NOT missing. ///
	Then the summed score was aggregated across all residents of each neighborhood. </h4>
	
htput <table cellspacing=0 border=1><td><table border="0" cellpadding="4" cellspacing="2">
htput <tr class=firstline><td>Variable Names</td><td>Variable Labels</td><td>Factor Analysis</td><td>IntraClass Correlation</td></tr>
foreach x of local lst1_i {
	htput <tr class=lightgreyback><td><a NAME="l`x'"></a><a href="#`x'"><b>`x'</b></a> </td><td> <b>`: di `"`: var label `x''"''</b> 
	htput (Constructed by Averaging the Following Variables)&nbsp;(<a href="scii_syntax_pror.html"><b>Syntax</b></a>)</td>
	htput <td><a href="scii_imp_fa.html#`x'">FA</a></td><td><a href="scii_imp_icc.html#`x'">ICC</a></td></tr>
	foreach y of local `x' {
		di "`y'"
		htput <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#`x'`y'">`y'</a> </td><td> ``y'' </td></tr>
	}
}
htput </table></td></table><br>
foreach x of local lst1_i {
	htput <hr><h4> Variable Name: <a NAME="`x'"></a><span class="vname">`x'</span></h4>
	htput <h4> Variable Label: `: di `"`: var label `x''"''</h4>
	htsummaryv `x', head format(%8.2f) test close
	histogram `x', freq norm title("Histogram") xtitle("`x'") ytitle("Frequency, # of Families") $histocolor
	graph export "img\scii_`x'.png", replace
	htput <img src="img\scii_`x'.png">
	htput <br><a href="#l`x'"><b>Back to List</b></a><br>
	foreach y of local `x' {
		htput <hr><h4> Variable Name: <a NAME="`x'`y'"></a><span class="vname">`y'</span></h4>
		htput <h4> Variable Label: ``y''</h4>
		lab var `y' "`y'"
		htsummaryv `y', head format(%8.2f) test close
		histogram `y', freq norm title("Histogram") xtitle("`y'") ytitle("Frequency, # of Families") $histocolor
		graph export "img\scii_`y'.png", replace
		htput <img src="img\scii_`y'.png">
		htput <br><a href="#l`x'"><b>Back to List</b></a><br>
	}
}
htput </body>
htclose


********************scii_imp_fa*******************************************************
cd "$path\html\scii"
capture htclose
htopen using scii_imp_fa, replace
use "$path\data\SCIIfctrclpsdall_imp", clear
local lst1 s2contr s2cohe s2coef s2coef10 s2ndsrdr s2envprb s2nprob s2conect s2like s2padult s2fear s2victim s2safe

unab s2contr: SCIID*
unab s2cohe: SCIIE*
unab s2coef: SCIID* SCIIE*
unab s2coef10: SCIID1-SCIID5 SCIIE1-SCIIE5
unab s2ndsrdr: SCIIC1-SCIIC7 SCIIC14-SCIIC17 SCIIC20-SCIIC22
unab s2envprb: SCIIC8-SCIIC10 SCIIC18 SCIIC19
unab s2nprob: SCIIC1-SCIIC10 SCIIC14-SCIIC22
unab s2conect: SCIIG*
unab s2like: SCIIH*
unab s2padult: SCIIF1 SCIIF2 SCIIF4
unab s2fear: SCIIF5-SCIIF7
unab s2victim: SCIIL*
unab s2safe: SCIIH4 SCIIJ*

htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <table cellspacing=0 border=1><tr><td><table border=0 class=dataframe>
htput <tr class=firstline><td>Variable Names</td><td>Variable Labels</td><td>Factor Analysis</td><td>IntraClass Correlation</td></tr>
foreach x of local lst1 {
	htput <tr class=lightgreyback><td><a href="#`x'"><b>`x'</b></a> </td><td> `: di `"`: var label `x''"'' </td>
	htput <td><a href="fa.html#`x'">FA</a></td><td><a href="icc.html#`x'">ICC</a></td></tr>
	foreach y of local `x' {
		di `y'
		htput <tr><td>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#`y'">`y'</a> </td><td> `: di `"`: var label `y''"'' </td></tr>
	}
}
htput </table></td></tr></table><br>
foreach x of local lst1 {
	htput <hr><h4> Variable Name: <a NAME="`x'"></a>`x' -- `: di `"`: var label `x''"''</h4>
	htput <h4> Table 1 </h4>
	htsummaryv `x', head format(%8.2f) test close
	*histogram `x', freq norm ytitle("Frequency, # of Families") $histocolor
	*graph export `x'.png, replace
	htput <h4> Histogram </h4>
	htput <img src="`x'.png">
	htput <br><a href="#top"><b>Back to Top</b></a><br>
	foreach y of local `x' {
		htput <hr><h4> Variable Name: <a NAME="`y'"></a>`y' -- `: di `"`: var label `y''"''</h4>
		htput <h4> Table 1 </h4>
		htsummaryv `y', head format(%8.2f) test close
		*histogram `y', freq norm ytitle("Frequency, # of Families") $histocolor
		*graph export `y'.png, replace
		htput <h4> Histogram </h4>
		htput <img src="`x'.png">
		htput <br><a href="#top"><b>Back to Top</b></a><br>
	}
}
htput </body>
htclose

*********************scii_imp_icc******************************************************
cd "$path\html\scii"
use "$path\data\SCIIfctrall_imp", clear
local lst1 s2contr s2cohe s2coef15 s2coef10 s2ndsrdr s2envprb s2nprob s2conect s2like s2padult s2fear s2victim s2safe
foreach x of local lst1 {
	loneway `x' familyid 
	gen icc_`x'=r(rho)
	gen icct_`x'=r(rho_t)
	*gen iccn_`x'=r(N)
}
gen iccn=r(N)
keep if _n==1
drop familyid s2*
reshape long icc_ icct_, i(iccn) j(Variable, string)
rename (icc_ icct_ iccn) (ICC Reliability N)
order Variable ICC Reliability N
format ICC Reliability %8.2f
save "$path\data\icc_imp", replace

capture htclose
htopen using scii_imp_icc, replace
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
use "$path\data\icc_imp", clear
local lst1 s2contr s2cohe s2coef s2coef10 s2ndsrdr s2envprb s2nprob s2conect s2like s2padult s2fear s2victim s2safe
/*
foreach x of local lst1 {
	 htlog list if variable=="`x'", nocompress noobs ab(15)
}
htlog list , nocompress noobs ab(15)
*/
htput <h2>Neighborhood Survey II </h2><h3>Intra-Class Correlation of Constructed Variables (Imputed) </h3>
htput <h4> For each constructed variable or scale, a pro-rated summed score was created for each resident if is less than half of the items in the scale is NOT missing. ///
	Then the summed score was aggregated across all residents of each neighborhood. </h4>
htput <table cellspacing=0 border=1><tr><td>
htlist, noobs table(BORDER="0" CELLSPACING="2" CELLPADDING="4") align(left)
htput </td></tr></table>
htput </body>
htclose

*********************scii_pror_icc******************************************************
cd "$path\html\scii"
use "$path\data\SCIIfctrall_pror", clear
local lst1 s2contr s2cohe s2coef15 s2coef10 s2ndsrdr s2envprb s2nprob s2conect s2like s2padult s2fear s2victim s2safe
foreach x of local lst1 {
	loneway `x' familyid 
	gen icc_`x'=r(rho)
	gen icct_`x'=r(rho_t)
	gen iccn_`x'=r(N)
}
*gen iccn=r(N)
keep if _n==1
drop familyid s2*
gen id=_n
reshape long icc_ icct_ iccn_, i(id) j(Variable, string)
rename (icc_ icct_ iccn) (ICC Reliability N)
order Variable ICC Reliability N
format ICC Reliability %8.2f
drop id
save "$path\data\icc_pror", replace

capture htclose
htopen using scii_pror_icc, replace
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
use "$path\data\icc_pror", clear
local lst1 s2contr s2cohe s2coef s2coef10 s2ndsrdr s2envprb s2nprob s2conect s2like s2padult s2fear s2victim s2safe
/*
foreach x of local lst1 {
	 htlog list if variable=="`x'", nocompress noobs ab(15)
}
htlog list , nocompress noobs ab(15)
*/
htput <h2>Neighborhood Survey II </h2><h3>Intra-Class Correlation of Constructed Variables (Prorated) </h3>
htput <h4> For each constructed variable or scale, a pro-rated summed score was created for each resident if is less than half of the items in the scale is NOT missing. ///
	Then the summed score was aggregated across all residents of each neighborhood. </h4>
htput <table cellspacing=0 border=1><tr><td>
htlist, noobs table(BORDER="0" CELLSPACING="2" CELLPADDING="4") align(left)
htput </td></tr></table>
htput </body>
htclose

*********************scii_syntax******************************************************
cd "$path\html\scii"
capture htclose
htopen using scii_syntax_pror, replace
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <h2>Neighborhood Survey II </h2><h3>Syntax to Construct Variables (Prorated) </h3>
htput <h4> For each constructed variable or scale, a pro-rated summed score was created for each resident if is less than half of the items in the scale is NOT missing. ///
	Then the summed score was aggregated across all residents of each neighborhood. </h4>
	
htput <hr><b>Reverse Coding of Variables</b> <br><br>
htput replace SCIIE7=4-SCIIE7 <br>
htput recode SCIIJ1 SCIIJ2 (2=0) (0=2) <br><br><hr>

htput <b>Standardization of Variables</b> <br><br>
htput egen zSCIIH4=std(SCIIH4)<br>
htput egen zSCIIJ1=std(SCIIJ1)<br>
htput egen zSCIIJ2=std(SCIIJ2)<br>
htput egen zSCIIJ3=std(SCIIJ3)<br><br><hr>

htput <b> Syntax for Proportion of Items Missing for Each Scale </b><br><br> 
htput egen s2contr_nm=rownonmiss(SCIID*) <br>
htput egen s2cohe_nm=rownonmiss(SCIIE*) <br>
htput egen s2coef_nm=rownonmiss(SCIID* SCIIE*) <br>
htput egen s2coef10_nm=rownonmiss(SCIID1-SCIID5 SCIIE1-SCIIE5) <br>
htput egen s2ndsrdr_nm=rownonmiss(SCIIC1-SCIIC7 SCIIC14-SCIIC17 SCIIC20-SCIIC22) <br>
htput egen s2envprb_nm=rownonmiss(SCIIC8-SCIIC10 SCIIC18 SCIIC19) <br>
htput egen s2nprob_nm=rownonmiss(SCIIC1-SCIIC10 SCIIC14-SCIIC22) <br>
htput egen s2conect_nm=rownonmiss(SCIIG*) <br>
htput egen s2like_nm=rownonmiss(SCIIH*) <br>
htput egen s2padult_nm=rownonmiss(SCIIF1 SCIIF2 SCIIF4) <br>
htput egen s2fear_nm=rownonmiss(SCIIF5-SCIIF7) <br>
htput egen s2victim_nm=rownonmiss(SCIIL*) <br>
htput egen s2safe_nm=rownonmiss(zSCIIH4 zSCIIJ*) <br> <br>

htput egen s2contr_m=rowmiss(SCIID*) <br>
htput egen s2cohe_m=rowmiss(SCIIE*) <br>
htput egen s2coef_m=rowmiss(SCIID* SCIIE*) <br>
htput egen s2coef10_m=rowmiss(SCIID1-SCIID5 SCIIE1-SCIIE5) <br>
htput egen s2ndsrdr_m=rowmiss(SCIIC1-SCIIC7 SCIIC14-SCIIC17 SCIIC20-SCIIC22) <br>
htput egen s2envprb_m=rowmiss(SCIIC8-SCIIC10 SCIIC18 SCIIC19) <br>
htput egen s2nprob_m=rowmiss(SCIIC1-SCIIC10 SCIIC14-SCIIC22) <br>
htput egen s2conect_m=rowmiss(SCIIG*) <br>
htput egen s2like_m=rowmiss(SCIIH*) <br>
htput egen s2padult_m=rowmiss(SCIIF1 SCIIF2 SCIIF4) <br>
htput egen s2fear_m=rowmiss(SCIIF5-SCIIF7) <br>
htput egen s2victim_m=rowmiss(SCIIL*) <br>
htput egen s2safe_m=rowmiss(zSCIIH4 zSCIIJ*) <br> <br>

htput foreach x in s2contr s2cohe s2coef s2coef10 s2ndsrdr s2envprb s2nprob s2conect s2like s2padult s2fear s2victim s2safe { <br>
htput 	gen `x'_mr=`x'_m/(`x'_m+`x'_nm) <br>
htput } <br> <br>

htput <b>Syntax for Measurement Scales</b>  <br><br>
htput egen s2contr=rowmean(SCIID*) if s2contr_mr<.5 <br>
htput egen s2cohe=rowmean(SCIIE*) if s2cohe_mr<.5 <br>
htput egen s2coef=rowmean(SCIID* SCIIE*) if s2coef_mr<.5 <br>
htput egen s2coef10=rowmean(SCIID1-SCIID5 SCIIE1-SCIIE5) if s2coef10_mr<.5 <br>
htput egen s2ndsrdr=rowmean(SCIIC1-SCIIC7 SCIIC14-SCIIC17 SCIIC20-SCIIC22) if s2ndsrdr_mr<.5 <br>
htput egen s2envprb=rowmean(SCIIC8-SCIIC10 SCIIC18 SCIIC19) if s2envprb_mr<.5 <br>
htput egen s2nprob=rowmean(SCIIC1-SCIIC10 SCIIC14-SCIIC22) if s2nprob_mr<.5 <br>
htput egen s2conect=rowmean(SCIIG*) if s2conect_mr<.5 <br>
htput egen s2like=rowmean(SCIIH*) if s2like_mr<.5 <br>
htput egen s2padult=rowmean(SCIIF1 SCIIF2 SCIIF4) if s2padult_mr<.5 <br>
htput egen s2fear=rowmean(SCIIF5-SCIIF7) if s2fear_mr<.5 <br>
htput egen s2victim=rowmean(SCIIL*) if s2victim_mr<.5 <br>
htput egen s2safe=rowmean(zSCIIH4 zSCIIJ*) if s2safe_mr<.5 <br><br><hr>

htput <b>Syntax for Averaging Measurement Scales Across Different Respondents from the Same E-Risk Family</b>  <br><br>
htput collapse SC* s2*, by(familyid)
htput </body>
htclose

********************scii_pror_nm*******************************************************
/*
cd "$path\html\scii"
capture htclose
htopen using scii_pror_nm, replace
use "$path\data\SCIIfctrclpsdall_pror", clear
local lst1 s2contr s2cohe s2coef s2coef10 s2ndsrdr s2envprb s2nprob s2conect s2like s2padult s2fear s2victim s2safe
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <h2>Neighborhood Survey II </h2><h3>Missing Rate of Constructed Variables </h3>
htput <h4> For each constructed variable or scale, a pro-rated summed score was created for each resident if is less than half of the items in the scale is NOT missing. ///
	Then the summed score was aggregated across all residents of each neighborhood. </h4>
	
htput <table cellspacing=0 border=1><td><table border="0" cellpadding="4" cellspacing="2">
htput <tr class=firstline><td>Constructed Variable Names</td><td>Variable Labels</td></tr>
foreach y of local lst1 {
	*di "`y'"
	htput <tr><td><a NAME="l`y'"></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#`y'">`y'</a> </td><td>`: di `"`: var label `y''"''</td></tr>
}
htput </table></td></table><br>
htput Note: <br>
htput 1, For each constructed variable or scale, a pro-rated summed score was created for each resident if is less than half of the items in the scale is NOT missing. <br>
htput 2, Missing rate for each scale is defined as the number of residents with missing items values in the corresponding scale divided by the total number residents for each E-Risk family. <br>
*htlog sum *_nm
htput <hr><h4> # of the Residental Neighbors Responded Per E-Risk Families </h4>
htsummaryv n, head format(%8.2f) test close
htput <br>
htsummaryv n, head freq format(%8.2f) missing rowtotal close
*histogram n, freq norm xtitle("# of Residents") ytitle("# of E-Risk Families") $histocolor
*graph export "img\scii_pror_n.png", replace
htput <img src="img\scii_pror_n.png"><br>
htput <br><a href="#l`y'"><b>Back to List</b></a><br><br>
	
foreach y of local lst1 {
	htput <hr><h4> Constructed Variable: <a NAME="`y'"></a><span class="vname">`y'</span></h4>
	htput <h4> Variable Label: `: di `"`: var label `y''"''</h4>
	htsummaryv `y'_mra, head format(%8.2f) test close
	**egen `y'_nmmax=max(`y'_nm)
	**histogram `y'_nm if `y'_nm~=`y'_nmmax, freq xtitle("`y', # of Non-missing Items") ytitle("# of Families")
	replace `y'_mra=`y'_mra*100
	histogram `y'_mra , freq xtitle("% Residents Missing") ytitle("# of E-Risk Families") $histocolor
	graph export "img\scii_pror_mra_`y'.png", replace
	htput <img src="img\scii_pror_mra_`y'.png"><br>
	histogram n_`y', freq norm xtitle("# of Residents") ytitle("# of E-Risk Families") $histocolor
	graph export "img\scii_pror_n_`y'.png", replace
	htput <img src="img\scii_pror_n_`y'.png"><br>
	**htput <b>Note</b>: Only Families <b>WITH</b> Missing Items Are Shown.<br>
	htput <br><a href="#l`y'"><b>Back to List</b></a><br><br>
}
htput </body>
htclose
*/
/*
************************menu***************************************************
cd "D:\E_Risk\SCII"
capture htclose
htopen using menu, replace
htput <link rel=stylesheet href="R2HTMLa.css" type=text/css>
htput <table cellspacing=0 border=1><td><table border="0" cellpadding="4" cellspacing="2"><tr class=firstline><td>Community Strengths</td></tr>
htput <tr class=lightgreyback><td><b>Resident Surveys II</b></td><tr>
htput <tr><td><a href="SCOPICbookletp12.pdf" target=main>Booklet</a></td></tr>
htput <tr><td><a href="scii_des.html" target=main>All Original Variables</a></td></tr>
htput <tr><td><a href="scii_pror_des.html" target=main>Constructed Variables - Pro-rated</a></td></tr>
htput <tr><td><a href="scii_imp_des.html" target=main>Constructed Variables - Imputed</a></td></tr>
htput <tr class=lightgreyback><td><b>Crime Data</b></td><tr>
htput <tr><td><a href="crime_des.html" target=main>Crime Rate 2011 - Pro-rated</a></td></tr>
htput </table></td></table>
htclose
*/

********************e_risk_merge_wide*******************************************************
cd "$path\html\data"
capture htclose
htopen using merged_des, replace
use "$path\data\e_risk_merged_wide.dta", clear
unab allvar: *
local idvars familyid atwinid
local lst1: list allvar - idvars
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput <h2>Urban vs. Rural </h2><h3>Descriptive Analysis of Neighborhood Type Variables </h3>
htput <h4> Neighborhood Type variables. </h4>
htput <table cellspacing=0 border=1><tr><td><table border=0 cellpadding="4" cellspacing="2"><tr class= firstline><td>Variable Names</td><td>Variable Labels</td></tr>
foreach x of local lst1 {
	htput <tr><td><a href="#`x'"><b>`x'</b></a> </td><td> `: di `"`: var label `x''"'' </td><tr>
}
htput </table></td></tr></table><br>
foreach x of local lst1 {
	htput <hr><h4> Variable Name: <a NAME="`x'"></a><span class="vname">`x'</span><br>
	htput Variable Label: `: di `"`: var label `x''"''</h4>
	local l: val lab `x'
	local len: length local l
	quietly: ta `x'
	local nr=r(r)
	if `len'==0 | `nr'>10 {
		htsummaryv `x', head format(%8.2f) test close
		histogram `x', freq norm title("Histogram") ytitle("Frequency, # of Families") $histocolor
	}
	else {
		htsummaryv `x', head freq format(%8.2f) missing rowtotal close
		graph pie, over(`x') $piecolor
	}
	graph export "img/`x'.png", replace
	htput <img src="img/`x'.png">
	htput <br><a href="#top"><b>Back to Top</b></a><br>
}
htput </body>
htclose	
