#' create_snow_animation
#'
#' #Create a GIF animation of snow cover changes over time
#' #This function creates a GIF animation illustrating the changes in snow cover over time using a series of raster files
#'
#' @param raster_files_snow A character vector containing the file paths of raster layers representing snow cover for each day
#' @param date A character vector of dates corresponding to each raster image
#' @param Country_name A character string specifying the name of the country
#'
#' @return Nothing. The GIF animation is saved as "snow_animation.gif"
#'
#' @details
#' This function takes a list of raster files representing snow cover for each date and creates a GIF animation
#' to visualize the changes in snow cover over time. The animation displays one frame for each date, with each frame
#' showing the snow cover image for that date
#'
#' @importFrom raster raster
#' @importFrom animation saveGIF
#' @importFrom graphics image
#' @importFrom graphics legend
#' @importFrom raster stack
#'
#'
#' @examples
#' create_snow_animation(raster_files_snow, date, "country_name")
#'
#' @export
create_snow_animation <- function(raster_files_snow, date, country_name) {
  # Extracting dates from file names
  dates <- sapply(raster_files_snow, function(file) {
    # Extracting date from file name
    date_str <- gsub("^.*snow_cover_", "", basename(file))
    date_str <- gsub("\\.tif.*$", "", date_str)  # Removing everything after ".tif" # Removing everything before "snow_cover_" inclusive
    date <- as.Date(date_str, format = "%Y%m%d") # Converting string to date format
  })

  # Converting to date format
  dates <- as.Date(dates, origin = "1970-01-01")

  snow_animation <- function(raster_files_snow, date, country_name) {
    # Load the raster data
    snow_data <- stack(raster_files_snow)
    # Define color palette for the snow cover visualization
    palette <- c("#D3D3D3", "#4682B4")
    # Plot the snow cover image
    image(snow_data, col = palette, main = paste("Month snow cover changes in", country_name, format(date, "%Y-%m-%d")))
    # Add legend for snow cover classes
    legend("topright", legend = c("Snow free area", "Snow accumulation area"), fill = palette, bty = "n")
  }

  # Saving GIF animation
  saveGIF({
    for (i in seq_along(raster_files_snow)) {
      # Extracting date from file name

      # Displaying one frame of the animation
      snow_animation(raster_files_snow[i], dates[i], Country_name)

      Sys.sleep(1) # Delay in seconds between frames
    }
  }, interval = 1, movie.name = "snow_animation.gif")
}
