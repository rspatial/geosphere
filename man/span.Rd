\name{span}

\alias{span}
\alias{span,SpatialPolygons-method}
\alias{span,SpatVector-method}
\alias{span,sf-method}
\alias{span,matrix-method}
  
\title{Span of polygons}

\description{
Compute the approximate surface span of polygons in longitude and latitude direction. Span is computed by rasterizing the polygons; and precision increases with the number of 'scan lines'. You can either use a fixed number of scan lines for each polygon, or a fixed band-width.
}

\usage{
span(x, ...)
}

\arguments{
\item{x}{a SpatVector, sf, or SpatialPolygons* object or a 2-column matrix (longitude/latitude)}
\item{...}{Additional arguments, see Details}
}


\details{
The following additional arguments can be passed, to replace default values for this function
\tabular{rll}{
  \tab \code{nbands}  \tab Character. Method to determine the number of bands to 'scan' the polygon. Either 'fixed' or 'variable' \cr
  \tab \code{n} \tab Integer >= 1. If \code{nbands='fixed'}, how many bands should be used \cr
  \tab \code{res} \tab Numeric. If \code{nbands='variable'}, what should the bandwidth be (in degrees)? \cr
  \tab \code{fun} \tab Logical. A function such as mean or min. Mean computes the average span \cr
  \tab \code{...} \tab further additional arguments passed to distGeo\cr
 }
}


\value{
A list, or a matrix if a function \code{fun} is specified. Values are in the units of \code{r} (default is meter)
}

\author{Robert J. Hijmans }

\examples{
pol <- rbind(c(-180,-20), c(-160,5), c(-60, 0), c(-160,-60), c(-180,-20))
plot(pol)
lines(pol)
# lon and lat span in m
span(pol, fun=max) 
x <- span(pol) 
max(x$latspan)
mean(x$latspan)
plot(x$longitude, x$lonspan)
}

\keyword{methods}
\keyword{spatial}
