# Robert Hijmans
# October 2009
# version 0.1
# Licence: GPL3

finalBearing <- function(p1, p2, a=6378137, f=1/298.257223563, sphere=FALSE) {
	
	if (sphere) {
		# for backwards compatibility
		return(.old_bearing(p2, p1) )
	}

	p1 <- .pointsToMatrix(p1)
	p2 <- .pointsToMatrix(p2)
	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2])

	r <- .inversegeodesic(as.double(p[,1]), as.double(p[,2]), as.double(p[,3]), as.double(p[,4]), as.double(a[1]), as.double(f[1]))
	
	r <- matrix(r, ncol=3, byrow=TRUE)
	# colnames(r) <- c('lon', 'lat', 'finalbearing')
	return(r[, 3])
}	
