#' Gets combined data to compute sor record
#'
#' Gets the combined data with all the games played up to and including the
#' specified date. However, the NET rankings we have available and base our
#' SOR points on are as of Selection Sunday each year. Selection Sunday in 2023
#' was "2023-03-12", in 2022 it was "2022-03-13", and in 2021 it was
#' "2021-03-14"
#'
#'
#' @param year The year to get the data from. Only works from 2021
#' @param games_date the cutoff date for the games played.
#'
#' @returns combined data.
#'
#' @import dplyr
#'
#' @export
#'
#' @examples
#' get_combined_data(2023, "2023-03-12")
#' get_combined_data(2022, "2022-03-13")
#'


get_combined_data <- function(year, games_date) {
  kenpom_data <- fetch_and_format_kenpom_data(year)
  warrennolan_data <- fetch_and_format_warrennolan_data(year)
  combined_data <- combine_datasets(kenpom_data, warrennolan_data)

  ## Complete cases drops non d1 opponents
  combined_data <- combined_data[complete.cases(combined_data), ]

  ## Dropping games after Selection Sunday
  combined_data <- subset(combined_data, Date <= as.Date(games_date))

  ## adding home_sor
  combined_data <- combined_data |>
    dplyr::rowwise() |>
    dplyr::mutate(home_sor = sor_points(
      Home_score, Away_score, away_NET,
      nrow(warrennolan_data), TRUE, neutral
    ))

  ## adding away_sor
  combined_data <- combined_data |>
    dplyr::rowwise() |>
    dplyr::mutate(away_sor = sor_points(
      Away_score, Home_score, home_NET,
      nrow(warrennolan_data), FALSE, neutral
    ))


  return(combined_data)
}
