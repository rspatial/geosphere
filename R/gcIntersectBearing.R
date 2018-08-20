# author Chris Veness, Robert Hijmans
# based on formulae by Ed Willians at
# http://www.edwilliams.org/avform.htm#Intersection
# October 2009
# version 0.1
# license GPL3


gcIntersectBearing <- function(p1, brng1, p2, brng2) {
#crs13 true bearing from point 1 and the crs23 true bearing from point 2:
 
	toRad <- pi / 180 
	p1 <- .pointsToMatrix(p1) * toRad
	p2 <- .pointsToMatrix(p2) * toRad

	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2], as.vector(brng1), as.vector(brng2))
	lon1 <- p[,1]
	lat1 <- p[,2]
	lon2 <- p[,3]
	lat2 <- p[,4]
	lat1[lat1==90|lat1==-90] <- NA
	lat2[lat2==90|lat2==-90] <- NA

	brng13 <- p[,5] * toRad
	brng23 <- p[,6] * toRad
	
	dLat <- lat2-lat1
	dLon <- lon2-lon1
  
	dist12 <- 2*asin( sqrt( sin(dLat/2)*sin(dLat/2) +  cos(lat1)*cos(lat2)*sin(dLon/2)*sin(dLon/2) ) )

	lat3 <- lon3 <- vector(length=length(nrow(lon1)))
	
	i <- rep(TRUE, length(dist12))
	i[dist12 == 0] <- FALSE

	brngA <- acos( ( sin(lat2) - sin(lat1)*cos(dist12) ) / ( sin(dist12)*cos(lat1) ) )
	brngA[is.na(brngA)] <- 0  # protect against rounding
	brngB <- acos( ( sin(lat1) - sin(lat2)*cos(dist12) ) / ( sin(dist12)*cos(lat2) ) )

    g <- (sin(lon2-lon1) > 0)
	brng12 <- vector(length=length(g))
	brng21 <- brng12
	
	brng12[g] <- brngA[g]
	brng21[g] <- 2*pi - brngB[g]
	brng12[!g] <- 2*pi - brngA[!g]
	brng21[!g] <- brngB[!g]
  
	alpha1 <- (brng13 - brng12 + pi) %% (2*pi) - pi  #// angle 2-1-3
	alpha2 <- (brng21 - brng23 + pi) %% (2*pi) - pi  #// angle 1-2-3

	g <- sin(alpha1) == 0 & sin(alpha2) == 0 
	h <- (sin(alpha1) * sin(alpha2)) < 0
	i <- !(g | h) & i

	lon3[!i] <- lat3[!i] <- NA
	alpha1 <- abs(alpha1)
	alpha2 <- abs(alpha2)
  
	alpha3 <- acos( -cos(alpha1)*cos(alpha2) +  sin(alpha1)*sin(alpha2)*cos(dist12) )
	dist13 <- atan2( sin(dist12)*sin(alpha1)*sin(alpha2), cos(alpha2)+cos(alpha1)*cos(alpha3) )
	lat3[i] <- asin( sin(lat1[i])*cos(dist13[i]) +  cos(lat1[i]) * sin(dist13[i]) * cos(brng13[i]) )
	dLon13 <- atan2( sin(brng13)*sin(dist13)*cos(lat1), cos(dist13)-sin(lat1)*sin(lat3) )
	lon3[i] <- lon1[i]+dLon13[i]
	lon3 <- (lon3+pi) %% (2*pi) - pi # // normalise to -180..180 degrees

	int <- cbind(lon3, lat3) / toRad
	colnames(int) <- c('lon', 'lat')
	int <- cbind(int, antipode(int))
	rownames(int) <- NULL

	return(int)
}
  
