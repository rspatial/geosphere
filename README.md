# geosphere

[![CRAN
status](https://www.r-pkg.org/badges/version/geosphere)](https://cran.r-project.org/package=geosphere)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/geosphere)](http://www.r-pkg.org/pkg/geosphere)


`geosphere` is an *R* package for sphereical computation. There are tutorials at [rspatial.org](https://rspatial.org/raster/sphere/index.html). 


## Installation

`geosphere` is available from CRAN, so you can use `install.packages("geosphere")` to get the current *released version*.

The easiest way to use the *development version* on Windows or MacOS, is to install it from the [R-universe](https://r-universe.dev/organizations/), like this:


```
install.packages('geosphere', repos='https://rspatial.r-universe.dev')
```


### From source-code

In R, you can install the package like this.

```
remotes::install_github("rspatial/geosphere")
```

On Windows, you need to first install [Rtools](https://cran.r-project.org/bin/windows/Rtools/) to get a C++ compiler that R can use. 

