\name{geomean}

\docType{methods}

\alias{geomean}

\title{ 
Mean location of sperhical coordinates
}

\description{
mean location for spherical (longitude/latitude) coordinates that deals with the angularity. I.e., the mean of longitudes -179 and 178 is 179.5
}

\usage{
geomean(xy, w)
}

\arguments{
  \item{xy}{matrix with two columns (longitude/latitude), or a SpatialPoints or SpatialPolygons object with a longitude/latitude CRS}
  \item{w}{weights (vector of numeric values, with a length that is equal to the number of spatial features in \code{x}}
}

\value{
Ccoordinate pair (numeric)
}


\examples{
xy <- cbind(x=c(-179,179, 177), y=c(12,14,16))
xy
geomean(xy)
}

\author{Robert J. Hijmans}

\keyword{methods}
\keyword{spatial}

