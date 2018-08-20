\name{midPoint}

\Rdversion{1.1}

\alias{midPoint}

\title{Mid-point}

\description{
Find the point half-way between two points along an ellipsoid
}

\usage{
midPoint(p1, p2, a=6378137, f = 1/298.257223563)
}


\arguments{
  \item{p1}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{As above}
  \item{a}{major (equatorial) radius of the ellipsoid}
  \item{f}{ellipsoid flattening. The default value is for WGS84 }
}


\value{
matrix with coordinate pairs
}


\author{ Elias Pipping and Robert Hijmans }

\examples{
midPoint(c(0,0),c(90,90))  
midPoint(c(0,0),c(90,90), f=0)  
}

\keyword{spatial}

