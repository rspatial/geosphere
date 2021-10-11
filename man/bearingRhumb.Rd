\name{bearingRhumb}

\Rdversion{1.1}

\alias{bearingRhumb}

\title{
Rhumbline direction
}

\description{
Bearing (direction of travel; true course) along a rhumb line (loxodrome) between two points. 
}

\usage{
bearingRhumb(p1, p2)
}

\arguments{
  \item{p1}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{as above}
}


\value{
A direction (bearing) in degrees
}

\references{
\url{https://www.edwilliams.org/avform.htm#Rhumb}

\url{https://en.wikipedia.org/wiki/Rhumb_line}
}

\author{
Chris Veness and Robert Hijmans, based on formulae by Ed Williams
}

\note{
Unlike most great circles, a rhumb line is a line of constant bearing (direction), i.e. tracks of constant true course.
The meridians and the equator are both rhumb lines and great circles. Rhumb lines approaching a pole become a tightly wound spiral.
}

\seealso{
\code{ \link[geosphere]{bearing},  \link[geosphere]{distRhumb}  }
}

\examples{
bearingRhumb(c(10,10),c(20,20))
}

\keyword{ spatial }

