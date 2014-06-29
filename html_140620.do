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

do "D:\E_Risk\data_acrchive\html\syntax\page_headers.do"
macro dir
***************************************************************************
cd "$path\html\env"
capture htclose
htopen using ntype_des, replace
use "$path\data\N_type WIDE (Nov17).dta", clear
unab allvar: *
local idvars familyid atwinid btwinid SCIIurban neigh_type2
local lst1: list allvar - idvars
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput $ntype_header
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
htput $greenspace_header
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
htput $inequality_header
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
htput $sso_header
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
		**graph pie, over(`x') $piecolor
		*piev `x'
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
htput $acorn_header
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

	*graph pie, over(`x') $piecolor
	*graph export "img/`x'.png", replace
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
htput $crime_header
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
htput $sci_header
htput <table cellspacing=0 border=1><tr><td><table border=0 cellpadding="4" cellspacing="2"><tr class= firstline><td>Variable Names</td><td>Variable Labels</td></tr>
foreach x of local lst1 {
	htput <tr><td><a href="#`x'"><b>`x'</b></a> </td><td> `: var label `x'' </td><tr>
}
htput </table></td></tr></table><br>
foreach x of local lst1 {
	htput <hr><h4> Variable Name: <a NAME="`x'"></a><span class="vname">`x'</span><br>
	htput Variable Label: `: var label `x''</h4>
	labellist `x'
	local k=r(`x'_k)
	local lblname `r(lblname)'
	local lblnamelen: length local lblname
	quietly: ta `x'
	if r(r)<8 & r(r)>1 & `k'>1 & `lblnamelen'>0 {
		htsummaryv `x', head freq format(%8.2f) missing rowtotal close
		graph pie, over(`x') $piecolor
		graph export "img/`x'.png", replace
		htput <img src="img/`x'.png">
	}
	else if r(r)==1 {
		htsummaryv `x', head freq format(%8.2f) missing rowtotal close
	}
	else {
		htsummaryv `x', head format(%8.2f) test close
		histogram `x', freq norm title("Histogram") ytitle("Frequency, # of Families") $histocolor
		graph export "img/`x'.png", replace
		htput <img src="img/`x'.png">
	}
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
htput $sci_pror_header
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

********************e_risk_merge_wide*******************************************************
cd "$path\html\data"
capture htclose
htopen using share_des, replace
use "$path\data\e_risk_merged_wide.dta", clear
unab allvar: *
local idvars familyid atwinid
local lst1: list allvar - idvars
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput $share_header
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
