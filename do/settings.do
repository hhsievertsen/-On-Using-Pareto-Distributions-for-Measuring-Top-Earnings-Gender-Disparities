/*
	Project: Pareto Gender
	File: setttings.do - specify globals, paths etc
	Last edited: by Hans, Sep 12, 2020
*/
// Settings
clear all 
set max_memory 45g
set matsize 10000
set more off
set graphics on
global graphsettings "graphregion(lcolor(white) fcolor(white))	 plotregion(lcolor(black) fcolor(white)) "
// Globals
gl tf "D:\Data\workdata\704784\xdrev\704784\pareto_gender\temp"
gl of "D:\Data\workdata\704784\xdrev\704784\pareto_gender\output"
gl ff "D:\Data\workdata\704784\xdrev\704784\pareto_gender\format"
gl rf "D:\Data\workdata\704784\xdrev\704784\raw_files\stata_source_files_3"
gl rf "D:\Data\workdata\704784\xdrev\704784\raw_files\stata_source_files_100"
// Paths
adopath + "D:\Data\workdata\704784\xdrev\704784\pareto_gender\ado"
cd "D:\Data\workdata\704784\xdrev\704784\pareto_gender\temp"

		
