## code to prepare `year_2023` dataset goes here
games_2023 <- get_combined_data(2023, "2023-03-12")

usethis::use_data(games_2023, overwrite = TRUE)
