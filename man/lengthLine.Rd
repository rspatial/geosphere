\name{lengthLine}

\alias{lengthLine}

\title{
Length of lines
}

\description{
Compute the length of lines
}

\usage{
lengthLine(line)
}

\arguments{
  \item{line}{longitude/latitude of line as a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialLines* or SpatialPolygons* object}
}


\value{
length (in meters) for each line 
}


\seealso{
For planar coordinates, see \code{\link[rgeos]{gLength}}
}


\examples{
line <- rbind(c(-180,-20), c(-150,-10), c(-140,55), c(10, 0), c(-140,-60))
d <- lengthLine(line)
}

\keyword{ spatial }

