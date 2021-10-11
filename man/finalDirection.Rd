\name{finalBearing}
\Rdversion{1.1}

\alias{finalBearing}

\title{
Final direction
}

\description{
Get the final direction (bearing) when arriving at \code{p2} after starting from \code{p1} and following the shortest path on an ellipsoid (following a geodetic) or on a sphere (following a great circle).
}

\usage{
finalBearing(p1, p2, a=6378137, f=1/298.257223563, sphere=FALSE)
}

\arguments{
  \item{p1}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first column is longitude, second column is latitude) or a SpatialPoints* object}
  \item{p2}{as above}
  \item{a}{major (equatorial) radius of the ellipsoid. The default value is for WGS84 }
  \item{f}{ellipsoid flattening. The default value is for WGS84 }
  \item{sphere}{logical. If \code{TRUE}, the bearing is computed for a sphere, instead of for an ellipsoid}  
}

\value{
A vector of directions (bearings) in degrees
}

\examples{
bearing(c(10,10),c(20,20))
finalBearing(c(10,10),c(20,20))
}

\author{
This function calls GeographicLib code by C.F.F. Karney
}

\references{
C.F.F. Karney, 2013. Algorithms for geodesics, J. Geodesy 87: 43-55. \doi{10.1007/s00190-012-0578-z}. Addenda: \url{https://geographiclib.sourceforge.io/geod-addenda.html}. Also see \url{https://geographiclib.sourceforge.io/}
}

\seealso{
\code{ \link[geosphere]{bearing}  }
}

\keyword{ spatial }

