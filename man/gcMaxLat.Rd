\name{gcMaxLat}
\Rdversion{1.1}

\alias{gcMaxLat}


\title{
Highest latitude on a great circle
}

\description{
What is northern most point that will be reached when following a great circle? Computed with Clairaut's formula. The southern most point is the \code{\link[geosphere]{antipode}} of the northern-most point. This does not seem to be very precise; and you could use optimization instead to find this point (see examples)
}

\usage{
gcMaxLat(p1, p2)
}

\arguments{
  \item{p1}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{as above}
}


\value{
A matrix with coordinates (longitude/latitude)
}

\references{
\url{https://www.edwilliams.org/ftp/avsig/avform.txt}

\url{https://www.movable-type.co.uk/scripts/latlong.html}
}

\author{
Ed Williams, Chris Veness, Robert Hijmans
}

\seealso{
\code{\link[geosphere]{gcLat}, \link[geosphere]{gcLon}}
}


\examples{
gcMaxLat(c(5,52), c(-120,37))

# Another way to get there:
f <- function(lon){gcLat(c(5,52), c(-120,37), lon)}
optimize(f, interval=c(-180, 180), maximum=TRUE)
}

\keyword{ spatial  }

