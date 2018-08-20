# Author: George Wang & Robert J. Hijmans
# August 2010
# version 1
# license GPL3

.spDistPoint2Line <- function(p, line, distfun) {
	test <- !is.projected(line)
	if (! isTRUE (test) ) {
		if (is.na(test)) {
			warning('Coordinate reference system of SpatialPolygons object is not set. Assuming it is degrees (longitude/latitude)!')  			
		} else {
			stop('Points are projected. They should be in degrees (longitude/latitude)')  
		}
		# or rather transform them ....?
	}
	
	x <- line@lines
	n <- length(x)
	res <- matrix(nrow=nrow(p), ncol=4)
	colnames(res) <- c("distance","lon","lat","ID")
	res[] <- Inf
	
	for (i in 1:n) {
		parts <- length(x[[i]]@Lines )
		for (j in 1:parts) {
			crd <- x[[i]]@Lines[[j]]@coords
			r <- cbind(dist2Line(p, crd, distfun), i)
			k <- r[,1] < res[,1]
			res[k, ] <- r[k, ]
		}
	}
	return(res)
}		
		

dist2Line <- function(p, line, distfun=distGeo) {

	p <- .pointsToMatrix(p)
	
	if (inherits(line, 'SpatialPolygons')) {
		line <- methods::as(line, 'SpatialLines')
	}
	if (inherits(line, 'SpatialLines')) {
		return( .spDistPoint2Line(p, line, distfun) )
	}

	line <- .pointsToMatrix(line) 
	line1 <- line[-nrow(line), ,drop=FALSE]
	line2 <- line[-1, ,drop=FALSE]
	seglength  <- distfun(line1, line2)
	
	res <- matrix(nrow=nrow(p), ncol=3)
	colnames(res) <- c("distance","lon","lat")
	
	for (i in 1:nrow(p)) {
		xy <- p[i,]
# the shortest distance of a point to a great circle
		crossdist <- abs(dist2gc(line1, line2, xy))
		
# the alongTrackDistance is the length of the path along the great circle to the point of intersection
# there are two, depending on which node you start
# we want to use the min, but the max needs to be < segment length
		trackdist1 <- alongTrackDistance(line1, line2, xy)
		trackdist2 <- alongTrackDistance(line2, line1, xy)
		mintrackdist <- pmin(trackdist1, trackdist2)
		maxtrackdist <- pmax(trackdist1, trackdist2)
		crossdist[maxtrackdist >= seglength] <- NA 
		
# if the crossdist is NA, we use the distance to the nodes
		nodedist <- distfun(xy, line)
		
		warnopt = getOption('warn')
	 	options('warn'=-1) 		
		distmin1 <- min(nodedist, na.rm=TRUE)
		distmin2 <- min(crossdist, na.rm=TRUE)
		options('warn'= warnopt) 
		
		if (distmin1 <= distmin2) {
			j <- which.min(nodedist)
			res[i,] <- c(distmin1, line[j,])
		} else {
			j <- which.min(crossdist)
			# if else to determine from which node to start
			if (trackdist1[j] < trackdist2[j]) {
				bear <- bearing(line1[j,], line2[j,])
				pt <- destPoint(line1[j,], bear, mintrackdist[j])
				res[i,] <- c(crossdist[j], pt)
			} else {
				bear <- bearing(line2[j,], line1[j,])
				pt <- destPoint(line2[j,], bear, mintrackdist[j])
				res[i,] <- c(crossdist[j], pt)	
			}
		}
	}
	return(res)
}

 