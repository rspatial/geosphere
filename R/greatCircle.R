# author Robert Hijmans
# October 2009
# version 0.1
# license GPL


greatCircle <- function(p1, p2, n=360, sp=FALSE) {

	p1 <- .pointsToMatrix(p1)
	p2 <- .pointsToMatrix(p2)

	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2], n)
	p1 <- p[,1:2]
	p2 <- p[,3:4]
	n <- pmax(round(p[,5]), 1)
	
	if (nrow(p) == 1) {
		lon <- (1:n * 360 / n) - 180
		lat <- gcLat(p1, p2, lon) 
		res <- cbind(lon,lat) 
		if (sp) {
			lat <- gcLat(p1, p2, 180)
			res <- list(rbind(cbind(-180, lat), res))
			res <- SpatialLines( list( Lines( list( Line (res)), ID=as.character(1)) ),  CRS("+proj=longlat +ellps=WGS84"))
		}
	} else {
		res <- list()
		for (i in 1:nrow(p1)) {
			lon <- (1:n[i] * 360 / n[i]) - 180
			lat <- gcLat(p1[i,], p2[i,], lon) 
			res[[i]] <- cbind(lon, lat)
		}
		if (sp) {
			for (i in 1:length(res)) {
				lat <- gcLat(p1[i,], p2[i,], 180)
				res[[i]] <- rbind(cbind(-180, lat), res[[i]])
				res[[i]] <- Lines( list( Line (res[[i]])), ID=as.character(i)) 	
			}
			res <- SpatialLines(res, CRS("+proj=longlat +ellps=WGS84"))
		}
	}
	return(res)
}

#greatCircle(rbind(cbind(5,52), cbind(5,15)), c(-120,37), n=12)
