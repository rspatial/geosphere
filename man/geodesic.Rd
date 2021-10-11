\name{geodesic}
\Rdversion{1.1}

\alias{geodesic}
\alias{geodesic_inverse}

\title{
geodesic and inverse geodesic problem
}

\description{
Highly accurate estimate of the 'geodesic problem' (find location and azimuth at arrival when departing from a location, given an  direction (azimuth) at departure and distance) and the 'inverse geodesic problem' (find the distance between two points and the azimuth of departure and arrival for the shortest path. Computations are for an ellipsoid (default is WGS84 ellipsoid). 

This is a direct implementation of the the GeographicLib code by C.F.F. Karney that is also used in several other functions in this package (for example, in \code{\link{distGeo}} and \code{\link{areaPolygon}}).
}

\usage{
geodesic(p, azi, d, a=6378137, f=1/298.257223563, ...)

geodesic_inverse(p1, p2, a=6378137, f=1/298.257223563, ...)
}

\arguments{
 \item{p}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first column is longitude, second column is latitude) or a SpatialPoints* object}
 \item{p1}{as above}
 \item{p2}{as above}
 \item{azi}{numeric. Azimuth of departure in degrees}
 \item{d}{numeric. Distance in meters}
 \item{a}{numeric. Major (equatorial) radius of the ellipsoid. The default value is for WGS84 }
 \item{f}{numeric. Ellipsoid flattening. The default value is for WGS84 } 
 \item{...}{additional arguments (none implemented)}
}


\value{
Three column matrix with columns 'longitude', 'latitude', 'azimuth' (geodesic); or 'distance' (in meters), 'azimuth1' (of departure), 'azimuth2' (of arrival) (geodesic_inverse) 
}

\details{
Parameters from the WGS84 ellipsoid are used by default. It is the best available global ellipsoid, but for some areas other ellipsoids could be preferable, or even necessary if you work with a printed map that refers to that ellipsoid. Here are parameters for some commonly used ellipsoids.

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

more info: \url{https://en.wikipedia.org/wiki/Reference_ellipsoid}		
}


\author{
This function calls GeographicLib code by C.F.F. Karney
}

\references{
C.F.F. Karney, 2013. Algorithms for geodesics, J. Geodesy 87: 43-55. \doi{10.1007/s00190-012-0578-z}. Addenda: \url{https://geographiclib.sourceforge.io/geod-addenda.html}. Also see \url{https://geographiclib.sourceforge.io/}
}


\seealso{
\code{\link{distGeo}}
}

\examples{
geodesic(cbind(0,0), 30, 1000000)
geodesic_inverse(cbind(0,0), cbind(90,90))
}

\keyword{ spatial }
