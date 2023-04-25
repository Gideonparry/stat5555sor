## code to prepare `rankings_2023` dataset goes here

rankings_2023 <- sum_sor(2023, "2023-03-12")

usethis::use_data(rankings_2023, overwrite = TRUE)
