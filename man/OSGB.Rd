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
OSGB(xy, precision, geo=FALSE, inverse=FALSE)
}

\arguments{
 \item{xy}{x coordinate pairs (vector, matrix, data.frame}; or grid codes if \code{inverse=TRUE}.
 \item{precision}{character. One of "1m", "5m", "10m", "50m", "100m", "500m", "1km", "5km", "10km", "50km", "100km", "500km"} 
 \item{geo}{If \code{TRUE} the input coordinates are in longitude/latitude (on the airy ellipsoid!). If \code{FALSE} they must be in the "OSGB36 / British National Grid" coordinate reference system ("EPSG:27700" or "+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 +ellps=airy +units=m")}
 \item{inverse}{If \code{TRUE}, coordinates are computed for the grid codes in \code{x}} 
}


\value{
character
}


\examples{
pnts <- rbind(cbind(93555 , 256188), 
			  cbind(210637, 349798),
			  cbind(696457, 481704))

g <- OSGB(pnts, "1km", geo=FALSE)
g

OSGB(g, inverse=TRUE)
}

\keyword{ spatial }
