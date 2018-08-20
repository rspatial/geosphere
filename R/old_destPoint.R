# author of original JavaScript code: Chris Vennes
# (c) 2002-2009 Chris Veness
# http://www.movable-type.co.uk/scripts/latlong.html
# Licence: LGPL, without any warranty express or implied

# Based on formulae by Ed Williams
# http://www.edwilliams.org/avform.htm

# Port to R by Robert Hijmans
# October 2009
# version 0.1
# License GPL3


.old_destPoint <- function(p, b, d, r=6378137) {
# calculate destination point given start point, initial bearing (deg) and distance (km)
# see http:#//www.edwilliams.org/avform.htm#LL
# source http://www.movable-type.co.uk/scripts/latlong.html
# (c) 2002-2009 Chris Veness
	toRad <- pi / 180 

	b = as.vector(b)
	d = as.vector(d)
	r =	as.vector(r)
	p <- .pointsToMatrix(p)
	p = cbind(p[,1], p[,2], b, d, r)
	
	lon1 <- p[,1] * toRad
	lat1 <- p[,2] * toRad
	b <- p[,3] * toRad
	d = p[,4]
	r = p[,5]

	lat2 <- asin( sin(lat1)*cos(d/r) + cos(lat1)*sin(d/r)*cos(b) )
	lon2 <- lon1 + atan2(sin(b)*sin(d/r)*cos(lat1), cos(d/r)-sin(lat1)*sin(lat2))
	lon2 <- (lon2+pi)%%(2*pi) - pi  #// normalise to -180...+180
	lon2[is.nan(lon2)] <- NA
	lat2[is.nan(lat2)] <- NA

	res <- cbind(lon2, lat2) / toRad
	colnames(res) <- c('lon', 'lat')
	return(res)
}

