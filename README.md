
<!-- README.md is generated from README.Rmd. Please edit that file -->

# stat5555sor

<!-- badges: start -->

[![R-CMD-check](https://github.com/Gideonparry/stat5555sor/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Gideonparry/stat5555sor/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The stat5555sor package is designed with the intent to find the strength
of record for the last 3 NCAA basketball seasons(21-23). The user can
decide which season they would like to look at and through our
algorithm, they can see which teams were actually the strongest during
those seasons.

## Installation

You can install the development version of stat5555sor from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Gideonparry/stat5555sor")
```

## Date Frame Example

Before looking at the Data Frame, one should know that each row
represents one game played during the selected season. In this case, it
will be the 2022-2023 season.The variables are all explained below.

``` r
test <- get_combined_data(2023)
#> No encoding supplied: defaulting to UTF-8.
head(test)
#> # A tibble: 6 × 12
#> # Rowwise: 
#>   Date       Away_team     Away_…¹ away_…² Home_…³ Home_…⁴ home_…⁵ score…⁶ site 
#>   <date>     <chr>           <int>   <int> <chr>     <int>   <int>   <int> <chr>
#> 1 2022-11-07 Jackson State      56     305 Abilen…      65     206       9 Abil…
#> 2 2022-11-07 South Dakota…      80     155 Akron        81     102       1 Akron
#> 3 2022-11-07 Longwood           54     166 Alabama      75       2      21 Alab…
#> 4 2022-11-07 Tarleton Sta…      59     162 Arizon…      62      66       3 Ariz…
#> 5 2022-11-07 North Dakota…      58     215 Arkans…      76      21      18 Arka…
#> 6 2022-11-07 George Mason       52     139 Auburn       70      32      18 Aubu…
#> # … with 3 more variables: neutral <dbl>, home_sor <dbl>, away_sor <dbl>, and
#> #   abbreviated variable names ¹​Away_score, ²​away_NET, ³​Home_team, ⁴​Home_score,
#> #   ⁵​home_NET, ⁶​score_diff
```

Variables:

Date: The day the game was played  
Away_team/Home_team: Name of teams playing in game  
Away_NET/Home_NET: Rank of that team among all 358 Division I basketball
teams  
score_diff: Difference between Away_score and Home_score  
site: location the game was played  
neutral: refers to whether the game was played at the site of either
team’s home location or at a neutral site  
Away_record/Home_record: The record for each home and away team for the
season selected for each team in that game  
