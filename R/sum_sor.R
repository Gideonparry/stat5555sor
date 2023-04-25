#' Sums sor scores for each team.
#'
#' @param home_team the home team in a game
#' @param away_team the away team in a game
#' @param home_sor the home team's sor in a game
#' @param away_sor the away team's sor in a game
#' @return a dataframe with every team and their sor
#' @export


sum_sor <- function(home_team = combined_data$Home_team, away_team =
                      combined_data$Away_team, home_sor = combined_data$home_sor,
                    away_sor = combined_data$away_sor){

  # First we create an empty vector to store the sor scores.
  num <- rep(0, length(unique(home_team)))

  # This double for loop sums all of the home team sor scores.
  for(j in 1:length(unique(home_team))){
    for(i in 1:length(home_team)){
      if(home_team[i] == sort(unique(home_team))[j]){
        num[j] <- num[j] + home_sor[i]
      }
    }
  }

  # This double for loop sums all of the away team sor scores.
  for(j in 1:length(unique(away_team))){
    for(i in 1:length(away_team)){
      if(away_team[i] == sort(unique(away_team))[j]){
        num[j] <- num[j] + away_sor[i]
      }
    }
  }

  # Here we create a data frame with every team and their sor score.
  sor <- data.frame(sort(unique(home_team)), num)
  colnames(sor) <- c('Team', 'SOR')
  return(sor)
}
