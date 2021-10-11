\name{antipode}
\Rdversion{1.1}

\alias{antipode}
\alias{antipodal}

\title{
Antipodes
}

\description{
Compute an antipode, or check whether two points are antipodes. Antipodes are places on Earth that are diametrically opposite to one another; 
and could be connected by a straight line through the centre of the Earth.

Antipodal points are connected by an infinite number of great circles (e.g. the meridians connecting the poles), and can therefore not be used in some great circle based computations.
}

\usage{
antipode(p)
antipodal(p1, p2, tol=1e-9)
}

\arguments{
  \item{p}{Longitude/latitude of a single point, in degrees; can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p1}{as above}
  \item{p2}{as above}
  \item{tol}{tolerance for equality}
}

\value{
antipodal points or a logical value (\code{TRUE} if antipodal)
}

\references{
\url{https://en.wikipedia.org/wiki/Antipodes}
}

\author{ Robert Hijmans }


\examples{
antipode(rbind(c(5,52), c(-120,37), c(-60,0), c(0,70)))
antipodal(c(0,0), c(180,0))
}

\keyword{ spatial }

