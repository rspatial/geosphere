# Based on formulae by Ed Williams
# http://www.edwilliams.org/avform.htm

# Port to R by Robert Hijmans
# October 2009
# version 0.1
# License GPL3

gcMaxLat <- function(p1, p2) {
	toRad <- pi / 180 

	p1 <- .pointsToMatrix(p1)
	p2 <- .pointsToMatrix(p2) 
	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2])	
	p1 <- p[,1:2,drop=FALSE]
	p2 <- p[,3:4,drop=FALSE]
	
	anti <- antipodal(p1, p2) 
	same <- apply(p1 == p2, 1, sum) == 2
	use <- !(anti | same)
	res <- matrix(rep(NA, nrow(p1)*2), ncol=2)
	colnames(res) <- c('lon', 'lat')
	
	if (length(use)==0) {
		return(res)
	}
	
	pp1 <- p1[use, , drop=FALSE]
	pp2 <- p2[use, , drop=FALSE]
	
	b <- .old_bearing(pp1, pp2) * toRad
	
	lat <- pp1[,2] * toRad
	
# Clairaut's formula : the maximum latitude of a great circle path, given a bearing and latitude on the great circle
	maxlat <- acos(abs(sin(b) * cos(lat))) / toRad
	
	
	ml <- maxlat - 0.000000000001
	maxlon <- mean(gcLon(pp1, pp2, ml))
	
	res[use,] <- cbind(maxlon, maxlat)
		
#	lon <- pp1[,1] * toRad
#	maxlon <- rep(NA, length(maxlat))
#	i <- maxlat==0
#	j <- b < pi & !i
#	k <- !j & !i
	
#	maxlon[j] <- lon[j] - atan2(cos(b[j]), sin(b[j]) * sin(lat[j]))
#	maxlon[k] <- lon[k] + pi - atan2(cos(b[k]), sin(b[k]) * sin(lat[k]))
#	maxlon <- -1 * ((maxlon+pi)%%(2*pi) - pi)
 
#	res[use,] <- cbind(maxlon, maxlat)/ toRad

	return(res)
}

