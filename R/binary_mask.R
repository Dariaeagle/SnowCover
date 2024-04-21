#' Apply a binary mask to raster data
#' All data in Global Snow pack is stored as 8-bit unsigned integers.
#' The binary mask is created by setting all values below 64 to 0 and all values above or equal to 64 to 1.
#'
#' This function takes a binary mask and a list of raster data to which the mask should be applied.
#' It applies the binary mask to all the rasters and saves the results.
#'
#' @param binary_mask The raster data of the binary mask.
#' @param clipped list.files("path/to/raster/files", pattern = "\\.tif$", full.names = TRUE)
#' @param output_folder <- "path/to/output/directory"
#'
#' @return Nothing. The results are saved in the specified directory.
#'
#' @examples
#' binary_mask(binary_mask, clipped, "path/to/output/directory")
#'
#' @importFrom raster raster
#'
#'
#' @export
binary_mask <- function(binary_mask, clipped, output_folder) {
  for (raster_file in clipped) {
    raster_data_m <- raster(raster_file)
    binary_mask <- raster_data_m
    binary_mask[binary_mask < 64] <- 0
    binary_mask[binary_mask >= 64] <- 1
    output_file <- file.path(output_folder, gsub("_clipped.tif", "_masked.tif", basename(raster_file)))
    writeRaster(binary_mask, output_file, overwrite = TRUE)
    cat("Binary mask applied to '", basename(raster_file), "' and saved as '", basename(output_file), "'\n")
  }
}
