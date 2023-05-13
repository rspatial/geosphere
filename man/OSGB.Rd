\name{OSGB}

\alias{OSGB}

\title{
Ordnance Survey for Great Britain grid reference system
}

\description{
Convert coordinates to the grid reference system used by the Ordnance Survey for
Great Britain
}

\usage{
OSGB(xy, precision)
}

\arguments{
 \item{xy}{xy coordinate pairs (vector, matrix, data.frame}
 \item{precision}{number between 0 (500 km) and 11 (1 km)} 
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

OSGB(pnts, 3)
}

\keyword{ spatial }
