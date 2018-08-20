\name{destPointRhumb}
\Rdversion{1.1}
\alias{destPointRhumb}

\title{
Destination along a rhumb line
}

\description{
Calculate the destination point when travelling along a 'rhumb line' (loxodrome), given a start point, direction, and distance.
}

\usage{
destPointRhumb(p, b, d, r = 6378137)
}

\arguments{
  \item{p}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{b}{bearing (direction) in degrees}
  \item{d}{distance; in the same unit as \code{r} (default is meters)}
  \item{r}{radius of the earth; default = 6378137 m}  
}


\value{
Coordinates (longitude/latitude) of a point
}

\references{
\url{http://www.edwilliams.org/avform.htm#Rhumb}

\url{http://www.movable-type.co.uk/scripts/latlong.html}

\url{http://en.wikipedia.org/wiki/Rhumb_line}
}

\author{
Chris Veness; ported to R by Robert Hijmans
}


\seealso{
\code{ \link[geosphere]{destPoint}  }
}

\examples{
destPointRhumb(c(0,0), 30, 100000, r = 6378137)
}

\keyword{ spatial  }

