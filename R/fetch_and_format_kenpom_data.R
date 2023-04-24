#' Gets Kenpom data and formats it in our usable form
#'
#'
#'
#' @param year the year to run obtain the kenmpom data
#'
#' @returns Kenpom data of games played
#'
#' @import stringr
#' @import httr
#' @import dplyr


fetch_and_format_kenpom_data <- function(year) {


  kenpom_url <- paste0("https://kenpom.com/cbbga",
                       substr(year, 3, 4), ".txt")
  kenpom_response <- httr::GET(kenpom_url)
  kenpom_content <- httr::content(kenpom_response, "text")
  kenpom_rows <- stringr::str_split(kenpom_content, "\n")[[1]]
  kenpom_data <- do.call(rbind, lapply(kenpom_rows[-length(kenpom_rows)],
                                       parse_kenpom_row))
  kenpom_data <- kenpom_data |>
    dplyr::mutate(Away_team = str_replace_all(Away_team, "St\\.", "State"))
  kenpom_data <- kenpom_data |>
    dplyr::mutate(Home_team = str_replace_all(Home_team, "St\\.", "State"))

  return(kenpom_data)
}
