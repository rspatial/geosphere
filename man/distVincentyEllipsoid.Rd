\name{distVincentyEllipsoid}
\Rdversion{1.1}

\alias{distVincentyEllipsoid}

\title{
'Vincenty' (ellipsoid) great circle distance
}

\description{
The shortest distance between two points (i.e., the 'great-circle-distance' or 'as the crow flies'), according to the 'Vincenty (ellipsoid)' method. 
This method uses an ellipsoid and the results are very accurate. The method is computationally more intensive than the other great-circled methods in this package. 
}

\usage{
distVincentyEllipsoid(p1, p2, a=6378137, b=6356752.3142, f=1/298.257223563)
}

\arguments{
  \item{p1}{longitude/latitude of point(s), in degrees 1; can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{as above; or missing, in which case the sequential distance between the points in p1 is computed}
  \item{a}{Equatorial axis of ellipsoid}
  \item{b}{Polar axis of ellipsoid}
  \item{f}{Inverse flattening of ellipsoid}
}

\details{

The WGS84 ellipsoid is used by default. It is the best available global ellipsoid, but for some areas other ellipsoids could be preferable, or even necessary if you work with a printed map that refers to that ellipsoid. Here are parameters for some commonly used ellipsoids:

\tabular{rllll}{
 \tab \code{ ellipsoid          } \tab \code{ a            } \tab \code{ b              } \tab \code{ f               } \cr
 \tab \code{ WGS84	            } \tab \code{ 6378137      } \tab \code{ 6356752.3142   } \tab \code{ 1/298.257223563 } \cr
 \tab \code{ GRS80	            } \tab \code{ 6378137      } \tab \code{ 6356752.3141   } \tab \code{ 1/298.257222101 } \cr
 \tab \code{ GRS67              } \tab \code{ 6378160      } \tab \code{ 6356774.719    } \tab \code{ 1/298.25        } \cr
 \tab \code{ Airy 1830          } \tab \code{ 6377563.396  } \tab \code{ 6356256.909    } \tab \code{ 1/299.3249646   } \cr
 \tab \code{ Bessel 1841        } \tab \code{ 6377397.155  } \tab \code{ 6356078.965    } \tab \code{ 1/299.1528434   } \cr
 \tab \code{ Clarke 1880        } \tab \code{ 6378249.145  } \tab \code{ 6356514.86955  } \tab \code{ 1/293.465       } \cr
 \tab \code{ Clarke 1866        } \tab \code{ 6378206.4    } \tab \code{ 6356583.8      } \tab \code{ 1/294.9786982   } \cr
 \tab \code{ International 1924 } \tab \code{ 6378388      } \tab \code{ 6356911.946    } \tab \code{ 1/297           } \cr
 \tab \code{ Krasovsky 1940     } \tab \code{ 6378245      } \tab \code{ 6356863        } \tab \code{ 1/298.2997381   } \cr
}

\code{a} is the 'semi-major axis', and \code{b} is the 'semi-minor axis' of the ellipsoid. \code{f} is the flattening.
Note that \code{f = (a-b)/a}

more info: \url{https://en.wikipedia.org/wiki/Reference_ellipsoid}
				
}

\value{
Distance value in the same units as the ellipsoid (default is meters)
}


\references{
Vincenty, T. 1975. Direct and inverse solutions of geodesics on the ellipsoid with application of nested equations. Survey Review Vol. 23, No. 176, pp88-93.
Available here: 

\url{https://www.movable-type.co.uk/scripts/latlong-vincenty.html}

\url{https://en.wikipedia.org/wiki/Great_circle_distance}
}

\author{
Chris Veness and Robert Hijmans
}


\seealso{
\code{\link[geosphere]{distGeo}, \link{distVincentySphere}, \link{distHaversine}, \link{distCosine}, \link{distMeeus}}
}

\examples{
distVincentyEllipsoid(c(0,0),c(90,90))
# on a 'Clarke 1880' ellipsoid
distVincentyEllipsoid(c(0,0),c(90,90), a=6378249.145, b=6356514.86955, f=1/293.465)
}

\keyword{ spatial }

