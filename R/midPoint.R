# Robert Hijmans
# October 2009
# version 0.1
# License GPL3


midPoint <- function(p1, p2, a=6378137, f = 1/298.257223563) {
	# by Elias Pipping
	gi <- geodesic_inverse(p1, p2, a=a, f=f);
	destPoint(p1, gi[,'azimuth1'], gi[,'distance']/2, a = a, f = f)
}


.old_midPoint <- function(p1, p2) {

# author of original JavaScript code: Chris Vennes
# (c) 2002-2009 Chris Veness
# http://www.movable-type.co.uk/scripts/latlong.html
# Licence: LGPL, without any warranty express or implied

# Much of the above based on formulae by Ed Williams
# http://www.edwilliams.org/avform.htm

# Port to R by Robert Hijmans

# calculate midpoint of great circle line between p1 & p2.
# see http:#//mathforum.org/library/drmath/view/51822.html for derivation
#  based on  http://www.movable-type.co.uk/scripts/latlong.html
# (c) 2002-2009 Chris Veness
	toRad <- pi / 180 

	p1 <- .pointsToMatrix(p1) * toRad
	p2 <- .pointsToMatrix(p2) * toRad
	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2])	
	
	lon1 <- p[,1]
	lat1 <- p[,2]
	lon2 <- p[,3]
	lat2 <- p[,4]

	dLon <- (lon2-lon1)

	Bx <- cos(lat2) * cos(dLon)
	By <- cos(lat2) * sin(dLon)

	lat <- atan2(sin(lat1) + sin(lat2), sqrt((cos(lat1) + Bx)*(cos(lat1) + Bx) + By*By ) )
	lon <- lon1 + atan2(By, cos(lat1) + Bx)

	lon[is.nan(lon)] <- NA
	lat[is.nan(lat)] <- NA
	
	lon <- (lon+pi)%%(2*pi) - pi
	res <- cbind(lon, lat) / toRad
	
	return(res)
}
