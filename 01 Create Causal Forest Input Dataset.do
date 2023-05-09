********************************************************************************
**	PURPOSE: Create dataset used for causal forest
**							
**	INPUTS: Long with outcomes.dta
**	
**	OUTPUTS: Long with survey.dta
**				
**	NOTES: cf ficoscore08numlns.dta
**		   cf scoredfnumlns.dta
**
**	CREATED/MODIFED BY: Kayla Wilding, Leah Kim
**
**	DATE LAST EDITED: 4/14/2022
********************************************************************************

clear all 
version 14.0

use "$adta/Long with outcomes.dta", clear

local numloans tradelines1
local bothvars surveyid index enc svymiss creditmiss age female race_black married adults child college inclt30 z_insecurity_i z_selfcont_i z_risk_i z_credstatus_i z_credknow_i savingsbal_mehb95 savcheck_mehb95 slccumemb binnoncblslcb z_default_index_all_ib z_newcredit_ib z_liquid_ib

local scoredfvars `bothvars' 
local ficoscore08vars `bothvars' bfico z_amountsowed_ib 
local scoredfnumlns `scoredfvars' `numloans'
local ficoscore08numlns `ficoscore08vars' `numloans'

foreach outcome in scoredf ficoscore08 {
	foreach spec in numlns {
		preserve 
		keep `outcome' ``outcome'`spec''
		foreach var in `outcome' ``outcome'`spec'' {
			drop if mi(`var')
		}
		drop if index == 1
		tab index, gen(endline)
		drop index

		save "$adta/cf `outcome'`spec'.dta", replace
		restore
	}
}

