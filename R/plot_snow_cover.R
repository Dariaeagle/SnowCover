#' plot_snow_cover
#'
#' #Plot Snow Cover Changes Over Time
#' #This function plots the changes in snow cover over time for a specified country using hystogram and trend line
#'
#' @param snow_cover_area A numeric vector containing the snow cover area data in square kilometers for each day.
#' @param dates A vector of class Date containing the dates corresponding to each day.
#' @param country_name A character string specifying the name of the country.
#'
#' @return A ggplot object displaying the snow cover changes over time.
#'
#' @examples
#' snow_cover_area <- unlist(snow_cover_area_list)
#' dates <- seq(as.Date("2023-01-01"), by = "day", length.out = nlayers(snow_cover_series))
#' country_name <- "Denmark"
#' plot_snow_cover(snow_cover_area, dates, country_name)
#'
#' @importFrom ggplot2 geom_bar geom_smooth labs theme_light element_text margin
#'
#' @export
plot_snow_cover <- function(snow_cover_area, dates, country_name) {
  # Create a data frame with the day of the month and snow cover area
  snow_cover_data <- data.frame(Day = seq_along(snow_cover_area), Date = dates, MeanSnowCover = snow_cover_area)

  # Create a time-series plot
  ggplot(snow_cover_data, aes(x = Date, y = MeanSnowCover)) +
    geom_bar(stat = "identity", fill = "#4682B4", alpha = 0.5, width = 0.9) + # Histogram
    geom_smooth(method = "loess", color = "red") + # Trend line
    labs(x = "Day of the month", y = "Snow cover area (km^2)",
         title = paste("Snow cover changes in", country_name, "over the month")) +
    theme_light() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1.5),
          axis.text.y = element_text(margin = margin(l = 10)))
}
