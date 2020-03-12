
<!-- README.md is generated from README.Rmd. Please edit that file -->

# xs

<!-- badges: start -->

<!-- badges: end -->

Sandbox for prototyping a package for analyzing reinsurance treaties

``` r
library(xs)
library(tidyverse)
treaty <- quota_share(ceded = 0.6, ceding_commission = 0.1)
treaty
#> A Quota Share treaty with
#>   - Ceding percentage of 60%
#>   - Ceding commission of 10%
```

``` r
policies <- tribble(
  ~ policy_id, ~ premium,
  0, 2000,
  1, 3000,
  2, 2500
)

treaty %>%
  treaty_apply_premiums(policies)
#> Quota Share premium analysis
#>   - Premiums retained: 3,000
#>   - Premiums ceded: 4,500
#>   - Ceding commission: 450
```

``` r
claims <- tribble(
  ~ claim_id, ~ loss,
  0, 400000,
  1, 350000
)

treaty %>%
  treaty_apply_claims(claims)
#> Quota Share claims analysis
#>   - Total claims: 750,000
#>   - Ceded losses: 450,000
#>   - Retained losses: 300,000
```
