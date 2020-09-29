cap program drop mle_pareto
program mle_pareto
* this program calculates pareto coefficients, gaps, and ceilling ratio
syntax, [bys(string)] savecoef(string)  income(string) pareto_cutoff(string)
	tempfile mle_tf
	save `mle_tf',replace
	keep if ccdf<= `pareto_cutoff'
	sort `bys' year v_female
	by `bys' year v_female: egen mlinc = mean(`income')
	by `bys' year v_female: egen beta = min(`income')
	by `bys' year v_female: gen keepvar=_n==1
	gen alpha=(1/(mlinc-beta))/log(10)
	keep if keepvar==1
	keep alpha beta `bys' year v_female
	sort `bys' year v_female
	gen gap=beta[_n-1]-beta  if v_female==1 & year==year[_n-1] & v_female[_n-1]==0
	gen gap_ln=gap*log(10)
	gen gamma=(alpha/alpha[_n-1])-1 if v_female==1 & year==year[_n-1] & v_female[_n-1]==0
	save "`savecoef'",replace
	use `mle_tf',clear
end
