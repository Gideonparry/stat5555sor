#' Gets Kenpom data and formats it in our usable form
#'
#'
#'
#' @param year the year to run obtain the kenmpom data
#'
#' @returns Kenpom data of games played
#'
#' @import stringr

parse_kenpom_row <- function(row) {
  date <- as.Date(stringr::str_sub(row, 1, 10), format = "%m/%d/%Y")
  away_team <- stringr::str_trim(stringr::str_sub(row, 12, 33))
  away_score <- as.integer(stringr::str_trim(stringr::str_sub(row, 34, 37)))
  home_team <- stringr::str_trim(stringr::str_sub(row, 39, 60))
  home_score <- as.integer(stringr::str_trim(stringr::str_sub(row, 61, 64)))
  neutral <- stringr::str_trim(stringr::str_sub(row, 65, 66)) == "N"

  return(data.frame(Date = date, Away_team = away_team, Away_score = away_score,
                    Home_team = home_team, Home_score = home_score, neutral = neutral))
}

