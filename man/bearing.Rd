\name{bearing}
\Rdversion{1.1}

\alias{bearing}

\title{
Direction of travel
}

\description{
Get the initial bearing (direction; azimuth) to go from point \code{p1} to point \code{p2} (in longitude/latitude) following the shortest path on an ellipsoid (geodetic). Note that the bearing of travel changes continuously while going along the path. A route with constant bearing is a rhumb line (see  \code{\link[geosphere]{bearingRhumb}}).
}

\usage{
bearing(p1, p2, a=6378137, f=1/298.257223563)
}

\arguments{
  \item{p1}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{as above. Can also be missing, in which case the bearing is computed going from the first point to the next and continuing along the following points}
   \item{a}{major (equatorial) radius of the ellipsoid. The default value is for WGS84 }
  \item{f}{ellipsoid flattening. The default value is for WGS84 }
}


\note{use \code{f=0} to get a bearing on a sphere (great circle)}

\value{
Bearing in degrees
}


\author{
Robert Hijmans
}

\references{
C.F.F. Karney, 2013. Algorithms for geodesics, J. Geodesy 87: 43-55. \url{https://dx.doi.org/10.1007/s00190-012-0578-z}. Addenda: \url{http://geographiclib.sf.net/geod-addenda.html}. Also see \url{http://geographiclib.sourceforge.net/}
}


\seealso{
\code{ \link[geosphere]{bearingRhumb}  }
}


\examples{
bearing(c(10,10),c(20,20))
}


\keyword{ spatial }

