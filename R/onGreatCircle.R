# Author: Robert J. Hijmans
# based on Dr. Rick's advice at:
# http://mathforum.org/library/drmath/view/66114.html
# August 2010
# version 1
# license GPL3


onGreatCircle <- function(p1, p2, p3, tol=0.0001) {
# is p3 an intermediate points on a great circle defined by p1 and p2?
	toRad <- pi / 180 

	p1 <- .pointsToMatrix(p1)
	p2 <- .pointsToMatrix(p2)
	p3 <- .pointsToMatrix(p3)
	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2], p3[,1], p3[,2])
	p1 <- p[,1:2, drop=FALSE] * toRad
	p2 <- p[,3:4, drop=FALSE] * toRad
	p3 <- p[,5:6, drop=FALSE] * toRad

	lon1 <- p1[,1]
	lat1 <- p1[,2]
	lon2 <- p2[,1]
	lat2 <- p2[,2]
	lon <- p3[,1] 
	lat <- p3[,2] 
	
	newlat <- atan((sin(lat1)*cos(lat2)*sin(lon-lon2) - sin(lat2)*cos(lat1)*sin(lon-lon1)) / (cos(lat1)*cos(lat2)*sin(lon1-lon2))) 
	
	res <- abs(newlat - lat) < tol

	meridian <- p1[,1] == p2[,1] & p1[,1]  == p3[,1]
	res[meridian] <- TRUE
	return(as.vector(res))
}

