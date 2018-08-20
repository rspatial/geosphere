\name{distCosine}
\Rdversion{1.1}

\alias{distCosine}

\title{
'Law of cosines' great circle distance
}

\description{
The shortest distance between two points (i.e., the 'great-circle-distance' or 'as the crow flies'), according to the 'law of the cosines'.
This method assumes a spherical earth, ignoring ellipsoidal effects.
}

\usage{
distCosine(p1, p2, r=6378137)
}

\arguments{
  \item{p1}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{as above}
  \item{r}{radius of the earth; default = 6378137 m}  
}


\value{
Vector of distances in the same unit as \code{r} (default is meters)
}

\references{
\url{http://en.wikipedia.org/wiki/Great_circle_distance}
}

\author{
Robert Hijmans
}

\seealso{
\code{\link[geosphere]{distGeo}, \link[geosphere]{distHaversine}, \link[geosphere]{distVincentySphere}, \link[geosphere]{distVincentyEllipsoid}, \link{distMeeus}}
}

\examples{
distCosine(c(0,0),c(90,90))
}

\keyword{ spatial }
