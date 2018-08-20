# author Robert Hijmans
# October 2009
# version 0.1
# license GPL


gcLat <- function(p1, p2, lon) {
# Intermediate points on a great circle
# source: http://www.edwilliams.org/avform.htm
	toRad <- pi / 180 
	d <- distCosine(p1, p2)
	p1 <- .pointsToMatrix(p1)
	p2 <- .pointsToMatrix(p2)

	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2], as.vector(lon))	
	p1 <- p[,1:2,drop=FALSE]
	p2 <- p[,3:4,drop=FALSE]
	lon <- p[,5]

	res <- rep(NA, nrow(p))
	
	notanti <- ! antipodal(p1, p2) 

	lon1 <- p1[,1] * toRad
	lat1 <- p1[,2] * toRad
	lon2 <- p2[,1] * toRad
	lat2 <- p2[,2] * toRad
	lon <- lon * toRad
	
	# cannot compute this for a meridian
	notmeridians <- ! sin(lon1-lon2)==0
	keep <- notanti & notmeridians
	if (sum(keep) == 0) {	return(res) }

	lon1 <- lon1[keep] 
	lat1 <- lat1[keep]
	lon2 <- lon2[keep]
	lat2 <- lat2[keep]
	lon <- lon[keep]
	
	res[keep] <- atan((sin(lat1)*cos(lat2)*sin(lon-lon2) -sin(lat2)*cos(lat1)*sin(lon-lon1))/(cos(lat1)*cos(lat2)*sin(lon1-lon2)))
	return(res / toRad)
}
