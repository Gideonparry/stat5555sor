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
  warrennolan_url <- paste0("https://www.warrennolan.com/basketball/",
                            year, "/net")
  warrennolan_data <- xml2::read_html(warrennolan_url) %>%
    rvest::html_table(header = TRUE, fill = TRUE) %>%
    .[[1]]

  return(warrennolan_data)
}
