#' crop_rasters
#'
#' #This function crops raster files based on the boundary of a country
#'
#' @param raster_files A character vector containing paths to the raster files to be cropped
#' @param country_boundary The boundary of the country as a SpatialPolygonsDataFrame or sf object
#' @param output_dir The directory where the cropped raster files will be saved
#'
#' @return None
#'
#' @importFrom raster raster writeRaster
#' @importFrom terra crop mask
#' @importFrom sf st_as_sf
#'
#'
#' @examples
#' raster_files <- list.files("path/to/raster/files", pattern = "\\.tif$", full.names = TRUE)
#' output_dir <- "path/to/output/directory"
#' crop_rasters(raster_files, country_boundary, output_dir)
#'
#' @export
crop_rasters <- function(raster_files, country_boundary, output_dir) {
  for (raster_file in raster_files) {
    raster_b <- raster::raster(raster_file)
    country_boundary1 <- st_as_sf(country_boundary)
    clipped_raster <- terra::crop(raster_b, country_boundary1)
    masked_clipped_raster <- terra::mask(clipped_raster, country_boundary1)
    output_file <- file.path(output_dir, paste0(basename(raster_file), "_clipped.tif"))
    raster::writeRaster(masked_clipped_raster, output_file, overwrite = TRUE)
    cat("Raster", basename(raster_file), "successfully cropped\n")
  }
}
