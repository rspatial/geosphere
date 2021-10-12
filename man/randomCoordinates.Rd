\name{randomCoordinates}
\Rdversion{1.1}

\alias{randomCoordinates}
\alias{regularCoordinates}

\title{
Random or regularly distributed coordinates on the globe
}

\description{
randomCoordinates returns a 'uniform random sample' in the sense that the probability that a point is drawn from any region is equal to the area of that region divided by the area of the entire sphere. This would not happen if you took a random uniform sample of longitude and latitude, as the sample would be biased towards the poles.

regularCoordiaates returns a set of coordinates that are regularly distributed on the globe.
}

\usage{
randomCoordinates(n)
regularCoordinates(N)
}

\arguments{
  \item{n}{Sample size (number of points (coordinate pairs)) }
  \item{N}{Number of 'parts' in which the earth is subdived ) }
}

\value{
Matrix of lon/lat coordiantes
}


\author{
Robert Hijmans, based on code by Nils Haeck (regularCoordinates) and on suggstions by Michael Orion (randomCoordinates)
}

\examples{
randomCoordinates(3)
regularCoordinates(1)
}

\keyword{ spatial }
