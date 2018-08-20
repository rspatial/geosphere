# based on JavaScript code by Chris Vennes
# (c) 2002-2009 Chris Veness
# http://www.movable-type.co.uk/scripts/latlong.html
# Licence: LGPL, without any warranty express or implied
# see http://www.edwilliams.org/avform.htm#Rhumb
# for the original formulae

# Robert Hijmans
# October 2009
# version 0.1
# license GPL3


destPointRhumb <- function(p, b, d, r=6378137) {
	toRad <- pi / 180 

	b <- as.vector(b)
	d <- as.vector(d)
	r <- as.vector(r)
	p <- .pointsToMatrix(p)
	p <- cbind(p[,1], p[,2], b, d, r)
	
	r <- p[,5]
	d <- p[,4] / r  #angular distance in radians
	b <- p[,3] * toRad

	lon1 <- p[,1] * toRad
	lat1 <- p[,2]
	lat1[lat1==90|lat1==-90] <- NA
	lat1 <- lat1 * toRad

	lat2 <- lat1 + d * cos(b)
	dLat <- lat2-lat1
	dPhi <- log( tan(lat2/2 + pi/4) / tan(lat1/2 + pi/4) )
	
	i <- abs(dLat) > 1e-10 
	q <- vector(length=length(i))
	q[i] <- dLat[i]/dPhi[i] 
	q[!i] <- cos(lat1[!i])

	dLon <- d * sin(b) / q
	
# check for points past the pole../
	i <- (abs(lat2) > pi/2) & lat2 > 0
	lat2[i] <- pi-lat2[i]
	i <- (abs(lat2) > pi/2) & lat2 <= 0
	lat2[i] <- (pi-lat2[i])
  
	lon2 <- (lon1+dLon+pi)%%(2*pi) - pi
 
	res <- cbind(lon2, lat2) / toRad
	colnames(res) <- c('lon', 'lat')
	return(res)
}

