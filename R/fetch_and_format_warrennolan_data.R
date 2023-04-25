#' Gets Data from warren nolan
#'
#'
#'
#' @param year the year to run obtain the Warren Nolan data
#'
#' @returns Warren Nolan data
#'
#' @import xml2
#' @import rvest
#' @importFrom magrittr %>%

fetch_and_format_warrennolan_data <- function(year) {
  warrennolan_url <- paste0(
    "https://www.warrennolan.com/basketball/",
    year, "/net"
  )
  warrennolan_data <- xml2::read_html(warrennolan_url) %>%
    rvest::html_table(header = TRUE, fill = TRUE) %>%
    .[[1]]

  ## renames to make formatting work

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(Team = str_replace_all(Team, "State", "St\\."))

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(Team = str_replace_all(Team, "Saint", "St\\."))

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(Team = str_replace_all(Team, "-", " "))

 warrennolan_data <- warrennolan_data |>
    dplyr::mutate(Team = str_replace_all(Team, "\\(", ""))

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(Team = str_replace_all(Team, "\\)", ""))


  ## Individual teams that don't follow a pattern

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "St. Mary's College", "St. Mary's")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "FAU", "Florida Atlantic")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "North Carolina St.", "N.C. St.")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "UNCG", "UNC Greensboro")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "Ole Miss", "Mississippi")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "Seattle University", "Seattle")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "UNCW", "UNC Wilmington")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "California Baptist", "Cal Baptist")
    )


  warrennolan_data <- warrennolan_data |>
  dplyr::mutate(
    Team =
      str_replace_all(
        Team, "Texas A&M Corpus Christi",
        "Texas A&M Corpus Chris"
      )
  )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "FGCU", "Florida Gulf Coast")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "UMass", "Massachusetts")
    )


  ### UMass Lowell needs to be switched back
  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "Massachusetts Lowell", "UMass Lowell")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "Detroit", "Detroit Mercy")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "SIUE", "SIU Edwardsville")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "Southeast Missouri", "Southeast Missouri St.")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "UTA", "UT Arlington")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "South Carolina Upstate", "USC Upstate")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "UTRGV", "UT Rio Grande Valley")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "Nicholls", "Nicholls St.")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "UIC", "Illinois Chicago")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "ULM", "Louisiana Monroe")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "Omaha", "Nebraska Omaha")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "Loyola Maryland", "Loyola MD")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "McNeese", "McNeese St.")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "Presbyterian College", "Presbyterian")
    )

  warrennolan_data <- warrennolan_data |>
    dplyr::mutate(
      Team =
        str_replace_all(Team, "Long Island", "LIU")
    )




  return(warrennolan_data)
}
