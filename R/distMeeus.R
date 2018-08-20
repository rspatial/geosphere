# R code by Robert Hijmans
# based on Java script code by
# Stephen R. Schmitt (copyright, 2004)

# http://web.archive.org/web/20070108024032/http://home.att.net/~srschmitt/script_greatcircle.html

# algorithm taken from "Astronomical Algorithms" by Jean Meeus

distMeeus <- function(p1, p2, a=6378137, f=1/298.257223563) {

	toRad <- pi / 180 
	p1 <- .pointsToMatrix(p1) * toRad
	if (missing(p2)) {
		p2 <- p1[-1, ,drop=FALSE]
		p1 <- p1[-nrow(p1), ,drop=FALSE]
	} else {
		p2 <- .pointsToMatrix(p2) * toRad
	}
    F <- ( p1[,2] + p2[,2] ) / 2
	G <- ( p1[,2] - p2[,2] ) / 2
	L <- ( p1[,1] - p2[,1] ) / 2
	sinG2 <- ( sin( G ) )^2
	cosG2 <- ( cos( G ) )^2
	sinF2 <- ( sin( F ) )^2
	cosF2 <- ( cos( F ) )^2
	sinL2 <- ( sin( L ) )^2
	cosL2 <- ( cos( L ) )^2
	S <- sinG2 * cosL2 + cosF2 * sinL2
	C <- cosG2 * cosL2 + sinF2 * sinL2
	w <- atan( sqrt( S/C ) )
	R <- sqrt( S*C )/w
	D <- 2 * w * a
	H1 <- (3*R - 1)/(2*C)
	H2 <- (3*R + 1)/(2*S)
	dst <- D*( 1 + f*H1*sinF2*cosG2 - f*H2*cosF2*sinG2 )
	# remove NaN for when p1[i,]==p2[i,]
	dst[which(w==0)] <- 0

	return ( as.vector(dst) )
}

