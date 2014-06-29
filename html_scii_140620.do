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
htput $scii_header
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
recode SCIID6 (6=.)
recode SCIIC8 (3=.)
recode SCIIA3 SCIIA3B (2/9=.)
recode SCIIA1 SCIIA2 SCIIA4 SCIIA5 SCIIB* SCIIC* SCIID* SCIIE* SCIIF* SCIIG* SCIIH* SCIII* SCIIJ* SCIIK* SCIIL* SCIIM1 (8 9=.)
foreach y of local x {
	htput <hr><h4> Variable Name: <a NAME="`y'"></a><span class="vname">`y'</span></h4>
	htput <h4> Variable Label: ``y''</h4>
	
	labellist `y'
	local labels `r(labels)'
	local lblname `r(lblname)'
	local string2 : subinstr local labels "Not a problem'" "Not a problem", all count(local n)
	if `n'>0 lab def `lblname' 0 "Not a problem", modify
	
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
htput $scii_pror_fa_header
foreach cvar of local lst1 {
	htput <a NAME="`cvar'"></a><hr>
	htput <b>Scale:</b> <span class="vname">`cvar'</span><br>
	htput <b>Items:</b> ``cvar''<br>
	htput <b>Stata Command:</b> factor ``cvar''<br>
	htlog factor ``cvar''
	htput <br><a href="scii_pror_des.html#l`cvar'"><b>Back to List</b></a><br>
}
htput </body>
htclose
htopen using scii_imp_fa, replace
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput $scii_imp_fa_header
use "$path\data\SCIIfctrclpsdall_imp_i", clear
foreach cvar of local lst1_i {
	htput <a NAME="`cvar'"></a><hr>
	htput <b>Scale:</b> <span class="vname">`cvar'</span><br>
	htput <b>Items:</b> ``cvar''<br>
	htput <b>Stata Command:</b> factor ``cvar''<br>
	htlog factor ``cvar''
	htput <br><a href="scii_imp_des.html#l`cvar'"><b>Back to List</b></a><br>
}
htput </body>
htclose
*********************scii_imp_icc******************************************************
use "$path\data\SCIIfctrall_imp_i", clear
foreach cvar of local lst1_i {
	loneway `cvar' familyid 
	gen icc_`cvar'=r(rho)
	gen icct_`cvar'=r(rho_t)
	alpha ``cvar'' if `cvar'~=.
	gen alpha_`cvar'=r(alpha)
}
gen iccn=_N
keep if _n==1
keep icc_* alpha_* iccn icct_*
reshape long icc_ icct_ alpha_, i(iccn) j(Variable, string)
rename (icc_ icct_ alpha_ iccn) (ICC Reliability Alpha N)
order Variable ICC Reliability Alpha N
format ICC Reliability Alpha %8.2f
save "$path\data\icc_imp", replace

capture htclose
htopen using scii_imp_icc, replace
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
use "$path\data\icc_imp", clear
htput $scii_imp_icc_header
htput <table cellspacing=0 border=1><tr><td>
htlist, noobs table(BORDER="0" CELLSPACING="2" CELLPADDING="4") align(left)
htput </td></tr></table>
htput </body>
htclose

*********************scii_pror_icc******************************************************
use "$path\data\SCIIfctrall_pror", clear
foreach cvar of local lst1 {
	loneway `cvar' familyid 
	gen icc_`cvar'=r(rho)
	gen icct_`cvar'=r(rho_t)
	gen iccn_`cvar'=r(N)
	alpha ``cvar'' if `cvar'~=.
	gen alpha_`cvar'=r(alpha)
}
keep if _n==1
keep icc_* iccn_* alpha_* icct_*
gen id=_n
reshape long icc_ icct_ iccn_ alpha_, i(id) j(Variable, string)
rename (icc_ icct_ alpha_ iccn) (ICC Reliability Alpha N)
order Variable ICC Reliability Alpha N
format ICC Reliability Alpha %8.2f
drop id
save "$path\data\icc_pror", replace

capture htclose
htopen using scii_pror_icc, replace
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
use "$path\data\icc_pror", clear
htput $scii_pror_icc_header
htput <table cellspacing=0 border=1><tr><td>
htlist, noobs table(BORDER="0" CELLSPACING="2" CELLPADDING="4") align(left)
htput </td></tr></table>
htput </body>
htclose
use "$path\data\SCIIfctrclpsdall_pror", clear
	

capture htclose
htopen using scii_pror_des, replace
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput <a NAME="top"></a>
htput $scii_pror_header
	
htput <table cellspacing=0 border=1><td><table border="0" cellpadding="4" cellspacing="2">
htput <tr class=firstline><td>Variable Names</td><td>Variable Labels</td><td>Factor Analysis</td><td>ICC/Reliability/Alpha</td></tr>
foreach x of local lst1 {
	htput <tr class=lightgreyback><td><a NAME="l`x'"></a><a href="#`x'"><b>`x'</b></a> </td><td> <b>`: di `"`: var label `x''"''</b> 
	htput (Constructed by Averaging the Following Variables)&nbsp;(<a href="scii_syntax_pror.html"><b>Syntax</b></a>)</td>
	htput <td><a href="scii_pror_fa.html#`x'">Factor Analysis</a></td><td><a href="scii_pror_icc.html#`x'">ICC/Reliability/Alpha</a></td></tr>
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
	*histogram `x', freq norm title("Histogram") xtitle("`x'") ytitle("Frequency, # of Families") $histocolor
	*graph export "img\scii_`x'.png", replace
	htput <img src="img\scii_`x'.png">
	htput <br><a href="#l`x'"><b>Back to List</b></a><br>
	foreach y of local `x' {
		htput <hr><h4> Variable Name: <a NAME="`x'`y'"></a><span class="vname">`y'</span></h4>
		htput <h4> Variable Label: ``y''</h4>
		lab var `y' "`y'"
		htsummaryv `y', head format(%8.2f) test close
		*histogram `y', freq norm title("Histogram") xtitle("`y'") ytitle("Frequency, # of Families") $histocolor
		*graph export "img\scii_`y'.png", replace
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
htput $scii_imp_header
	
htput <table cellspacing=0 border=1><td><table border="0" cellpadding="4" cellspacing="2">
htput <tr class=firstline><td>Variable Names</td><td>Variable Labels</td><td>Factor Analysis</td><td>ICC/Reliability/Alpha</td></tr>
foreach x of local lst1_i {
	htput <tr class=lightgreyback><td><a NAME="l`x'"></a><a href="#`x'"><b>`x'</b></a> </td><td> <b>`: di `"`: var label `x''"''</b> 
	htput (Constructed by Averaging the Following Variables)&nbsp;(<a href="scii_syntax_pror.html"><b>Syntax</b></a>)</td>
	htput <td><a href="scii_imp_fa.html#`x'">Factor Analysis</a></td><td><a href="scii_imp_icc.html#`x'">ICC/Reliability/Alpha</a></td></tr>
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
	*histogram `x', freq norm title("Histogram") xtitle("`x'") ytitle("Frequency, # of Families") $histocolor
	*graph export "img\scii_`x'.png", replace
	htput <img src="img\scii_`x'.png">
	htput <br><a href="#l`x'"><b>Back to List</b></a><br>
	foreach y of local `x' {
		htput <hr><h4> Variable Name: <a NAME="`x'`y'"></a><span class="vname">`y'</span></h4>
		htput <h4> Variable Label: ``y''</h4>
		lab var `y' "`y'"
		htsummaryv `y', head format(%8.2f) test close
		*histogram `y', freq norm title("Histogram") xtitle("`y'") ytitle("Frequency, # of Families") $histocolor
		*graph export "img\scii_`y'.png", replace
		htput <img src="img\scii_`y'.png">
		htput <br><a href="#l`x'"><b>Back to List</b></a><br>
	}
}
htput </body>
htclose

*********************scii_syntax******************************************************
cd "$path\html\scii"
capture htclose
htopen using scii_syntax_pror, replace
htput <link rel=stylesheet href="..\R2HTMLa.css" type=text/css>
htput <body style="margin-top: 0; margin-bottom: 5px">
htput $scii_syntax_header
	
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
