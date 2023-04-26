## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(stat5555sor)

## -----------------------------------------------------------------------------
test <- get_combined_data(2023, "2023-03-12")
head(test)

## -----------------------------------------------------------------------------
sor_points(56, 65, 206, 363, FALSE, FALSE)

## -----------------------------------------------------------------------------
test_sor <- sum_sor(2023, "2023-03-12")
head(test_sor)

## ---- eval=FALSE--------------------------------------------------------------
#  ## Getting data for each year
#  year_2023 <- sum_sor(2023,"2023-03-12")
#  year_2022 <- sum_sor(2022,"2022-03-13")
#  year_2021 <- sum_sor(2021,"2021-03-14")
#  
#  ## Adding year to data before combining
#  year_2023$year <- rep(2023, nrow(year_2023))
#  year_2022$year <- rep(2022, nrow(year_2022))
#  year_2021$year <- rep(2021, nrow(year_2021))
#  
#  ## binding data
#  combined_years <- rbind(year_2023, year_2022, year_2021)
#  
#  usethis::use_data(combined_years, overwrite = TRUE)
#  

## -----------------------------------------------------------------------------
  library(stat5555sor)
  # Load dataset from within package
  data("combined_years")
  # filter dataset to only include rows where the state column contains "Utah"
  df_utah <- combined_years[grepl("Utah|BYU|Weber St", combined_years$Team),]
  # exclude Utah Tech
  df_utah <- df_utah[!grepl("Utah Tech", df_utah$Team),]
  head(df_utah)

## ---- fig.width=8, fig.height=7-----------------------------------------------
library(ggplot2)
  ggplot(data = df_utah, aes(x = year, y = SOR, group = Team, color = Team)) +
    geom_line(size = 1.5) +
    scale_x_continuous(breaks = seq(min(df_utah$year), max(df_utah$year), by = 1)) +
    scale_y_continuous(breaks = seq(round(min(df_utah$SOR)), round(max(df_utah$SOR))), 
                       labels = function(x) format(x, scientific = FALSE)) +
    scale_color_manual(values = c("blue", "black", "red", "grey", "green", "purple")) +
    labs(title = "Line Plot Utah Teams SOR Score for Past Three Seasons", x = "Year", y = "SOR") +
    theme(plot.title = element_text(size = 16, hjust = 0.5))

