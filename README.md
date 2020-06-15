# ep_vs_mhcn

Branch   |[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)                                                                             
---------|------------------------------------------------------------------------------------------------------------------------------------------
`master` |[![Build Status](https://travis-ci.org/richelbilderbeek/ep_vs_mhcn.svg?branch=master)](https://travis-ci.org/richelbilderbeek/ep_vs_mhcn) 
`develop`|[![Build Status](https://travis-ci.org/richelbilderbeek/ep_vs_mhcn.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/ep_vs_mhcn)

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
