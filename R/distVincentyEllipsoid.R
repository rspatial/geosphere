# author of original JavaScript code: Chris Vennes
# (c) 2002-2009 Chris Veness
# http://www.movable-type.co.uk/scripts/latlong.html
# Licence: LGPL, without any warranty express or implied

# Port to R by Robert Hijmans
# October 2009
# version 0.1
# license GPL3


distVincentyEllipsoid <- function(p1, p2, a=6378137, b=6356752.3142, f=1/298.257223563) {
#/*  Vincenty Inverse Solution of Geodesics on the Ellipsoid (c) Chris Veness 2002-2009           #*/
#* Calculate geodesic distance (in m) between two points specified by latitude/longitude 
#* (in numeric degrees) using Vincenty inverse formula for ellipsoids
# source http://www.movable-type.co.uk/scripts/latlong-vincenty.html
# (c) 2002-2009 Chris Veness

	toRad <- pi / 180 
	p1 <- .pointsToMatrix(p1) * toRad
	if (missing(p2)) {
		p2 <- p1[-1, ,drop=FALSE]
		p1 <- p1[-nrow(p1), ,drop=FALSE]
	} else {
		p2 <- .pointsToMatrix(p2) * toRad
	}
	
	p = cbind(p1[,1], p1[,2], p2[,1], p2[,2], as.vector(a), as.vector(b), as.vector(f))
	p1 = p[,1:2,drop=FALSE] 
	p2 = p[,3:4,drop=FALSE] 
	  
	res <- vector(length=nrow(p1))
    for (i in 1:dim(p1)[1]) {

		if ( any( is.na( c(p1[i,], p2[i,])))) {  #improvement by George Wang and Sebastian P. Luque
			res[i] <- NA
		} else if (isTRUE(all.equal(p1[i,], p2[i,]))) {
			res[i] <- 0
		} else {
			lon1 <- p1[i,1]
			lat1 <- p1[i,2]
			lon2 <- p2[i,1]
			lat2 <- p2[i,2]
			a = p[i,5]
			b = p[i,6]
			f = p[i,7]
		
			L <- (lon2-lon1)
			U1 <- atan((1-f) * tan(lat1))
			U2 <- atan((1-f) * tan(lat2))
			sinU1 <- sin(U1)
			cosU1 <- cos(U1)
			sinU2 <- sin(U2)
			cosU2 <- cos(U2)
			lambda <- L
			iterLimit <- 100
			continue <- TRUE
			while (continue) {
				sinLambda <- sin(lambda)
				cosLambda <- cos(lambda)
				sinSigma <- sqrt((cosU2*sinLambda) * (cosU2*sinLambda) + (cosU1*sinU2-sinU1*cosU2*cosLambda) * (cosU1*sinU2-sinU1*cosU2*cosLambda))
				
				cosSigma <- sinU1*sinU2 + cosU1*cosU2*cosLambda
				sigma <- atan2(sinSigma, cosSigma)
				sinAlpha <- cosU1 * cosU2 * sinLambda / sinSigma
				cosSqAlpha <- 1 - sinAlpha*sinAlpha
				cos2SigmaM <- cosSigma - 2*sinU1*sinU2/cosSqAlpha
				
				if (is.nan(cos2SigmaM)) cos2SigmaM <- 0  # equatorial line: cosSqAlpha=0 (par. 6)
				
				C <- f/16*cosSqAlpha*(4+f*(4-3*cosSqAlpha))
				lambdaP <- lambda
				lambda <- L + (1-C) * f * sinAlpha * (sigma + C*sinSigma*(cos2SigmaM+C*cosSigma*(-1+2*cos2SigmaM*cos2SigmaM)))
				iterLimit <- iterLimit - 1
				continue <- (abs(lambda-lambdaP) > 1e-12 && iterLimit > 0)
			} 
			if (iterLimit==0) {
				res[i]  <- NA  # failed to converge
			} else {
				uSq <- cosSqAlpha * (a*a - b*b) / (b*b)
				A <- 1 + uSq/16384*(4096+uSq*(-768+uSq*(320-175*uSq)))
				B <- uSq/1024 * (256+uSq*(-128+uSq*(74-47*uSq)))
				deltaSigma <- B*sinSigma*(cos2SigmaM+B/4*(cosSigma*(-1+2*cos2SigmaM*cos2SigmaM)- B/6*cos2SigmaM*(-3+4*sinSigma*sinSigma)*(-3+4*cos2SigmaM*cos2SigmaM)))
				res[i]  <- b*A*(sigma-deltaSigma)
			}
		}
	}
  
	return(as.vector(res))
}

