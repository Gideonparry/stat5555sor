#' Sums sor for each team.
#'
#' @param year The year to get the data from. Only works from 2021
#' @param games_date the cutoff date for the games played.
#' @return a data frame with every team and their sor
#' @export

sum_sor <- function(year, games_date){

  combined_data <- get_combined_data(year, games_date)

  # Here we assign variables for home teams, away teams, home sor, and away sor
  home_team <- combined_data$Home_team
  away_team <- combined_data$Away_team
  home_sor <- combined_data$home_sor
  away_sor <- combined_data$away_sor

  # Next we create an empty vector to store the sor scores
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
  sor$ranking <- c(1:nrow(sor))
  return(sor)
}

