#' Gets the sor points for the home team
#'
#' This returns the strength of record points for the home team with the
#' following formula:
#' points gained in win = ((number of teams worse in NET than team you beat) +
#'              (10 if neutral or 20 if away)) \ ((number of teams + 19)
#'
#' This returns a 1 if a team beats the number 1 team on the road and returns
#' a 0 if the team beats the worst team at home, and a 1 if a team beats the
#' best team on the road
#'
#' The number of point lost in a loss in simply 1 - the points to be gained with
#' a win. This means that losing to the best team on the road is a loss of 0,
#' and losing to the worst team at home is a loss of 1.
#'
#' @param score The team's own score
#' @param opp_score The opposing team's score
#' @param opp_net The opposing team's NET ranking
#' @param number_of_teams The number of teams in that college basketball season
#' @param home TRUE if team is home team, FALSE if team is away team
#' @param neutral TRUE if game is played in a neutral location, FALSE if not
#'
#' @returns The strength of record points gained or lost by the home team
#' @export
#'

## Formula for SOR points in a win:
## points = ((number of teams worse in NET than team you beat) +
##            (10 if neutral or 20 if away)) \
##            ((number of teams + 19)

## Formula for points lost in a loss:
## points = -(1 - (points team would have gained in a win))

sor_points <- function(score, opp_score, opp_net, number_of_teams,
                     home, neutral = FALSE) {

  ## loc is location modifier
  if(home == TRUE){
    loc <- 10 * neutral
  } else {
    loc <- 20 - 10 * neutral
  }

  win_sor <- (number_of_teams - opp_net  + loc) /
    (number_of_teams + 19)

  ## Checking if home team won
  if (score > opp_score) {
    ## Retuen win_sor with home win
    return(win_sor)
  } else {
    ## return neagative 1-win_sor with home loss
    return(-(1 - win_sor))
  }
}
