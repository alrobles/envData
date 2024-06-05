
<!-- README.md is generated from README.Rmd. Please edit that file -->

# envData: download bioclimatic data from WorldClim in R

<!-- badges: start -->
<!-- badges: end -->

envData aims to facilitate the interaction with
[WorldClim](https://worldclim.org/) data. It provides a simple interface
for downloading WorldClim bioclimatic layers in R, with support for
caching and filtering retrieved data by continent.

envData is designed for easy integration of bioclimatic data into
ecological niche model pipelines. It provides a simple interface for
accessing and filtering bioclimatic data.

## Installation

You can install the development version of envData from
[GitHub](https://github.com/alrobles/envData) using the
[remotes](https://github.com/r-lib/remotes) packages:

``` r
remotes::install_github("alrobles/envData")
```

## How it workds

The original bioclimatic data stored in
[WorldClim](https://worldclim.org/) is stored in
\[TIFF\]{<https://en.wikipedia.org/wiki/TIFF>} format. envData provides
a bridge to acces this data storing on a
[DigitalOcean](https://www.digitalocean.com/) [Space Object
Storage](https://docs.digitalocean.com/products/spaces/?_gl=1*7abst9*_ga*MTQ5MzA0NzA4NS4xNzE2NjE3MDQ1*_ga_TYR2BYTLL0*MTcxNzU3MDA0MC4xMy4xLjE3MTc1NzAwNzcuMjMuMC4w)
the original data as rds binary files ready to read by the
[terra](https://rspatial.github.io/terra/) R package. Additionally we
envData provides previously cropped layers by continent enhancing the
manipulaiton in the R environment.

This functionality significantly reduces the download and clipping time
of bioclimatic layers with a
[GIS](https://en.wikipedia.org/wiki/Geographic_information_system) in an
Ecological Niche Modelling pipeline.

![Figure 1. Package outline](./man/figures/envData_diagram.png) \##
Usage The R packages has two main R functions. \* `get_bio_layer`:
returns an specific bioclimatic layer (i. e. bio_18) for the entire
world (default) or for a given continent. We plot the output with the
help of the [terra](https://rspatial.github.io/terra/) R package:

``` r
library(envData)
library(terra) 
#> Warning: package 'terra' was built under R version 4.2.3
#> terra 1.7.39
```

``` r
test <- get_bio_layer("bio_10", "South America")
plot(test)
```

<img src="man/figures/README-example-1.png" width="100%" />

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

## Citation

Please follow the [instructions from the
authors](https://worldclim.org/data/worldclim21.html) when citing
WorldClim data. At time of writing, this includes a citation to the
paper the describing the WorldClim database:

- Fick, S.E. and R.J. Hijmans, 2017. \[WorldClim 2: new 1km spatial
  resolution climate surfaces for global land
  areas\]{<https://doi.org/10.1002/joc.5086>}. *International Journal of
  Climatology* 37 (12): 4302-4315.

Use `citation("envData")` for more details and the references in BibTeX
format.
