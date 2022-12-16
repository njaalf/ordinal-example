# A case where the default approach to factor analysing ordinal data mistakes two factors for one factor


An example dataset is provided that illustrates non-robustness toward underlying non-normality

Papers [[1]](#1) and [[2]](#2) investigate, among other things, the extent to which the polychoric approach to factor and SEM analysis 
is sensitive to violation of the underlying normality assumption for the response vector. 

The former paper describes a case where a two-factor continuous distribution will always be mis-interpreted as a clean one-factor solution after discretization. 

In this repository we provide a simulated n=10^4 sample from the continuous distribution. 
Also provided is a code file for the simulation implemented in R, and an R script readers may run to affirm that
indeed, regardless of the number and placements of thresholds, the ordinal data will always yield a one-factor solution. 
The script also illustrates that treating ordinal data as continuous is not always a good idea, even with seven symmetrically distributed ordinal levels. 

The conclusion is that factor retention will always go wrong in this scenario. 
Also, unfortunately there is no way to catch the underlying non-normality using statistical tests on the ordinal dataset. 



## References
<a id="1">[1]</a> 
Grønneberg, S., & Foldnes, N. (2022). Factor analyzing ordinal items requires substantive knowledge of response marginals. Psychological Methods.

<a id="2">[1]</a>
Foldnes, N., & Grønneberg, S. (2021). The sensitivity of structural equation modeling with ordinal data to underlying non-normality and observed distributional forms. Psychological Methods.
