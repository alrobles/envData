#' Function to return Worldclim layer
#' @importFrom utils download.file data
#' @param dir A directory where to write the output
#' @param layer The bioclimatic layer want to download
#' @param continent The continent from which the bioclimatic layers are required
#' @return A SpatRaster object with world bioclimatic raster
#' @export
#' @source WorldClim 2.0 project: \url{https://www.worldclim.org/}
#' get_bio_layer(layer = "test")
get_bio_layer <- function(layer, continent = "world", dir = NULL){

  if(layer == "test"){
    url_test <- "https://worldclim.nyc3.digitaloceanspaces.com/test"
    if (!url_exists(url_test)) {
      return("Can't access to bioclimatic data.")
    } else {
      return("Bioclimatic data is online")
    }
  }


  if(is.na(match(continent, envData::continents$continent))){
    stop("Continent does not exist! Check spell")
  }

  continent <- stringr::str_remove(continent, " ")

  if(is.na(match(layer, envData::envLayers$layer))){
    stop("layer does not exist! Check spell")
  }


  root <- system.file(package = "envData")

  filePath <- paste0(root, "/", "data/", continent, "/", layer, ".rds")

  if(!file.exists(filePath)){
    url <-
      paste0(
        "https://worldclim.nyc3.digitaloceanspaces.com/", continent, "/",
        layer,
        ".rds"
      )

    # check if the url exists
    if (!url_exists(url)) {
      return("Can't access environmental data.")
    }


    rastLayer <- readr::read_rds(url)
    if(!dir.exists( paste0(root, "/", "data/", continent) ) ){
      dir.create( paste0(root, "/", "data/", continent) )
    }


    readr::write_rds(rastLayer, file = filePath, compress = "xz")
  }
  else{
    rastLayer <- readr::read_rds(filePath)
  }

  if (!is.null(dir)) {

    if(!dir.exists(paste0(data, "/", continent))){
      dir.create(paste0(data, "/", continent))
    }

    readr::write_rds(rastLayer, file = paste0(dir,"/", continent, "/", layer, ".rds"), compress = "xz")
  }
  cat("")
  return(terra::unwrap(rastLayer))
}
