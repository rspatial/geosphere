\name{gcLat}
\Rdversion{1.1}

\alias{gcLat}

\title{
Latitude on a Great Circle
}

\description{
Latitude at which a great circle crosses a longitude
}

\usage{
gcLat(p1, p2, lon) 
}

\arguments{
  \item{p1}{Longitude/latitude of a single point, in degrees; can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{As above}
  \item{lon}{Longitude}
}


\value{
A numeric (latitude)
}

\references{
\url{https://www.edwilliams.org/avform147.htm#Int}
}

\author{
Robert Hijmans based on a formula by Ed Williams
}

\seealso{
\code{\link[geosphere]{gcLon}, \link[geosphere]{gcMaxLat}}
}


\examples{
gcLat(c(5,52), c(-120,37), lon=-120)
}

\keyword{ spatial }
