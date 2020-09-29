# On Using Pareto Distributions for Measuring Top-Earnings Gender Disparities
 
 
This repository contains the replication files for the paper "On Using Pareto Distributions for Measuring Top-Earnings Gender Disparities" by Hansen, Harmenberg, Öberg, and Sievertsen.

### Contents

#### do

The folder "do" contains all Stata do files used to create the raw panel dataset and all figures in the paper.

#### ado

The folder "ado" contains the ado file that defines the Maximum Likelihood Estimator function.

#### Data

The project is based on confidential individual level register data from Statistics Denmark that cannot be shared publicly. However, we encourage researchers who wish to replicate our findings to apply for access to Statistics Denmark through a recognized institutions (for example a Danish University or Research Institute) and ask for the following data:

- **Sample**: All individuals aged 18-64y for the years 1980-2013
- **Variables**:

  - *loenmv* (gross earnings)
  - *foed_dag* (date of birth: only required if sample is not already restricted by age)
  - *hfaudd* (highest completed educational degree)
  - *koen* (gender)
  - *HELTID_DELTID_KODE* (part time employment)
 
 Furthermore we created the following datasets to create our analyis panel
 
 - *cpi:* A dataset containing the consumer price index to adjust earnings to constant prices.
 - *isced* We converted the *hfaudd* educational codes to the *ISCED* classification. 
 
 These files can be created manually, but we are happy to share these files directly and assist in getting access. Please contact Hans H. Sievertsen if you have any questions regarding the data (h.h.sievertsen@bristol.ac.uk). The project ID at Statistics Denmark is 704784. 
