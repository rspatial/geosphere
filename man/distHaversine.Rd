\name{distHaversine}
\Rdversion{1.1}

\alias{distHaversine}

\title{
'Haversine' great circle distance
}

\description{
The shortest distance between two points (i.e., the 'great-circle-distance' or 'as the crow flies'), according to the 'haversine method'.
This method assumes a spherical earth, ignoring ellipsoidal effects.
}

\usage{distHaversine(p1, p2, r=6378137)
}

\arguments{
  \item{p1}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{as above; or missing, in which case the sequential distance between the points in p1 is computed}
  \item{r}{radius of the earth; default = 6378137 m}  
}


\details{
The Haversine ('half-versed-sine') formula was published by R.W. Sinnott in 1984, although it has been known  for much longer. At that time computational precision was lower than today (15 digits precision). With current precision, the spherical law of cosines formula appears to give equally good results down to very small distances. If you want greater accuracy, you could use the \code{\link[geosphere]{distVincentyEllipsoid}} method.
}

\value{
Vector of distances in the same unit as \code{r} (default is meters)
}


\references{
Sinnott, R.W, 1984. Virtues of the Haversine. Sky and Telescope 68(2): 159

\url{http://www.movable-type.co.uk/scripts/latlong.html}

\url{http://en.wikipedia.org/wiki/Great_circle_distance}
}

\author{
Chris Veness and Robert Hijmans
}


\seealso{
\code{\link[geosphere]{distGeo}, \link[geosphere]{distCosine}, \link[geosphere]{distVincentySphere}, \link[geosphere]{distVincentyEllipsoid}, \link{distMeeus}}
}

\examples{
distHaversine(c(0,0),c(90,90))
}

\keyword{ spatial }


