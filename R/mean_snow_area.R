#' Calculate the mean snow cover image from a stack of raster files
#' @rdname mean_snow_cover
#'
#' This function takes a list of raster files containing snow cover data and calculates
#' the mean snow cover image across all files in the stack
#'
#' @param raster_files_snow A list of raster files containing snow cover data
#'
#' @return The mean snow cover value
#'
#' @examples
#' mean_image <- mean_snow_cover(raster_files_snow)
#'
#' @export
mean_snow_cover <- function(raster_files_snow) {
  # Create a raster stack
  raster_stack <- rast(raster_files_snow)

  # Calculate the mean snow cover
  mean_snow_cover <- mean(raster_stack)

  return(mean_snow_cover)
}
