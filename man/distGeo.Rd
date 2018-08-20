\name{distGeo}
\Rdversion{1.1}

\alias{distGeo}

\title{
Distance on an ellipsoid (the geodesic)
}

\description{
Highly accurate estimate of the shortest distance between two points on an ellipsoid (default is WGS84 ellipsoid).
The shortest path between two points on an ellipsoid is called the geodesic.
}

\usage{
distGeo(p1, p2, a=6378137, f=1/298.257223563)
}

\arguments{
 \item{p1}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first column is longitude, second column is latitude) or a SpatialPoints* object}
 \item{p2}{as above; or missing, in which case the sequential distance between the points in p1 is computed}
 \item{a}{numeric. Major (equatorial) radius of the ellipsoid. The default value is for WGS84 }
 \item{f}{numeric. Ellipsoid flattening. The default value is for WGS84 } 
}


\value{
Vector of distances in meters
}

\details{
Parameters from the WGS84 ellipsoid are used by default. It is the best available global ellipsoid, but for some areas other ellipsoids could be preferable, or even necessary if you work with a printed map that refers to that ellipsoid. Here are parameters for some commonly used ellipsoids. Also see the \code{\link{refEllipsoids}} function.

\tabular{rlll}{
 \tab \code{ ellipsoid          } \tab \code{ a            } \tab \code{ f               } \cr
 \tab \code{ WGS84	            } \tab \code{ 6378137      } \tab \code{ 1/298.257223563 } \cr
 \tab \code{ GRS80	            } \tab \code{ 6378137      } \tab \code{ 1/298.257222101 } \cr
 \tab \code{ GRS67              } \tab \code{ 6378160      } \tab \code{ 1/298.25        } \cr
 \tab \code{ Airy 1830          } \tab \code{ 6377563.396  } \tab \code{ 1/299.3249646   } \cr
 \tab \code{ Bessel 1841        } \tab \code{ 6377397.155  } \tab \code{ 1/299.1528434   } \cr
 \tab \code{ Clarke 1880        } \tab \code{ 6378249.145  } \tab \code{ 1/293.465       } \cr
 \tab \code{ Clarke 1866        } \tab \code{ 6378206.4    } \tab \code{ 1/294.9786982   } \cr
 \tab \code{ International 1924 } \tab \code{ 6378388      } \tab \code{ 1/297           } \cr
 \tab \code{ Krasovsky 1940     } \tab \code{ 6378245      } \tab \code{ 1/298.2997381   } \cr
}

more info: \url{http://en.wikipedia.org/wiki/Reference_ellipsoid}		
}


\author{
This function calls GeographicLib code by C.F.F. Karney
}

\references{
C.F.F. Karney, 2013. Algorithms for geodesics, J. Geodesy 87: 43-55. \url{https://dx.doi.org/10.1007/s00190-012-0578-z}. Addenda: \url{http://geographiclib.sf.net/geod-addenda.html}. Also see \url{http://geographiclib.sourceforge.net/}
}


\seealso{
\code{\link[geosphere]{distCosine}, \link[geosphere]{distHaversine}, \link[geosphere]{distVincentySphere}, \link[geosphere]{distVincentyEllipsoid}, \link{distMeeus}}
}

\examples{
distGeo(c(0,0),c(90,90))
}

\keyword{ spatial }
