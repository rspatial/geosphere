\name{intermediate}
\Rdversion{1.1}

\alias{gcIntermediate}

\title{
Intermediate points on a great circle (sphere)
}

\description{
Get intermediate points (way points) between the two locations with longitude/latitude coordinates. gcIntermediate is based on a spherical model of the earth and internally uses \code{\link{distCosine}}. 
}

\usage{
gcIntermediate(p1, p2, n=50, breakAtDateLine=FALSE, addStartEnd=FALSE, 
				output=NULL, sepNA=FALSE, ...) 

}

\arguments{
  \item{p1}{longitude/latitude of a single point, in degrees. This can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a spatial points object from terra (SpatVector) of sf}
  \item{p2}{as for \code{p1}}
  \item{n}{integer. The desired number of intermediate points}
  \item{breakAtDateLine}{logical. Return two matrices if the dateline is crossed?}
  \item{addStartEnd}{logical. Add p1 and p2 to the result?}
  \item{output}{character. One of "list", "matrix", "sv" (SpatVector), "sf" or "sp". If \code{NULL}, the output is as in previous versions of this package for backwards compatibility}
  \item{sepNA}{logical. Separate matrix values for different points by a row of NA values? (e.g., for use in 'plot')}
  \item{...}{used for backwards compatibility, to pass arguments from previous versions of geosphere}
}


\value{
matrix or list with intermediate points
}

\references{
\url{https://www.edwilliams.org/avform147.htm#Intermediate}
}

\author{
Robert Hijmans based on code by Ed Williams (great circle)
}


\examples{
gcIntermediate(c(5,52), c(-120,37), n=6, addStartEnd=TRUE)
}

\keyword{ spatial }
