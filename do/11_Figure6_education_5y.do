/*
by Erik Öberg, July 3 2018
*/

// Load settings
do "D:\Data\workdata\704784\xdrev\704784\pareto_gender\do\settings.do"
// Load panel
use "$tf\analysisdata.dta",clear

*ranking
sort year v_female v_educ_group v_income_5y
by year v_female v_educ_group: gen gender_ranking = (_N - _n)

*Create cdf for income, for each year-education_level-education_field.
cap drop cdf_log_income
by year v_female v_educ_group: cumul v_log_income5, gen(cdf_log_income)

/*log CCDF*/
cap drop ccdf_log_income
cap drop log_ccdf_log_income
gen ccdf_log_income = 1-cdf_log_income
gen log_ccdf_log_income = log10(ccdf_log_income)
sort log_ccdf_log_income

/* Estimate pareto coefficients, gap and ceiling. */
mle_pareto,bys(v_educ_group) income(v_log_income5) pareto_cutoff(0.1) savecoef("$of\coefficients_education5.dta")
	

use "$of\coefficients_education5.dta",clear	
*Plot Log CCDF by sex and educatioal field for each year separately
tw 	(connected gamma year if v_educ_group == "Medicine" & gamma<=1, msymbol(Th) mcolor(gs6) lcolor(gs6) ) ///
	(connected gamma year if v_educ_group == "Business" & gamma<=1, msymbol(S) mcolor(gs4) lcolor(gs4) ) ///
	(connected gamma year if v_educ_group == "STEM" & gamma<=1, msymbol(Sh) mcolor(gs10) lcolor(gs10) ) ///
	(connected gamma year if v_educ_group == "Law" & gamma<=1, msymbol(X) msize(large) mcolor(gs8) lcolor(gs8) ) ///
	, xlabel(1980(5)2010,noticks) ylabel(0(0.2)1,noticks) xtitle("") ytitle("Glass ceiling coeffcient") $graphsettings ///
	yscale(r(0 1)) legend(order( 3 "STEM"   4 "Law" 1 "Medicine" 2 "Business") region(lcolor(white)) rows(1) pos(12) ring(1)) ///
	ylab(0.(0.2)1,format(%4.2f) angle(horizontal))
graph export "$of\ceiling_education_5year.png",replace width(2000)


tw (connected gap_ln year if v_educ_group == "Medicine"  , msymbol(Th) mcolor(gs6) lcolor(gs6) ) ///
	(connected gap_ln year if v_educ_group == "Business"  , msymbol(S) mcolor(gs4) lcolor(gs4) ) ///
	(connected gap_ln year if v_educ_group == "STEM"  , msymbol(Sh) mcolor(gs10) lcolor(gs10) ) ///
	(connected gap_ln year if v_educ_group == "Law" , msymbol(X) msize(large) mcolor(gs8) lcolor(gs8) ) ///
	, xlabel(1980(5)2010,noticks) ylabel(0(0.1).55,noticks) xtitle("") ytitle("Top earnings gender gap (ln)") $graphsettings ///
	legend(order( 3 "STEM"   4 "Law" 1 "Medicine" 2 "Business") region(lcolor(white)) rows(1) pos(12) ring(1)) ///
	ylab(0(0.1)0.6,format(%4.2f) angle(horizontal))
	
graph export "$of\gap_education_ln_5year.png",replace width(2000)
