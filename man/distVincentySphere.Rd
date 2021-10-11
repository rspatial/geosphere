\name{distVincentySphere}
\Rdversion{1.1}

\alias{distVincentySphere}

\title{
'Vincenty' (sphere) great circle distance
}

\description{
The shortest distance between two points (i.e., the 'great-circle-distance' or 'as the crow flies'), according to the 'Vincenty (sphere)' method. 
This method assumes a spherical earth, ignoring ellipsoidal effects and it is less accurate then the \code{distVicentyEllipsoid} method. 
}

\usage{
distVincentySphere(p1, p2, r=6378137)
}

\arguments{
  \item{p1}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{as above; or missing, in which case the sequential distance between the points in p1 is computed}
  \item{r}{radius of the earth; default = 6378137 m}  
}


\value{
Distance value in the same unit as \code{r} (default is meters)
}


\references{
\url{https://en.wikipedia.org/wiki/Great_circle_distance}
}

\author{
Robert Hijmans
}


\seealso{
\code{\link[geosphere]{distGeo}, \link[geosphere]{distVincentyEllipsoid}, \link[geosphere]{distHaversine}, \link[geosphere]{distCosine}, \link{distMeeus}}
}

\examples{
distVincentySphere(c(0,0),c(90,90))
}

\keyword{ spatial }

