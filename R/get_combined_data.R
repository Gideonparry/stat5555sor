library(httr)
library(xml2)
library(stringr)
library(stringdist)
library(dplyr)
library(tidyr)

get_combined_data <- function(year) {

  fetch_and_format_kenpom_data <- function(year) {
    parse_kenpom_row <- function(row) {
      date <- as.Date(str_sub(row, 1, 10), format = "%m/%d/%Y")
      away_team <- str_trim(str_sub(row, 12, 33))
      away_score <- as.integer(str_trim(str_sub(row, 34, 37)))
      home_team <- str_trim(str_sub(row, 39, 60))
      home_score <- as.integer(str_trim(str_sub(row, 61, 64)))
      neutral <- str_trim(str_sub(row, 65, 66)) == "N"

      return(data.frame(Date = date, Away_team = away_team, Away_score = away_score,
                        Home_team = home_team, Home_score = home_score, neutral = neutral))
    }

    kenpom_url <- paste0("https://kenpom.com/cbbga", substr(year, 3, 4), ".txt")
    kenpom_response <- GET(kenpom_url)
    kenpom_content <- content(kenpom_response, "text")
    kenpom_rows <- str_split(kenpom_content, "\n")[[1]]
    kenpom_data <- do.call(rbind, lapply(kenpom_rows[-length(kenpom_rows)], parse_kenpom_row))
    kenpom_data <- kenpom_data %>% mutate(Away_team = str_replace_all(Away_team, "St\\.", "State"))
    kenpom_data <- kenpom_data %>% mutate(Home_team = str_replace_all(Home_team, "St\\.", "State"))

    return(kenpom_data)
  }

  fetch_and_format_warrennolan_data <- function(year) {
    warrennolan_url <- paste0("https://www.warrennolan.com/basketball/", year, "/net")
    warrennolan_data <- read_html(warrennolan_url) %>%
      html_table(header = TRUE, fill = TRUE) %>%
      .[[1]]

    return(warrennolan_data)
  }

  match_names <- function(name, names_to_match) {
    name <- trimws(name)
    dists <- stringdist(name, names_to_match, method = "jw")
    names_to_match[which.min(dists)]
  }

  combine_datasets <- function(kenpom_data, warrennolan_data) {

    # Rename columns in kenpom_data
    kenpom_data_renamed <- kenpom_data %>%
      rename(Away_team = Away_team,
             Home_team = Home_team,
             Away_score = Away_score,
             Home_score = Home_score,
             Date = Date,
             neutral = neutral)

    # Calculate score_diff and site columns
    kenpom_data_renamed <- kenpom_data_renamed %>%
      mutate(score_diff = abs(Home_score - Away_score),
             site = ifelse(neutral, "Neutral", Home_team),
             neutral = ifelse(neutral, 1, 0))

    # Join the kenpom_data_renamed with warrennolan_data to get the conference columns
    combined_data <- kenpom_data_renamed %>%
      left_join(warrennolan_data, by = c("Home_team" = "Team")) %>%
      rename(Home_record = Record, home_NET = `NET Rank`) %>%
      left_join(warrennolan_data, by = c("Away_team" = "Team")) %>%
      rename(Away_record = Record, away_NET = `NET Rank`) %>%
      select(Date, Away_team, Away_score, away_NET, Home_team, Home_score, home_NET, score_diff, site, neutral, Home_record, Away_record)


    return(combined_data)
  }

  kenpom_data <- fetch_and_format_kenpom_data(year)
  warrennolan_data <- fetch_and_format_warrennolan_data(year)
  combined_data <- combine_datasets(kenpom_data, warrennolan_data)
  return(combined_data)
}

test <- get_combined_data(2023)
