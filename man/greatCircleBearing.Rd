\name{greatCircleBearing}
\Rdversion{1.1}

\alias{greatCircleBearing}

\title{
Great circle
}

\description{
Get points on a great circle as defined by a point and an initial bearing
}

\usage{
greatCircleBearing(p, brng, n=360) 
}

\arguments{
  \item{p}{longitude/latitude of a single point. Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{brng}{bearing}
  \item{n}{The requested number of points on the great circle}
}


\value{
A matrix of points, or a list of matrices (e.g., if multiple bearings are supplied) 
}

\references{
\url{http://www.edwilliams.org/avform.htm#Int}
}

\author{
Robert Hijmans based on formulae by Ed Williams
}


\examples{
greatCircleBearing(c(5,52), 45, n=12)
}

\keyword{ spatial }
