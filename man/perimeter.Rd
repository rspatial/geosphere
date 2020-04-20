\name{perimeter}
\Rdversion{1.1}

\alias{perimeter}
\alias{perimeter,matrix-method}
\alias{perimeter,data.frame-method}
\alias{perimeter,SpatialPolygons-method}
\alias{perimeter,SpatialLines-method}
  

\title{
Compute the perimeter of a longitude/latitude polygon
}

\description{
Compute the perimeter of a polygon (or the length of a line) with longitude/latitude coordinates, on an ellipsoid (WGS84 by default) 
}

\usage{
\S4method{perimeter}{matrix}(x, a=6378137, f=1/298.257223563, ...)

\S4method{perimeter}{SpatialPolygons}(x, a=6378137, f=1/298.257223563, ...)

\S4method{perimeter}{SpatialLines}(x, a=6378137, f=1/298.257223563, ...)
}

\arguments{
 \item{x}{Longitude/latitude of the points forming a polygon or line; Must be a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPolygons* or SpatialLines* object}
 \item{a}{major (equatorial) radius of the ellipsoid. The default value is for WGS84 }
 \item{f}{ellipsoid flattening. The default value is for WGS84 }
 \item{...}{Additional arguments. None implemented}  
}

\value{
Numeric. The perimeter or length in m.
}

\seealso{
\code{ \link{areaPolygon}, \link[geosphere]{centroid}  }
}


\author{
This function calls GeographicLib code by C.F.F. Karney
}

\references{
C.F.F. Karney, 2013. Algorithms for geodesics, J. Geodesy 87: 43-55. \url{https://dx.doi.org/10.1007/s00190-012-0578-z}. Addenda: \url{http://geographiclib.sf.net/geod-addenda.html}. Also see \url{http://geographiclib.sourceforge.net/}
}


\examples{
xy <- rbind(c(-180,-20), c(-140,55), c(10, 0), c(-140,-60), c(-180,-20))
perimeter(xy)
}

\keyword{ spatial }

