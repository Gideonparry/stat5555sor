#' Gets Data from warren nolan
#'
#'
#'
#' @param kenpom_data The data from kenpom
#' @param warrennolan_data the data from warren nolan
#'
#' @returns combined data.
#'
#' @import dplyr
#' @import rvest
#' @importFrom magrittr "%>%"

combine_datasets <- function(kenpom_data, warrennolan_data) {

  # Rename columns in kenpom_data
  kenpom_data_renamed <- kenpom_data %>%
    dplyr::rename(Away_team = Away_team,
           Home_team = Home_team,
           Away_score = Away_score,
           Home_score = Home_score,
           Date = Date,
           neutral = neutral)

  # Calculate score_diff and site columns
  kenpom_data_renamed <- kenpom_data_renamed %>%
    dplyr::mutate(score_diff = abs(Home_score - Away_score),
           site = ifelse(neutral, "Neutral", Home_team),
           neutral = ifelse(neutral, 1, 0))

  # Join the kenpom_data_renamed with warrennolan_data to get the conference columns
  combined_data <- kenpom_data_renamed %>%
    dplyr::left_join(warrennolan_data, by = c("Home_team" = "Team")) %>%
    dplyr::rename(Home_record = Record, home_NET = `NET Rank`) %>%
    dplyr::left_join(warrennolan_data, by = c("Away_team" = "Team")) %>%
    dplyr::rename(Away_record = Record, away_NET = `NET Rank`) %>%
    dplyr::select(Date, Away_team, Away_score, away_NET, Home_team, Home_score, home_NET, score_diff, site, neutral, Home_record, Away_record)


  return(combined_data)
}
