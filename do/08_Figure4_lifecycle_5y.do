
/*
	Project: Pareto Gender
	File: 08_Figure4_lifecycle_5y
	Last edited: by Hans, Sep 12, 2020
*/
	
		
// Load settings
do "D:\Data\workdata\704784\xdrev\704784\pareto_gender\do\settings.do"
// Load panel
use "$tf\analysisdata.dta",clear

* keep cohorts
gen birthyear=year-v_age
keep if birthyear<1971 & birthyear>1939

/* keep v_age groups */
*keep if v_age>29 & v_age<66 //Restriction no in graphs instead
gen v_agebin=floor(v_age/3)*3+1
replace year = v_agebin

* ranking
sort year v_female birthyear  v_income_5y
by year v_female birthyear : gen gender_ranking = (_N - _n)

*Create cdf for income, for each year-sex.
cap drop cdf_log_income
by year v_female birthyear : cumul v_log_income5, gen(cdf_log_income)

/*log CCDF*/
cap drop log_ccdf_log_income
cap drop ccdf_log_income
gen ccdf_log_income = 1-cdf_log_income 
gen log_ccdf_log_income = log10(ccdf_log_income)
sort log_ccdf_log_income


/* Estimate pareto coefficients, gap and ceiling. */
mle_pareto,bys( birthyear) income(v_log_income5) pareto_cutoff(0.1) savecoef("$of\coefficients_cohorts_5year.dta")


* Create plots

use "$of\coefficients_cohorts_5year.dta",clear
gen v_age=year
keep if v_age>29 &  v_age<60
* plot ceiling
tw (connected gamma v_age if  birthyear==1940   , msymbol(Sh) mcolor(black) lcolor(black) ) ///
   (connected gamma v_age if  birthyear==1945   , msymbol(X) msize(large) mcolor(gs12) lcolor(gs12)) ///
   (connected gamma v_age if  birthyear==1950   , msymbol(Oh) mcolor(gs10) lcolor(gs10)) ///
   (connected gamma v_age if  birthyear==1955   , msymbol(T) mcolor(gs8) lcolor(gs8)) ///
   (connected gamma v_age if  birthyear==1960   , msymbol(Th) mcolor(gs6) lcolor(gs6)) ///
   (connected gamma v_age if  birthyear==1965   , msymbol(S)  mcolor(gs4) lcolor(gs4)) ///
	, xlabel(30(5)60,noticks) ylabel(,noticks) xtitle("Age") ytitle("Glass ceiling coefficient") $graphsettings ///
	legend(order(7 "Birth year" 1 "1940" 2 "1945" 3 "1950" 7 "" 4 "1955" 5 "1960" 6 "1965") rows(2) region(lcolor(white)) pos(12) ring(1)) ///
	ylab(0.0(0.1)0.8,format(%4.2f) angle(horizontal))
	graph export "$of\ceiling_by_cohort_5year.png",replace width(2000)
	

* plot gap with ln
tw (connected gap_ln v_age if  birthyear==1940   , msymbol(Sh) mcolor(black) lcolor(black) ) ///
   (connected gap_ln v_age if  birthyear==1945   , msymbol(X) msize(large) mcolor(gs12) lcolor(gs12)) ///
   (connected gap_ln v_age if  birthyear==1950   , msymbol(Oh) mcolor(gs10) lcolor(gs10)) ///
   (connected gap_ln v_age if  birthyear==1955   , msymbol(T) mcolor(gs8) lcolor(gs8)) ///
   (connected gap_ln v_age if  birthyear==1960   , msymbol(Th) mcolor(gs6) lcolor(gs6)) ///
   (connected gap_ln v_age if  birthyear==1965   , msymbol(S)  mcolor(gs4) lcolor(gs4)) ///
	, xlabel(30(5)60,noticks) ylabel(,noticks) xtitle("Age") ytitle("Top earnings gender gap (ln)") $graphsettings ///
	legend(order(7 "Birth year" 1 "1940" 2 "1945" 3 "1950" 7 "" 4 "1955" 5 "1960" 6 "1965") rows(2) region(lcolor(white)) pos(12) ring(1)) ///
	ylab(0.25(0.05)0.5,format(%4.2f) angle(horizontal))
	graph export "$of\gender_gap_by_cohort_ln_5year.png",replace width(2000)
