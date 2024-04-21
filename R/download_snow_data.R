#' Download daily snow cover images from the DLR Global Snow Product (GSP) service
#' @rdname download_snow_data
#' This function downloads daily snow cover images from the specified start date to the specified end date.
#'
#' This function generates URLs for downloading snow cover data for each date in the specified range.
#'
#' @param  start_date The start date in the format as.Date("YYYY-MM-DD")
#' @param  end_date The end date in the format as.Date("YYYY-MM-DD")
#' @param  save_dir The directory path where the downloaded files will be saved.
#'
#' @return Nothing. The images are saved to the specified directory.
#'
#' @examples
#' start_date <- as.Date("2023-01-01")
#' end_date <- as.Date("2023-01-31")
#' download_snow_data(start_date, end_date, "path/to/save/directory")
#'
#' @importFrom httr GET
#' @importFrom purrr walk
#' @importFrom httr http_status
#' @importFrom httr content
#'
#' @export
download_snow_data <- function(start_date, end_date, save_dir) {
  base_url <- "https://download.geoservice.dlr.de/GSP/files/daily/SCE/"

  # Iterating over each date in the specified range
  dates <- seq(start_date, end_date, by = "day")
  purrr::walk(dates, function(date) {
    # Constructing the URL for the current date
    year <- format(date, "%Y")
    month <- format(date, "%m")
    day <- format(date, "%d")
    url <- paste0(base_url, year, "/LIN10A1.", year, month, day, "_wgs84.tif")

    # Determining the file name based on the date
    filename <- paste0("snow_cover_", year, month, day, ".tif")

    # Path to save the file
    save_path <- file.path(save_dir, filename)

    # Executing a GET request to download data with a delay of 1 second
    Sys.sleep(1)
    response <- httr::GET(url)

    # Checking the success of the request
    if (httr::http_status(response)$category == "Success") {
      # Saving the data to the specified file
      content <- httr::content(response, "raw")
      writeBin(content, save_path)
      cat("File successfully downloaded and saved: ", save_path, "\n")
    } else {
      warning("Failed to download file for date: ", format(date, "%Y-%m-%d"))
    }
  })
}
