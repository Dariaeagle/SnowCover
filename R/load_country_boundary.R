#' load_country_boundary
#'
#' #Load the boundary of a specific country from a map object
#' #This function extracts the boundary geometry of a specific country from a map
#' #object and returns it
#'
#'
#' @param map A spatial object containing country boundaries, such as a 'sf' object
#' @param country_name The name of the country whose boundary is to be loaded
#'
#' @return A geometry object representing the boundary of the specified country
#' @export
#'
#' @examples
#' library(sf)
#' map <- ne_download(scale = 10, returnclass = "sf")
#' country_boundary <- load_country_boundary(map, "Denmark")
#' plot(country_boundary)
#'
#' @importFrom sf st_geometry
#' @importFrom rnaturalearth ne_download
#' @importFrom dplyr filter
#'
#' @export
load_country_boundary <- function(map, country_name) {
  # Select the boundary of the specified country
  country_boundary <- dplyr::filter(map, ADMIN == country_name)

  # Check if the boundary is found
  if (nrow(country_boundary) == 0) {
    stop(paste("Boundary for", country_name, "not found in the provided map"))
  }

  # Extract the geometry of the boundary
  return(sf::st_geometry(country_boundary))
}
