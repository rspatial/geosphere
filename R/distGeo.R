# Author: Robert J. Hijmans
# Date :  May 2015
# Licence GPL v3


distGeo <- function(p1, p2, a=6378137, f=1/298.257223563) {
	p1 <- .pointsToMatrix(p1) 
	if (missing(p2)) {
		if (nrow(p1) == 1) return(0)
		if (nrow(p1) == 0) return(NULL)
		p2 <- p1[-1, ,drop=FALSE]
		p1 <- p1[-nrow(p1), ,drop=FALSE]
		addNA <- TRUE
	} else {
		p2 <- .pointsToMatrix(p2)
		addNA <- FALSE
	}
	p  <- cbind(p1[,1], p1[,2], p2[,1], p2[,2])
	r <- .inversegeodesic(as.double(p[,1]), as.double(p[,2]), as.double(p[,3]), as.double(p[,4]), as.double(a), as.double(f))
	r <- matrix(r, ncol=3, byrow=TRUE)
	if (addNA){
		c(r[,1], NA) 
	} else {
		r[,1]
	}
}



