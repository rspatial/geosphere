# Author: Robert J. Hijmans
# Date :  June 2008
# Licence GPL v3

# distance based on law of cosines
# http://en.wikipedia.org/wiki/Great_circle_distance

distCosine <- function(p1, p2, r=6378137) {
	p1 <- .pointsToMatrix(p1) 
	if (missing(p2)) {
		p2 <- p1[-1, ,drop=FALSE]
		p1 <- p1[-nrow(p1), ,drop=FALSE]
	} else {
		p2 <- .pointsToMatrix(p2) 	
	}
	pp  <- cbind(p1[,1], p1[,2], p2[,1], p2[,2], as.vector(r))

	# remove identical points to avoid errors due to floating point math
	# problem reported by Bill Monahan
	i <- rowSums(abs(pp[, 1:2, drop=FALSE] - pp[, 3:4, drop=FALSE]) < .Machine$double.eps ^ 0.5) < 2
	p <- pp[i, ,drop=FALSE]
	
	r <- rep(0, nrow(pp))
	if (nrow(p) > 0) {
		p[,1:4] <- p[,1:4] * pi / 180 
		r[i] <- acos( sin(p[,2]) * sin(p[,4]) + cos(p[,2]) * cos(p[,4]) * cos(p[,1]-p[,3]) ) * p[,5]
	}
	r
}

# m = matrix(c(-58.65222,-19.65154,-52.985550,-1.484869, -69.652220, 7.348464, -69.652220,7.348464, -1,1 ,-1,1, -1,1.1,-1,1.1, -1,1.2,-1,1.2, -116.65220,72.01513,-121.48560,53.34847), ncol=4, byrow=T)
# distCosine(m[,1:2], m[,3:4])

#	n <- nrow(p)
#	d <- vector("double", n)
#	d <- .C('distance', as.integer(n), as.double(p[,1]), as.double(p[,2]), as.double(p[,3]), as.double(p[,4]), as.double(p[,5]), as.integer(1), d)[[8]]
#	return(d)
