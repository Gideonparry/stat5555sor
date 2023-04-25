## Getting data for each year
year_2023 <- sum_sor(2023,"2023-03-12")
year_2022 <- sum_sor(2022,"2022-03-13")
year_2021 <- sum_sor(2021,"2021-03-14")

## Adding year to data before combining
year_2023$year <- rep(2023, nrow(year_2023))
year_2022$year <- rep(2022, nrow(year_2022))
year_2021$year <- rep(2021, nrow(year_2021))

## binding data
combined_years <- rbind(year_2023, year_2022, year_2021)

usethis::use_data(combined_years, overwrite = TRUE)
