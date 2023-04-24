get_combined_data <- function(year) {

  kenpom_data <- fetch_and_format_kenpom_data(year)
  warrennolan_data <- fetch_and_format_warrennolan_data(year)
  combined_data <- combine_datasets(kenpom_data, warrennolan_data)
  return(combined_data)
}

