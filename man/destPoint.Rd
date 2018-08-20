\name{destPoint}

\Rdversion{1.1}

\alias{destPoint}

\title{
Destination given bearing (direction) and distance
}

\description{
Given a start point, initial bearing (direction), and distance, this function computes the destination point travelling along a the shortest path on an ellipsoid (the geodesic).
}

\usage{
destPoint(p, b, d, a=6378137, f=1/298.257223563, ...)
}

\arguments{
  \item{p}{Longitude and Latitude of point(s), in degrees. Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{b}{numeric. Bearing (direction) in degrees}
  \item{d}{numeric. Distance in meters}
  \item{a}{major (equatorial) radius of the ellipsoid. The default value is for WGS84 }
  \item{f}{ellipsoid flattening. The default value is for WGS84 } 
  \item{...}{additional arguments. If an argument 'r' is supplied, this is taken as the radius of the earth (e.g. 6378137 m) and computations are for a sphere (great circle) instead of an ellipsoid (geodetic). This is for backwards compatibility only}    
}


\note{
Direction changes continuously when travelling along a geodesic. Therefore, the final direction is not the same as the initial direction. You can compute the final direction with \code{\link[geosphere]{finalBearing}} (see examples, below)
}


\value{
A pair of coordinates (longitude/latitude)
}

\author{
This function calls GeographicLib code by C.F.F. Karney
}

\references{
C.F.F. Karney, 2013. Algorithms for geodesics, J. Geodesy 87: 43-55. \url{https://dx.doi.org/10.1007/s00190-012-0578-z}. Addenda: \url{http://geographiclib.sf.net/geod-addenda.html}. Also see \url{http://geographiclib.sourceforge.net/}
}


\examples{
p <- cbind(5,52)
d <- destPoint(p,30,10000)
d

#final direction, when arriving at endpoint: 
finalBearing(d, p)
}

\keyword{ spatial  }

