\name{onGreatCircle}
\Rdversion{1.1}

\alias{onGreatCircle}

\title{
Is a point on a given great circle?
}

\description{
Test if a point is on a great circle defined by two other points.
}

\usage{
onGreatCircle(p1, p2, p3, tol=0.0001)
}

\arguments{
  \item{p1}{Longitude/latitude of the first point defining a great circle, in degrees; can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{as above for the second point}
  \item{p3}{the point(s) to be tested if they are on the great circle or not}
  \item{tol}{numeric. maximum distance from the great circle (in degrees) that is tolerated to be considered on the circle}  
}

\value{
logical
}

\author{
Robert Hijmans
}

\examples{
onGreatCircle(c(0,0), c(30,30), rbind(c(-10 -11.33812), c(10,20)))
}

\keyword{ spatial }

