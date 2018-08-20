\name{makePoly}

\alias{makePoly}
\alias{makeLine}
  
\title{Add vertices to a polygon or line}

\description{
Make a polygon or line by adding intermedate points (vertices) on the great circles inbetween the points supplied. This can be relevant when vertices are relatively far apart. 
It can make the shape of the object to be accurate, when plotted on a plane. \code{makePoly} will also close the polygon if needed.
}

\usage{
makePoly(p, interval=10000, sp=FALSE, ...)
makeLine(p, interval=10000, sp=FALSE, ...)
}

\arguments{
\item{p}{a 2-column matrix (longitude/latitude) or a SpatialPolygons or SpatialLines object}
\item{interval}{maximum interval of points, in units of r}
\item{sp}{Logical. If \code{TRUE}, a SpatialPolygons object is retunred (depends on the 'sp' package)}
\item{...}{additional arguments passed to distGeo}  
}


\value{
A matrix 
}

\author{Robert J. Hijmans }

\examples{
pol <- rbind(c(-180,-20), c(-160,5), c(-60, 0), c(-160,-60), c(-180,-20))
plot(pol)
lines(pol, col='red', lwd=3)
pol2 = makePoly(pol, interval=100000)
lines(pol2, col='blue', lwd=2)
}

\keyword{methods}
\keyword{spatial}
