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


bearingRhumb <- function(p1, p2) {

	toRad <- pi / 180 
	p1 <- .pointsToMatrix(p1) * toRad
	p2 <- .pointsToMatrix(p2) * toRad
 
	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2])	
	p1 <- p[, 1:2, drop=FALSE]
	p2 <- p[, 3:4, drop=FALSE]
	
	keep <- ! apply(p1 == p2, 1, sum) == 2
	res <- rep(NA, length=nrow(p1))
	if (sum(keep) == 0) { return(res) }

	lon1 <- p1[keep, 1, drop=FALSE]
	lat1 <- p1[keep, 2, drop=FALSE]
	lon2 <- p2[keep, 1, drop=FALSE]
	lat2 <- p2[keep, 2, drop=FALSE]

	dLon <- (lon2-lon1)
	dPhi <- log(tan(lat2/2 + pi/4)/tan(lat1/2+pi/4))
	i <- (abs(dLon) > pi)
	j <- i & dLon > 0
	dLon[j] <- -(2*pi-dLon[j])
	j <- i & dLon <= 0
	dLon[j] <- dLon[j] <- (2*pi+dLon[j])
	
	b <- atan2(dLon, dPhi)
	b <- b / toRad
	b <- (b+360) %% 360
	res[keep] = b
	return(res)
}

