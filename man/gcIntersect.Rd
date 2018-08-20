\name{gcIntersect}
\Rdversion{1.1}

\alias{gcIntersect}

\title{
Intersections of two great circles
}

\description{
Get the two points where two great cricles cross each other. Great circles are defined by two points on it.
}

\usage{
gcIntersect(p1, p2, p3, p4) 
}

\arguments{
  \item{p1}{Longitude/latitude of a single point, in degrees; can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{As above}
  \item{p3}{As above}
  \item{p4}{As above}
}


\value{
two points for each pair of great circles
}


\seealso{
\code{ \link[geosphere]{gcIntersectBearing}  }
}


\references{
\url{http://www.edwilliams.org/intersect.htm}
}

\author{
Robert Hijmans, based on equations by Ed Williams (see reference)
}


\examples{
p1 <- c(5,52); p2 <- c(-120,37); p3 <- c(-60,0); p4 <- c(0,70)
gcIntersect(p1,p2,p3,p4)
}

\keyword{ spatial }
