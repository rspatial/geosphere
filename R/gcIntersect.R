# author Robert Hijmans
# October 2009
# version 0.1
# license GPL3

# based on an alogrithm described by Ed Williams
# http://www.edwilliams.org/intersect.htm

# Not used
#gete <- function(lon, lat) {
#	ex <- cos(lat)*cos(lon)
#	ey <- -cos(lat)*sin(lon)
#	ez <- sin(lat)
#	return(cbind(ex, ey, ez))
#}


gcIntersect <- function(p1, p2, p3, p4) {
#intersection of two great circles defined by pt1 to pt2 and pt3 to pt4.

	einv <- function(e) {
		lat <- atan2(e[,3], sqrt(e[,1]^2 + e[,2]^2))
		lon <- atan2(-e[,2], e[,1]) 
		return(cbind(lon, lat))
	}

	eXe5 <- function(lon1, lat1, lon2, lat2) {
	    ex <- sin(lat1-lat2) *sin((lon1+lon2)/2) *cos((lon1-lon2)/2) - sin(lat1+lat2) *cos((lon1+lon2)/2) *sin((lon1-lon2)/2) 
		ey <- sin(lat1-lat2) *cos((lon1+lon2)/2) *cos((lon1-lon2)/2) + sin(lat1+lat2) *sin((lon1+lon2)/2) *sin((lon1-lon2)/2) 
		ez <- cos(lat1)*cos(lat2)*sin(lon1-lon2) 
		return( cbind(ex, ey, ez) )
	}

	eXe3 <- function(e1, e2) {
		x <- e1[,2] * e2[,3] -e2[,2] *e1[,3]
		y <- e1[,3] *e2[,1] -e2[,3] *e1[,1]
		z <- e1[,1] *e2[,2] -e1[,2] *e2[,1]
		return(cbind(x,y,z))
	}

	eSQRT <- function(e) {
		return(sqrt(e[,1]^2 + e[,2]^2 + e[,3]^2))
	}	
	
	p1 <- .pointsToMatrix(p1)
	p2 <- .pointsToMatrix(p2)
	p3 <- .pointsToMatrix(p3)
	p4 <- .pointsToMatrix(p4)
	
	p1 <- cbind(p1[,1], p1[,2], p2[,1], p2[,2])
	p3 <- cbind(p3[,1], p3[,2], p4[,1], p4[,2])
	p  <- cbind(p1[,1], p1[,2], p1[,3], p1[,4], p3[,1], p3[,2], p3[,3], p3[,4])
	
	p1 <- p[,1:2,drop=FALSE]
	p2 <- p[,3:4,drop=FALSE]
	p3 <- p[,5:6,drop=FALSE]
	p4 <- p[,7:8,drop=FALSE]
	
	res <- matrix(NA, nrow=nrow(p1), ncol=4)
	colnames(res) <- c('lon1', 'lat1', 'lon2', 'lat2')

	keep <- ! antipodal(p1, p2) | antipodal(p3, p4)
	keep <- keep & ! apply(p1 == p2, 1, sum) == 2
	
	if (sum(keep) == 0) { return(res) }

	toRad <- pi / 180 
	p1 <- p1[keep, , drop=FALSE] * toRad
	p2 <- p2[keep, , drop=FALSE] * toRad
	p3 <- p3[keep, , drop=FALSE] * toRad
	p4 <- p4[keep, , drop=FALSE] * toRad

	e1Xe2 <- eXe5(p1[,1], p1[,2], p2[,1], p2[,2])
	e3Xe4 <- eXe5(p3[,1], p3[,2], p4[,1], p4[,2])

	ea <- e1Xe2  / eSQRT(e1Xe2)
	eb <- e3Xe4  / eSQRT(e3Xe4)
	
	eaXeb <- eXe3(ea, eb)
	
	ll <- einv(eaXeb)
	ll2 <- cbind(ll[,1] + pi, -ll[,2])
	pts <- cbind(ll, ll2)
	pts[,1] <- .normalizeLonRad(pts[,1])
	pts[,3] <- .normalizeLonRad(pts[,3])
	
	res[keep,] <- pts / toRad
	
	return(res)
 }
 
 
 