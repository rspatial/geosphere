# Author: Robert J. Hijmans
# Date :  March 2010 / May 2015
# Version 2.0
# Licence GPL v3

bearing <- function(p1, p2, a=6378137, f=1/298.257223563) {

	p1 <- .pointsToMatrix(p1)

	if (missing(p2)) {
		if (nrow(p1) < 2) {
			return(NA)
		}
		p2 <- p1[-1, ,drop=FALSE]
		p1 <- p1[-nrow(p1), ,drop=FALSE]
		addNA <- TRUE
	} else {
		p2 <- .pointsToMatrix(p2)
		addNA <- FALSE
	}
	
	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2])	
	r <- .inversegeodesic(as.double(p[,1]), as.double(p[,2]), as.double(p[,3]), as.double(p[,4]), as.double(a[1]), as.double(f[1]))
	r <- matrix(r, ncol=3, byrow=TRUE)
	if (addNA) {
		c(r[, 2], NA)
	} else {
		r[, 2]
	}
}


.old_bearing <- function(p1, p2) {
	toRad <- pi / 180 
	p1 <- .pointsToMatrix(p1) * toRad
	p2 <- .pointsToMatrix(p2) * toRad
	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2])	
	p1 <- p[, 1:2, drop=FALSE]
	p2 <- p[, 3:4, drop=FALSE]

	keep <- ! apply(p1 == p2, 1, sum) == 2
	res <- rep(NA, length=nrow(p1))
	if (sum(keep) == 0) { return(res) }

	p1 <- p1[keep, , drop=FALSE]
	p2 <- p2[keep, , drop=FALSE]
	
	dLon <- p2[,1] - p1[,1] 
    y <- sin(dLon)  * cos(p2[,2]) 
    x <- cos(p1[,2]) * sin(p2[,2]) - sin(p1[,2]) * cos(p2[,2]) * cos(dLon) 
    azm <- atan2(y, x) / toRad
	azm <- (azm+360) %% 360
	i <- azm > 180
	azm[i] <- -1 * (360 - azm[i])
	res[keep] <- azm
	return(res)
}


