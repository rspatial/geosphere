# author of original JavaScript code: Chris Vennes
# (c) 2002-2009 Chris Veness
# http://www.movable-type.co.uk/scripts/latlong.html
# Licence: LGPL, without any warranty express or implied

# Port to R by Robert Hijmans
# October 2009
# version 0.1
# license GPL3



distHaversine <- function(p1, p2, r=6378137) {
#* Haversine formula to calculate distance between two points specified by 
#* from: Haversine formula - R.W. Sinnott, "Virtues of the Haversine",
#*  Sky and Telescope, vol 68, no 2, 1984
#*  http:#//www.census.gov/cgi-bin/geo/gisfaq?Q5.1

# source http://www.movable-type.co.uk/scripts/latlong.html
# (c) 2002-2009 Chris Veness
	toRad <- pi / 180 
	p1 <- .pointsToMatrix(p1) * toRad
	if (missing(p2)) {
		p2 <- p1[-1, ,drop=FALSE]
		p1 <- p1[-nrow(p1), ,drop=FALSE]
	} else {
		p2 <- .pointsToMatrix(p2)  * toRad	
	}

	p = cbind(p1[,1], p1[,2], p2[,1], p2[,2], as.vector(r))
		
	dLat <- p[,4]-p[,2]
	dLon <- p[,3]-p[,1]
	a <- (sin(dLat/2))^2 + cos(p[,2]) * cos(p[,4]) * (sin(dLon/2))^2
	# to avoid values of 'a' that are a sliver above 1
	# which may occur at antipodes
	# https://stackoverflow.com/questions/45889616/why-does-disthaversine-return-nan-for-some-pairs-of-coordinates#
	a <- pmin(a, 1)
	dist <- 2 * atan2(sqrt(a), sqrt(1-a)) * p[,5]
	return( as.vector(dist))
}

#	lon1 <- p[,1]
#	lat1 <- p[,2]
#	lon2 <- p[,3]
#	lat2 <- p[,4]
#	r <- p[,5]
#	dLat <- (lat2-lat1)
#	dLon <- (lon2-lon1)
#	a <- sin(dLat/2) * sin(dLat/2) + cos(lat1) * cos(lat2) * sin(dLon/2) * sin(dLon/2)
#	dist <- 2 * atan2(sqrt(a), sqrt(1-a)) * r


.distHaversine2 <- function(p1, p2, r=6378137) {
## following wikipedia
	toRad <- pi / 180 
	p1 <- .pointsToMatrix(p1) * toRad
	if (missing(p2)) {
		p2 <- p1[-1, ,drop=FALSE]
		p1 <- p1[-nrow(p1), ,drop=FALSE]
	} else {
		p2 <- .pointsToMatrix(p2)  * toRad	
	}

	p = cbind(p1[,1], p1[,2], p2[,1], p2[,2], as.vector(r))
		
	dLat <- p[,4]-p[,2]
	dLon <- p[,3]-p[,1]
	a <- (sin(dLat/2))^2 + cos(p[,2]) * cos(p[,4]) * (sin(dLon/2))^2
	a <- pmin(a, 1)

	dist <- 2 * r * asin(sqrt(a))
	return( as.vector(dist))
}



# from Thierry de Meeus
.distHaversine3 <- function(p1, p2, r=6378137) {
	toRad <- pi / 180 
	p1 <- .pointsToMatrix(p1) * toRad
	if (missing(p2)) {
		p2 <- p1[-1, ,drop=FALSE]
		p1 <- p1[-nrow(p1), ,drop=FALSE]
	} else {
		p2 <- .pointsToMatrix(p2)  * toRad	
	}

	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2], as.vector(r))
	r*(pi/2-asin(sin((p[,4]))*sin((p[,2]))+cos((p[,3])-(p[,1]))*cos((p[,4]))*cos((p[,2]))))
}

