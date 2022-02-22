# based on code by Ed Williams
# licence GPL
# http://www.edwilliams.org/avform.htm#XTE

# Port to R by Robert Hijmans
# October 2009
# version 0.1
# license GPL3

alongTrackDistance <- function(p1, p2, p3, r=6378137) {
	toRad <- pi / 180 
	p1 <- .pointsToMatrix(p1)
	p2 <- .pointsToMatrix(p2)
	p3 <- .pointsToMatrix(p3)
	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2], p3[,1], p3[,2], as.vector(r))
	p1 <- p[,1:2,drop=FALSE]
	p2 <- p[,3:4,drop=FALSE]
	p3 <- p[,5:6,drop=FALSE]
	r = p[,7]
	
	tc <- bearing(p1, p2) * toRad
	tcp <- bearing(p1, p3) * toRad
    dp <- distCosine(p1, p3, r=1)
	xtr <- asin(sin(tcp-tc) * sin(dp))

# +1/-1 for ahead/behind [lat1,lon1]
	bearing <- sign(cos(tc - tcp))  
	
	dist <- bearing * acos(round(cos(dp) / cos(xtr), 15)) * r # Rounding one digit below machine eps
	if (is.vector(dist)) { dist <- matrix(dist) }
	colnames(dist) <- 'distance'
	
	return(abs(dist))
}
