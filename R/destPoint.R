# Author: Robert J. Hijmans
# Date :  May 2015
# Licence GPL v3

destPoint <- function(p, b, d, a=6378137, f=1/298.257223563, ...) {
# calculate destination point given start point, initial bearing (deg) and distance (m)
	
	r <- list(...)$r
	if (!is.null(r)) {
		# for backwards compatibility
		return( .old_destPoint(p, b, d, r=r) )
	}

	b <- as.vector(b)
	d <- as.vector(d) 
	p <- .pointsToMatrix(p)
	p <- cbind(p[,1], p[,2], b, d)
	
	r <- .Call("_geodesic", as.double(p[,1]), as.double(p[,2]), as.double(p[,3]), as.double(p[,4]), as.double(a), as.double(f), PACKAGE='geosphere')
	
	r <- matrix(r, ncol=3, byrow=TRUE)
	colnames(r) <- c('lon', 'lat', 'finalbearing')
	return(r[, 1:2, drop=FALSE])
}

