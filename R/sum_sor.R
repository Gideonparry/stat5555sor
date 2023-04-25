#' Sums sor for each team.
#'
#' @param combined_data A data frame containing home and away sor for every team
#' @return a data frame with every team and their sor
#' @export

sum_sor <- function(combined_data){

  # Here we assign variables for home teams, away teams, home sor, and away sor
  home_team <- combined_data$Home_team
  away_team <- combined_data$Away_team
  home_sor <- combined_data$home_sor
  away_sor <- combined_data$away_sor

  # First we create an empty vector to store the sor scores
  num <- rep(0, length(unique(home_team)))

  # This for loop sums all of the home team sor scores
  for(i in 1:length(unique(home_team))){
    num[i] <- sum(home_sor[home_team == sort(unique(home_team))[i]])
  }

  # This for loop sums all of the away team sor scores
  for(i in 1:length(unique(away_team))){
    num[i] <- sum(away_sor[away_team == sort(unique(away_team))[i]])
  }

  # Here we create a data frame with every team and their sor score
  sor <- data.frame(sort(unique(home_team)), num)
  colnames(sor) <- c('Team', 'SOR')
  sor <- sor[order(sor$SOR, decreasing = TRUE),]
  return(sor)
}

