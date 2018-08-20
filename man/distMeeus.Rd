\name{distMeeus}
\Rdversion{1.1}

\alias{distMeeus}

\title{
'Meeus' great circle distance
}

\description{
The shortest distance between two points on an ellipsoid (the 'geodetic'), according to the 'Meeus' method. \code{\link{distGeo}} should be more accurate.
}

\usage{
distMeeus(p1, p2, a=6378137, f=1/298.257223563)
}

\arguments{
  \item{p1}{longitude/latitude of point(s), in degrees 1; can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{as above; or missing, in which case the sequential distance between the points in p1 is computed}
  \item{a}{numeric. Major (equatorial) radius of the ellipsoid. The default value is for WGS84 }
  \item{f}{numeric. Ellipsoid flattening. The default value is for WGS84 } 
}


\details{

Parameters from the WGS84 ellipsoid are used by default. It is the best available global ellipsoid, but for some areas other ellipsoids could be preferable, or even necessary if you work with a printed map that refers to that ellipsoid. Here are parameters for some commonly used ellipsoids:

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

\value{
Distance value in the same units as parameter \code{a} of the ellipsoid (default is meters)
}

\note{ This algorithm is also used in the \code{spDists} function in the sp package }

\references{
Meeus, J., 1999 (2nd edition). Astronomical algoritms. Willman-Bell, 477p.
}

\author{
Robert Hijmans, based on a script by Stephen R. Schmitt
}


\seealso{
\code{\link[geosphere]{distGeo}, \link{distVincentyEllipsoid}, \link{distVincentySphere}, \link{distHaversine}, \link{distCosine}}
}

\examples{
distMeeus(c(0,0),c(90,90))
# on a 'Clarke 1880' ellipsoid
distMeeus(c(0,0),c(90,90), a=6378249.145, f=1/293.465)
}

\keyword{ spatial }

