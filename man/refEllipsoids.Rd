\name{refEllipsoids}

\alias{refEllipsoids}
  
\title{Reference ellipsoids}

\description{
This function returns a data.frame with parameters \code{a} (semi-major axis) and \code{1/f} (inverse flattening) for a set of reference ellipsoids.
}

\usage{
refEllipsoids()
}

\note{
To compute parameter \code{b} you can do  
}	

\value{
data.frame
}

\seealso{
\code{ \link[geosphere]{area}, \link[geosphere]{perimeter}  }
}


\author{Robert J. Hijmans }

\examples{
e <- refEllipsoids()
e[e$code=='WE', ]

#to compute semi-minor axis b:
e$b <- e$a - e$a / e$invf
}

\keyword{methods}
\keyword{spatial}
