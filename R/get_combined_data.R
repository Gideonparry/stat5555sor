#' Gets combined data to compute sor record
#'
#'
#'
#' @param year The year to get the data from
#'
#' @returns combined data.
#'
#' @import dplyr


get_combined_data <- function(year) {
  kenpom_data <- fetch_and_format_kenpom_data(year)
  warrennolan_data <- fetch_and_format_warrennolan_data(year)
  combined_data <- combine_datasets(kenpom_data, warrennolan_data)

  ## Complete cases drops non d1 opponents
  combined_data <- combined_data[complete.cases(combined_data), ]

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
