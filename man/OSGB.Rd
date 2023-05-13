\name{OSGB}

\alias{OSGB}

\title{
Ordnance Survey for Great Britain grid reference system
}

\description{
Convert coordinates to the grid reference system used by the Ordnance Survey for
Great Britain. Or do the inverse operation to get coordinates for a grid code.
}

\usage{
OSGB(xy, precision, inverse=FALSE)
}

\arguments{
 \item{xy}{xy coordinate pairs (vector, matrix, data.frame}. The coordinates must be in the OSGB36 / British National Grid coordinate reference system. EPSG:27700;  "+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 +ellps=airy +units=m")
 \item{precision}{number between 0 and 11. Level 0 refers to the 100 km grid, level 1 to the 10 km grid, level 2 to the 1 km grid, etc.} 
}


\value{
character
}


\author{
This function calls GeographicLib code by C.F.F. Karney
}

\references{
C.F.F. Karney, 2013. Algorithms for geodesics, J. Geodesy 87: 43-55. \doi{10.1007/s00190-012-0578-z}. Addenda: \url{https://geographiclib.sourceforge.io/geod-addenda.html}. Also see \url{https://geographiclib.sourceforge.io/}
}


\examples{
pnts <- rbind(cbind(93555 , 256188), 
			  cbind(210637, 349798),
			  cbind(696457, 481704))

g <- OSGB(pnts, 3)
g

OSGB(g, inverse=TRUE)

}

\keyword{ spatial }
