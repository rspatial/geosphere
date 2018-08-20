\name{gcIntersectBearing}
\Rdversion{1.1}

\alias{gcIntersectBearing}

\title{
Intersections of two great circles
}

\description{
Get the two points where two great cricles cross each other. In this function, great circles are defined by a points and an initial bearing. In function \code{ \link[geosphere]{gcIntersect}} they are defined by two sets of points.
}

\usage{
gcIntersectBearing(p1, brng1, p2, brng2) 
}

\arguments{
  \item{p1}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{brng1}{Bearing from p1}
  \item{p2}{As above. Should have same length as p1, or a single point (or vice versa when p1 is a single point}
  \item{brng2}{Bearing from p2}
}


\value{
a matrix with four columns (two points)
}


\seealso{
\code{ \link[geosphere]{gcIntersect}  }
}


\references{
\url{http://www.edwilliams.org/avform.htm#Intersection}

\url{http://www.movable-type.co.uk/scripts/latlong.html}
}

\author{
Chris Veness and Robert Hijmans based on code by Ed Williams
}


\examples{
gcIntersectBearing(c(10,0), 10, c(-10,0), 10)
}

\keyword{ spatial }
