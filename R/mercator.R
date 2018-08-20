# Author: Robert J. Hijmans
# April 2010
# version 0.1
# license GPL3

mercator <- function(p, inverse=FALSE, r=6378137) {
	toRad <- pi / 180 
	if (inverse) {
		p <- .pointsToMatrix(p, checkLonLat=FALSE) 
		p[ ,2] <- pi/2 - 2 * atan(exp(-p[,2] / r))
		p[ ,1] <- p[,1] / r 
		colnames(p) <- c('lon', 'lat')
		return( p / toRad )
	} else {
		p <- .pointsToMatrix(p) * toRad
		p[,2] <- log( tan(p[,2]) + (1 / cos(p[,2])))
		p <- p * r
		colnames(p) <- c('x', 'y')
		return( p )
	}
}


