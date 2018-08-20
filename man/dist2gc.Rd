\name{dist2gc}
\Rdversion{1.1}

\alias{dist2gc}

\title{
Cross Track Distance
}

\description{
Compute the distance of a point to a great-circle path (also referred to as the cross track distance or cross track error). The great circle is defined by \code{p1} and \code{p2}, while \code{p3} is the point away from the path.
}

\usage{
dist2gc(p1, p2, p3, r=6378137, sign=FALSE)
}

\arguments{
  \item{p1}{Start of great circle path. longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{End of great circle path. As above}
  \item{p3}{Point away from the great cricle path. As for p2}
  \item{r}{radius of the earth; default = 6378137}  
  \item{sign}{logical. If \code{TRUE}, a negative sign is used to indicated that the points are to the left of the great circle}    
}


\value{
A distance in units of \code{r} (default is meters)
If \code{sign=TRUE}, the sign indicates which side of the path p3 is on. Positive  means right of the course from p1 to p2, negative means left.
}


\author{
Ed Williams and Robert Hijmans
}


\seealso{
\code{\link{dist2Line}, \link{alongTrackDistance}  }
}

\references{
\url{http://www.movable-type.co.uk/scripts/latlong.html}

\url{http://www.edwilliams.org/ftp/avsig/avform.txt}
}


\examples{
dist2gc(c(0,0),c(90,90),c(80,80))
}


\keyword{ spatial }
