\name{distRhumb}

\Rdversion{1.1}

\alias{distRhumb}

\title{
Distance along a rhumb line
}

\description{
A rhumb line (loxodrome) is a path of constant bearing (direction), which crosses all meridians at the same angle.
}

\usage{
distRhumb(p1, p2, r=6378137)
}

\arguments{
  \item{p1}{longitude/latitude of point(s). Can be a vector of two numbers, a matrix of 2 columns (first one is longitude, second is latitude) or a SpatialPoints* object}
  \item{p2}{as above; or missing, in which case the sequential distance between the points in p1 is computed}
  \item{r}{radius of the earth; default = 6378137 m}
}

\details{
Rhumb (from the Spanish word for course, 'rumbo') lines are straight lines on a Mercator projection map. They were used in navigation because it is easier to follow a constant compass bearing than to continually adjust the bearing as is needed to follow a great circle, even though rhumb lines are normally longer than great-circle (orthodrome) routes. Most rhumb lines will gradually spiral towards one of the poles.
}

\value{
distance in units of r (default=meters)
}

\references{
\url{https://www.movable-type.co.uk/scripts/latlong.html}
}

\author{
Robert Hijmans and Chris Veness
}

\seealso{
\code{\link[geosphere]{distCosine}, \link[geosphere]{distHaversine}, \link[geosphere]{distVincentySphere}, \link[geosphere]{distVincentyEllipsoid}}
}

\examples{
distRhumb(c(10,10),c(20,20))
}

\keyword{ spatial }

