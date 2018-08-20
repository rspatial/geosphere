\name{distm}
\Rdversion{1.1}

\alias{distm}

\title{
Distance matrix
}

\description{
Distance matrix of a set of points, or between two sets of points
}

\usage{
distm(x, y, fun=distGeo)
}

\arguments{
  \item{x}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{y}{Same as \code{x}. If missing, y is the same as x}
  \item{fun}{A function to compute distances (e.g., distCosine or distGeo)}  
}


\value{
Matrix of distances
}

\references{
\url{http://en.wikipedia.org/wiki/Great_circle_distance}
}

\author{
Robert Hijmans
}

\seealso{
\code{\link[geosphere]{distGeo}, \link[geosphere]{distCosine}, \link[geosphere]{distHaversine}, \link[geosphere]{distVincentySphere}, \link[geosphere]{distVincentyEllipsoid}}
}

\examples{
xy <- rbind(c(0,0),c(90,90),c(10,10),c(-120,-45))
distm(xy)
xy2 <- rbind(c(0,0),c(10,-10))
distm(xy, xy2)
}

\keyword{ spatial }
