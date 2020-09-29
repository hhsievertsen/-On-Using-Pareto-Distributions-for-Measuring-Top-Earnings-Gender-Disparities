
/*
	Project: Pareto Gender
	File: 06_Figure3_aggregate_1y
	Last edited: by Hans, Sep 12, 2020
*/
	
// Load settings
do "D:\Data\workdata\704784\xdrev\704784\pareto_gender\do\settings.do"
// Load panel
use "$tf\analysisdata.dta",clear
* ranking
sort year v_female v_income1
cap drop gender_ranking
by year v_female: gen gender_ranking = (_N - _n)

*Create cdf for income, for each year-sex.
cap drop cdf_log_income
by year v_female: cumul v_log_income1, gen(cdf_log_income)

/*log CCDF*/
gen ccdf_log_income = 1-cdf_log_income 
gen log_ccdf_log_income = log10(ccdf_log_income)
sort log_ccdf_log_income


/* Estimate pareto coefficients, gap and ceiling. */
mle_pareto, income(v_log_income1) pareto_cutoff(0.1) savecoef("$of\coefficients_full_sample.dta")

/* Create plots of estimated coefficients, gap and ceiling. */
preserve
	use "$of\coefficients_full_sample.dta",replace
		*plot ceiling			
		tw (line gamma year, lcolor(black) lwidth(thick) ) ///
			, xlabel(1980(5)2010,noticks  format(%4.0f) angle(horizontal)) ylabel(0(0.2)1,noticks angle(horizontal) format(%4.1f)) xtitle("") ytitle("Glass ceiling coefficient") $graphsettings 
			graph export "$of\glass_ceiling_time_series_1year.png", replace width(2000)
		*plot gap
	tw (line gap_ln year, lcolor(black) lwidth(thick) ) ///
		, xlabel(1980(5)2010,noticks format(%4.0f) angle(horizontal)) ylabel(0(0.1).5,noticks angle(horizontal) format(%4.1f)) xtitle("") ytitle("Top earnings gender gap (ln)") $graphsettings 
		graph export "$of\gender_gap_time_series_ln_1year.png", replace width(2000)
restore
		