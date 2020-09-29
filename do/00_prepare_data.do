/*
	Project: Pareto Gender
	File: 00_Prepare_Data
	Last edited: by Hans, Sep 12, 2020
*/

// Load settings
do "D:\Data\workdata\704784\xdrev\704784\pareto_gender\do\settings.do"
// Loop over all years
 forval year=1980/2013{
	// load files
	 use "$rf\pop2_grund`year'.dta", clear
	 if `year'>2006{
		rename FOED_DAG foed_dag
	}
	if `year'>2012{
		gen int HELTID_DELTID_KODE=.
	}
	
	// Keep variables
	keep foed_dag HELTID_DELTID hfaudd  loenmv koen pnr 
	// Part time
	rename HELTID_DELTID_KODE v_parttime_code
	 // Income concept
	 rename  loenmv v_income1
	// Year
	 gen int year=`year'
	// Create real income measure (2015 prices) for income
	 merge m:1 year using "$ff\cpi.dta", nogen keep(3)
	 replace v_income1=v_income1*(100/cpi)
	//Create log income
	 gen v_log_income1 = log10(v_income1)
	// Gender
	 gen byte v_female=koen==2
	// Define age (as per 1. january)
	 gen v_age=`year'-year(foed_dag)-1
	// Keep vars
	 keep pnr year v_* hfaudd
	// Impose sample selection critera
	 keep if v_age>17 & v_age <65
	// Generate education labels
	 qui: merge m:1 hfaudd using  "$ff\edu_formats.dta",nogen keep(1 3)
	// Generate education variable that use the isced classification	
	 qui: merge m:1 hfaudd using  "$ff\isced_edu_formats_level.dta",nogen keep(1 3)
	 qui: merge m:1 hfaudd using  "$ff\isced_edu_formats_field.dta",nogen keep(1 3)
	 // Create educati groups: Medicine, Business, STEM and Law
		gen educ_level_firstdigit = substr(educ_level, 1, 1)
		gen educ_field_first3digits = substr(educ_field, 1, 3)
		gen educ_field_first4digits = substr(educ_field, 1, 4)
		gen v_educ_group = "-"
		replace v_educ_group = "Medicine" if educ_field_first4digits == "0912" & (educ_level_firstdigit == "6" | educ_level_firstdigit == "7" | educ_level_firstdigit == "8")
		replace v_educ_group = "Business" if (educ_field_first4digits == "0411" | ///
											educ_field_first4digits == "0412" | ///
											educ_field_first4digits == "0413" | ///
											educ_field_first4digits == "0414") & (educ_level_firstdigit == "6" | educ_level_firstdigit == "7" | educ_level_firstdigit == "8")
		replace v_educ_group = "STEM" if (educ_field_first3digits == "051" | ///
											educ_field_first3digits == "052" | ///
											educ_field_first3digits == "053" | ///
											educ_field_first3digits == "054" | ///
											educ_field_first3digits == "061" | ///
											educ_field_first3digits == "071") & (educ_level_firstdigit == "6" | educ_level_firstdigit == "7" | educ_level_firstdigit == "8")
		replace v_educ_group = "Law" if educ_field_first3digits == "042" & (educ_level_firstdigit == "6" | educ_level_firstdigit == "7" | educ_level_firstdigit == "8")
	// Keep vars
	 keep pnr year v_* hfaudd
	// Numerical pnr
	 destring pnr, generate(pnr_int)
	// Drop duplicates 
	 bys pnr: keep if _n==1
	// Save
	 compress
	 save "$tf\rawdata`year'.dta", replace
}

// append to a panel for analysis
 clear
 forval j= 1980/2013{
	qui: append using "$tf\rawdata`j'.dta" 
	keep if v_income>0 & v_income!=.
 }	
// Create 5y income and 5y log income
 xtset pnr_int year
 gen v_income_5y =(v_income1+f1.v_income1+f2.v_income1+f3.v_income1+f4.v_income1)/5
 gen v_log_income5 = log10(v_income_5y)
 // Income rank 
sort year v_income1
by year: gen ranking = (_N - _n)
by year: cumul v_log_income1, gen(cdf_log_income)

gen top1_dummy = cdf_log_income >= 0.99
gen top10_dummy = cdf_log_income >= 0.9

// Save
save "$tf\analysisdata.dta",replace

		
	 
// append to panel wo sample restriction
 clear
 forval j= 1980/2013{
	qui: append using "$tf\rawdata`j'.dta" 
	
 }
// Income rank 
sort year v_income1
by year: gen ranking = (_N - _n)
by year: cumul v_log_income1, gen(cdf_log_income)

gen top1_dummy = cdf_log_income >= 0.99
gen top10_dummy = cdf_log_income >= 0.9

// Save
save "$tf\analysisdata_raw.dta",replace
