# author Robert Hijmans
# July 2010
# version 0.1
# license GPL

# based on suggstions by Michael Orion
# http://sci.tech-archive.net/Archive/sci.math/2005-09/msg04691.html

randomCoordinates <- function(n) {
	z <- stats::runif(n) * 2 - 1
    t <- stats::runif(n) * 2 * pi
    r <- sqrt(1-z^2)
    x <- r * cos(t)
    y <- r * sin(t)

    r <- sqrt(x^2 + y^2 + z^2)
    theta <- acos(z / r)
    phi <- atan2(y,x)

    lat <- theta * 180 / pi - 90
    lon <- phi * 180 / pi
    return(cbind(lon,lat))
}

