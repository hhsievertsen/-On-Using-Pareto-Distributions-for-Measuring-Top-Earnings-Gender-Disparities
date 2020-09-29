
/*
	Project: Pareto Gender
	File: 05_Figure2_loglogplot
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

keep if year==2009

gen binned_rank=floor(gender_ranking/5)*5+2.5

collapse (mean)v_log_income1 log_ccdf_log_income v_income1 ccdf, by(binned_rank  v_female) fast


// Overall
twoway ///
(line log_ccdf_log_income v_log_income1 if  v_income1 >10000 & binned_rank >= 100 & v_female == 0, lwidth(thick) lcolor(black)) ///
(line log_ccdf_log_income v_log_income1 if  v_income1>10000 & binned_rank >= 100 & v_female == 1, lwidth(thick) lcolor(gs9)) ///
,legend(order(2 "Women" 1 "Men") region(lcolor(white)))  $graphsettings  ytitle("Log CCDF") xtitle("Log Income") xlabel(,noticks) ylabel(,noticks) ///
ylab(,format(%4.1f) angle(horizontal)) legend(pos(2) ring(0) rows(2)) xscale(noline)
graph export "$of\income_dist_log_ccdf_2009.png", replace width(2000)



/*log CCDF truncated at top pareto cutoff (0.1)*/
twoway ///
(line log_ccdf_log_income v_log_income1 if  ccdf <= 0.1 & v_income1 >10000 & binned_rank >= 100 & v_female == 0, lwidth(thick) lcolor(black)) ///
(line log_ccdf_log_income v_log_income1 if  ccdf <=0.1 & v_income1 >10000 & binned_rank >= 100 & v_female == 1, lwidth(thick) lcolor(gs9)) ///
 ,legend(order(2 "Women" 1 "Men") region(lcolor(white)))   $graphsettings  ytitle("Log CCDF") xtitle("Log Income") xlabel(,noticks) ylabel(,noticks) ///
ylab(,format(%4.1f) angle(horizontal)) legend(pos(2) ring(0) rows(2)) xscale(noline)
graph export "$of\income_dist_log_ccdf_2009_top10.png", replace width(2000)


