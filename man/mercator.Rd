\name{mercator}

\Rdversion{1.1}

\alias{mercator}

\title{
Mercator projection
}

\description{
Transform longitude/latiude points to the Mercator projection. The main purpose of this function is to compute centroids, and to illustrate rhumb lines in the vignette.
}

\usage{
mercator(p, inverse=FALSE, r=6378137) 
}

\arguments{
  \item{p}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{inverse}{Logical. If \code{TRUE}, do the inverse projection (from Mercator to longitude/latitude}   
  \item{r}{Numeric. Radius of the earth; default = 6378137 m} 
}

\value{
matrix
}

\author{ Robert Hijmans }

\examples{
a = mercator(c(5,52))
a
mercator(a, inverse=TRUE)
}

\keyword{ spatial }
