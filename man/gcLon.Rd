\name{gcLon}
\Rdversion{1.1}

\alias{gcLon}


\title{
Longitude on a Great Circle
}

\description{
Longitudes at which a great circle crosses a latitude (parallel)
}

\usage{
gcLon(p1, p2, lat) 
}

\arguments{
  \item{p1}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{as above}
  \item{lat}{a latitude}
}


\value{
vector of two numbers (longitudes) 
}

\references{
\url{http://www.edwilliams.org/avform.htm#Intersection}
}

\author{
Robert Hijmans based on code by Ed Williams
}

\seealso{
\code{\link[geosphere]{gcLat}, \link[geosphere]{gcMaxLat}}
}


\examples{
gcLon(c(5,52), c(-120,37), 40)
}

\keyword{ spatial }
