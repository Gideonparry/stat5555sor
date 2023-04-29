#' Gets Data from warren nolan
#'
#'
#'
#' @param kenpom_data The data from kenpom
#' @param warrennolan_data the data from warren nolan
#' @param away_team The away team
#' @param home_team The home team
#' @param away_score The points scored by the away team
#' @param home_score The points scored by the home team
#' @param game_date the date the game is played
#' @param neutral 1 if game is at a neutral site, 0 ikf not
#' @param net_rank team's NET rank
#' @param away_net Away team's NET rank
#' @param home_net Home team's NET rank
#' @param score_diff game's points differential
#' @param site where the game was played
#'
#' @returns combined data.
#'
#' @import dplyr
#' @import rvest
#' @importFrom magrittr "%>%"

combine_datasets <- function(kenpom_data, warrennolan_data,
                             away_team = Away_team,
                             home_team = Home_team,
                             away_score = Away_score,
                             home_score = Home_score,
                             game_date = Date,
                             neutral = neutral,
                             net_rank = "NET Rank",
                             away_net = away_NET,
                             home_net = home_NET,
                             score_diff = score_diff,
                             site = site) {


  # Calculate score_diff and site columns
  kenpom_data <- kenpom_data %>%
    dplyr::mutate(score_diff = abs({{home_score}} - {{away_score}}),
           site = ifelse({{neutral}}, "Neutral", {{home_team}}),
           neutral = ifelse({{neutral}}, 1, 0))

  # Join the kenpom_data_renamed with warrennolan_data to get the conference
  # columns
  combined_data <- kenpom_data %>%
    dplyr::left_join(warrennolan_data, by = c("Home_team" = "Team")) %>%
    dplyr::rename(home_NET = {{net_rank}}) %>%
    dplyr::left_join(warrennolan_data, by = c("Away_team" = "Team")) %>%
    dplyr::rename(away_NET = {{net_rank}}) %>%
    dplyr::select({{game_date}}, {{away_team}}, {{away_score}}, {{away_net}},
                  {{home_team}}, {{home_score}}, {{home_net}}, {{score_diff}},
                  {{site}}, {{neutral}})


  return(combined_data)
}
