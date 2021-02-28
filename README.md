# ep_vs_mhcn

Branch   |[GitHub Actions](https://github.com/richelbilderbeek/ep_vs_mhcn/actions)                                     
---------|-------------------------------------------------------------------------------------------------------------
`master` |![R-CMD-check](https://github.com/richelbilderbeek/ep_vs_mhcn/workflows/R-CMD-check/badge.svg?branch=master) 
`develop`|![R-CMD-check](https://github.com/richelbilderbeek/ep_vs_mhcn/workflows/R-CMD-check/badge.svg?branch=develop)

Compare the results of EpitopePrediction with those of MHCnuggets.

## IC50s 

There can be differences in how IC50s values are determined:

![](ep_vs_mhcn.png)

![](ep_vs_mhcn_log.png)

## Relative binding strength

The relative bindings strengths, however, should match:

![](ep_vs_mhcn_perc.png)

Reproduced for HLA-A*01:01 only (the red line),
gives the same unexpected result:

![](ep_vs_mhcn_perc_spreadsheet.png)
