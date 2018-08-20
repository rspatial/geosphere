# author Robert Hijmans
# October 2009
# version 0.1
# license GPL3

# based on
#http://www.edwilliams.org/avform.htm#Par

gcLon <- function(p1, p2, lat) {
# longitudes at which a given great circle crosses a given parallel
# source: http://www.edwilliams.org/avform.htm
	
	toRad <- pi / 180 
	p1 <- .pointsToMatrix(p1) 
	p2 <- .pointsToMatrix(p2) 

	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2], lat)	
	p1 <- p[,1:2,drop=FALSE]
	p2 <- p[,3:4,drop=FALSE]
	lat <- p[,5]

	res <- matrix(NA, nrow=nrow(p1), ncol=2)
	colnames(res) <- c('lon1', 'lon2')

	anti <- ! antipodal(p1, p2) 
	if (sum(anti) == 0) {
		return(res)
	}
	
	p1 <- p1[anti, ,drop=FALSE] * toRad
	p2 <- p2[anti, ,drop=FALSE] * toRad
	
	lon1 <- p1[,1] * -1
	lat1 <- p1[,2] 
	lon2 <- p2[,1] * -1
	lat2 <- p2[,2]
	lat3 <- lat * toRad
	
	l12 <- lon1-lon2
	A <- sin(lat1)*cos(lat2)*cos(lat3)*sin(l12)
	B <- sin(lat1)*cos(lat2)*cos(lat3)*cos(l12) - cos(lat1)*sin(lat2)*cos(lat3)
	C <-  cos(lat1)*cos(lat2)*sin(lat3)*sin(l12)
	lon <- atan2(B,A)   
	
	lon3 <- matrix(NA, nrow=length(lon1), ncol=2)
	
	i <- (abs(C) > sqrt(A^2 + B^2)) | (sqrt(A^2 + B^2) == 0)
	lon3[i,] <- NA
	i <- !i
	
	dlon <- rep(NA, length(A))
	dlon[i] <- acos(C[i]/sqrt(A[i]^2+B[i]^2))
	lon3[i,1] <- .normalizeLonRad(lon1[i]+dlon[i]+lon[i])
	lon3[i,2] <- .normalizeLonRad(lon1[i]-dlon[i]+lon[i])
	
	res[anti,] <- -1 * lon3  / toRad

	return(res)
}

