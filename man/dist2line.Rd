\name{dist2Line}
\Rdversion{1.1}

\alias{dist2Line}

\title{
Distance between points and lines or the border of polygons.
}

\description{
The shortest distance between points and polylines or polygons. 
}

\usage{dist2Line(p, line, distfun=distGeo)
}

\arguments{
  \item{p}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{line}{longitude/latitude of line as a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialLines* or SpatialPolygons* object}
  \item{distfun}{A distance function, such as \link[geosphere]{distGeo}}  
}


\value{
matrix with distance and lon/lat of the nearest point on the line. Distance is in the same unit as \code{r} in the \code{distfun}(default is meters). If \code{line} is a \code{Spatial*} object, the ID (index) of (one of) the nearest objects is also returned. Thus if the objects are polygons and the point is inside a polygon the function may return the ID of a neighboring polygon that shares the nearest border. You can use the \code{over} functions in packages \code{sp} or \code{rgeos} for point-in-polygon queries.
}

\author{
George Wang and Robert Hijmans
}

\seealso{
\code{\link{dist2gc}, \link{alongTrackDistance}  }
}



\examples{
line <- rbind(c(-180,-20), c(-150,-10), c(-140,55), c(10, 0), c(-140,-60))
pnts <- rbind(c(-170,0), c(-75,0), c(-70,-10), c(-80,20), c(-100,-50), 
         c(-100,-60), c(-100,-40), c(-100,-20), c(-100,-10), c(-100,0))
d = dist2Line(pnts, line)
plot( makeLine(line), type='l')
points(line)
points(pnts, col='blue', pch=20)
points(d[,2], d[,3], col='red', pch='x')
for (i in 1:nrow(d)) lines(gcIntermediate(pnts[i,], d[i,2:3], 10), lwd=2)
}

\keyword{ spatial }

