# author of original JavaScript code: Chris Vennes
# (c) 2002-2009 Chris Veness
# http://www.movable-type.co.uk/scripts/latlong.html
# Licence: LGPL, without any warranty express or implied

# see http://www.edwilliams.org/avform.htm#Rhumb
# for the original formulae

# Port to R by Robert Hijmans
# October 2009
# version 0.1
# license GPL3

distRhumb <- function(p1, p2, r=6378137) {
# distance on a rhumb line
	toRad <- pi / 180 
	p1 <- .pointsToMatrix(p1) * toRad
	if (missing(p2)) {
		p2 <- p1[-1, ,drop=FALSE]
		p1 <- p1[-nrow(p1), ,drop=FALSE]
	} else {
		p2 <- .pointsToMatrix(p2) * toRad	 
	}
  
	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2], as.vector(r))
	lon1 <- p[,1]
	lat1 <- p[,2]
	lon2 <- p[,3]
	lat2 <- p[,4]
	r <- p[,5]
	
	dLat <- (lat2-lat1) 
	dLon <- abs(lon2-lon1)
	dPhi <- log(tan(lat2/2 + pi/4)/tan(lat1/2 + pi/4))

	i <- abs(dLat) > 1e-10 
	q <- vector(length=length(i))
	q[i] <- dLat[i]/dPhi[i]
	q[!i]  <- cos(lat1[!i]) 
	
  #// if dLon over 180 degrees take shorter rhumb across 180 degrees meridian:
	dLon[dLon > pi] <- 2*pi - dLon[dLon > pi]  

	d <- sqrt(dLat*dLat + q*q*dLon*dLon) 
	return(d * r)
}


