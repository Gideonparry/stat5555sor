#' Gets combined data to compute sor record
#'
#' Gets the combined data with all the games played up to and including the
#' specified date. However, the NET rankings we have available and base our
#' SOR points on are as of Selection Sunday each year. Selection Sunday in 2023
#' was "2023-03-12", in 2022 it was "2022-03-13", and in 2021 it was
#' "2021-03-14"
#'
#'
#' @param year The year to get the data from. Only worksgit from 2021
#' @param game_date the cutoff date for the games played.
#' @param away_score The points scored by the away team
#' @param home_score The points scored by the home team
#' @param home_net The home team's net rank
#' @param away_net The away team's net rank
#' @param neutral 1 if game is at a neutral site, 0 if not
#'
#' @returns combined data.
#'
#' @import dplyr
#' @importFrom stats complete.cases
#'
#' @export
#'
#' @examples
#' get_combined_data(2023, "2023-03-12")
#' get_combined_data(2022, "2022-03-13")
#'

get_combined_data <- function(year,
                              game_date = Date,
                              home_score = Home_score,
                              away_score = Away_score,
                              home_net = home_NET,
                              away_net = away_NET,
                              neutral = neutral) {
  kenpom_data <- fetch_and_format_kenpom_data(year)
  warrennolan_data <- fetch_and_format_wn_data(year)
  combined_data <- combine_datasets(kenpom_data, warrennolan_data)

  ## Complete cases drops non d1 opponents
  combined_data <- combined_data[complete.cases(combined_data), ]

  ## Dropping games after Selection Sunday
  combined_data <- subset(combined_data,
                          {{game_date}} <= as.Date({{game_date}}))

  ## adding home_sor
  combined_data <- combined_data |>
    dplyr::rowwise() |>
    dplyr::mutate(home_sor = sor_points(
      {{home_score}}, {{away_score}}, {{away_net}},
      nrow(warrennolan_data), TRUE, {{neutral}}
    ))

  ## adding away_sor
  combined_data <- combined_data |>
    dplyr::rowwise() |>
    dplyr::mutate(away_sor = sor_points(
      {{away_score}}, {{home_score}}, {{home_net}},
      nrow(warrennolan_data), FALSE, {{neutral}}
    ))


  return(combined_data)
}
