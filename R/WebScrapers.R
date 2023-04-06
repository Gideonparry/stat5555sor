scrape_txt_file <- function(year) {
  # Download the file from the website and read its contents
  txt_lines <- readLines(paste("https://kenpom.com/cbbga", year, ".txt", sep=""))

  # Split each line by tab separator and convert to a dataframe
  txt_df <- data.frame(do.call(rbind, strsplit(txt_lines, "\t")), stringsAsFactors = FALSE)

  # Return the dataframe
  return(txt_df)
}

year <- 23
txt_df <- scrape_txt_file(23)


library(rvest)

scrape_html_table <- function(year, table_index = 1) {
  # Read in the HTML from the website
  html <- read_html(paste("https://www.warrennolan.com/basketball/20", year,"/net", sep=""))

  # Extract the table from the HTML
  table <- html_nodes(html, "table")[[table_index]]

  # Convert the table to a dataframe
  df <- html_table(table)

  # Return the dataframe
  return(df)
}

year <- 23
html_df <- scrape_html_table(year)
