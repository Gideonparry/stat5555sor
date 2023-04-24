#' Matches names of teams properly
#'
#'
#'
#' @param name one name
#' @param names_to_match the name to match
#'
#' @returns The matched names
#'
#' @import stringdist

match_names <- function(name, names_to_match) {
  name <- trimws(name)
  dists <- stringdist::stringdist(name, names_to_match, method = "jw")
  names_to_match[which.min(dists)]
}
