\name{daylength}

\alias{daylength}

\title{ Daylength }
\description{
Compute daylength (photoperiod) for a latitude and date.
}

\usage{
daylength(lat, doy)
}

\arguments{
\item{lat}{latitude, in degrees. I.e. between -90.0 and 90.0 }
\item{doy}{integer, day of the year (1..365) for common (non-leap) years; or an object of class Date; or a character that can be coerced into a date, using 'yyyy-mm-dd' format, e.g. '1982-11-23' }  
}

\value{
Daylength in hours
}

\references{
Forsythe, William C., Edward J. Rykiel Jr., Randal S. Stahl, Hsin-i Wu and Robert M. Schoolfield, 1995. A model comparison for daylength as a function of latitude and day of the year. Ecological Modeling 80:87-95.
}


\author{ Robert J. Hijmans }
\examples{
daylength(-25, '2010-10-10')
daylength(45, 1:365)

# average monthly daylength
dl <- daylength(45, 1:365)
tapply(dl, rep(1:12, c(31,28,31,30,31,30,31,31,30,31,30,31)), mean)

}

\keyword{ spatial }
