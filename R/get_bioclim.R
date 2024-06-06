#' Worldclim 2.0 bioclimatic layers by continent
#'
#' @param continent The continent from which the bioclimatic layers are required
#' @return A SpatVector object with bioclimatic layers by continent
#' @export
#' @source WorldClim 2.0 project: \url{https://www.worldclim.org/}
#'
#' @examples
#' get_bioclim(continent = "test")
get_bioclim <- function(continent = "World"){
  if(continent == "test"){
    url_test <- "https://worldclim.nyc3.digitaloceanspaces.com/test"
    if (!url_exists(url_test)) {
      return("Can't access to bioclimatic data.")
    } else {
      return("Bioclimatic data is online")
    }
  }
  continent <- stringr::str_remove(continent, " ")

  allContinents <- unique(envData::continents$continent)
  allLayers <- unique(envData::envLayers$layer)

  matchContinent <- match(continent, allContinents)

  if( any(is.na( matchContinent) ) ){
    stop("Continent not found. Check spell")
  }

  if(is.null(continent)){
    continent = "World"
  }

  map_mdd_progress <- function(.x = allLayers, continent, ...) {
    pb <- progress::progress_bar$new(total = length(.x), format = " [:bar] :current/:total (:percent) eta: :eta", force = TRUE)

    f <- function(...) {
      pb$tick()
      get_bio_layer(...)
    }
    Map(f = f, .x, continent )
  }


  root <- system.file(package = "envData")
  filePath <- paste0(root, "/", "data/", continent)


  if(!file.exists(filePath)){
    MapList <- map_mdd_progress(.x = allLayers, continent = continent)
    rastList <- Reduce(c, MapList)
  } else if(length(list.files(filePath)!= 19)){
    MapList <- map_mdd_progress(.x = allLayers, continent = continent)
    rastList <- Reduce(c, MapList)
  } else {
    MapList <- Map(readr::read_rds, list.files(filePath, pattern = ".rds$", full.names = TRUE) )
    names(MapList) <- allLayers
    rastList <- Reduce(c, MapList)
  }
  return(rastList)

}
