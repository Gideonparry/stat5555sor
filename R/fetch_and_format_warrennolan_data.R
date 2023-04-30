#' Gets Data from warren nolan
#'
#'
#'
#' @param year the year to run obtain the Warren Nolan data
#' @param team the team that is being filtered
#'
#' @returns Warren Nolan data
#'
#' @import xml2
#' @import rvest
#' @importFrom magrittr %>%

fetch_and_format_wn_data <- function(year, team = Team) {
  warrennolan_url <- paste0(
    "https://www.warrennolan.com/basketball/",
    year, "/net"
  )

  tryCatch(
    {
      warrennolan_data <- xml2::read_html(warrennolan_url) %>%
        rvest::html_table(header = TRUE, fill = TRUE)

      warrennolan_data <- warrennolan_data[[1]]

      ## renames to make formatting work

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(Team = str_replace_all({{team}}, "State", "St\\."))

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(Team = str_replace_all({{team}}, "Saint", "St\\."))

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(Team = str_replace_all({{team}}, "-", " "))

     warrennolan_data <- warrennolan_data |>
        dplyr::mutate(Team = str_replace_all({{team}}, "\\(", ""))

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(Team = str_replace_all({{team}}, "\\)", ""))


      ## Individual teams that don't follow a pattern

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "St. Mary's College", "St. Mary's")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "FAU", "Florida Atlantic")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "North Carolina St.", "N.C. St.")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "UNCG", "UNC Greensboro")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "Ole Miss", "Mississippi")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "Seattle University", "Seattle")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "UNCW", "UNC Wilmington")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "California Baptist", "Cal Baptist")
        )


      warrennolan_data <- warrennolan_data |>
      dplyr::mutate(
        Team =
          str_replace_all(
            {{team}}, "Texas A&M Corpus Christi",
            "Texas A&M Corpus Chris"
          )
      )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "FGCU", "Florida Gulf Coast")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "UMass", "Massachusetts")
        )


      ### UMass Lowell needs to be switched back
      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "Massachusetts Lowell", "UMass Lowell")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "Detroit", "Detroit Mercy")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "SIUE", "SIU Edwardsville")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "Southeast Missouri",
                            "Southeast Missouri St.")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "UTA", "UT Arlington")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "South Carolina Upstate", "USC Upstate")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "UTRGV", "UT Rio Grande Valley")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "Nicholls", "Nicholls St.")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "UIC", "Illinois Chicago")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "ULM", "Louisiana Monroe")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "Omaha", "Nebraska Omaha")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "Loyola Maryland", "Loyola MD")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "McNeese", "McNeese St.")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "Presbyterian College", "Presbyterian")
        )

      warrennolan_data <- warrennolan_data |>
        dplyr::mutate(
          Team =
            str_replace_all({{team}}, "Long Island", "LIU")
        )

      return(warrennolan_data)
    },
    error = function(e) {
      cat("An error occured while fetching from the Warren Nolan website")
    }
  )
}
