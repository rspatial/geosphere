# Author: Robert J. Hijmans & Jacob van Etten
# October 2009
# version 1
# license GPL3



.pointsToMatrix <- function(p, checkLonLat=TRUE, poly=FALSE) {
	if (inherits(p, 'SpatVector')) {
		stopifnot(terra::geomtype(p) == "points")
		test <- terra::is.lonlat(p)
		if (! isTRUE (test) ) {
			if (is.na(test)) {
				warning('Coordinate reference system of SpatVector is not set. Assuming it is degrees (longitude/latitude)!')  			
			} else if (checkLonLat) {
				p <- terra::project(p, "+proj=longlat")
			}
		}
		p <- terra::crds(p)
	} else if (inherits(p, 'SpatialPoints')) {
		test <- !sp::is.projected(p)
		if (! isTRUE (test) ) {
			if (is.na(test)) {
				warning('Coordinate reference system of SpatialPoints object is not set. Assuming it is degrees (longitude/latitude)!')  			
			} else if (checkLonLat) {
				stop('Points are projected. They should be in degrees (longitude/latitude)')  
			}
		}
		p <- sp::coordinates(p)
	} else if (is.data.frame(p)) {
		p <- as.matrix(p)
	} else if (is.vector(p)){
		if (length(p) != 2) {
			stop('Wrong length for a vector, should be 2')
		} else {
			p <- matrix(p, ncol=2) 
		}
	} else if (is.matrix(p)) {
		if (ncol(p) != 2) {
			stop( 'A points matrix should have 2 columns')
		}
		cn <- colnames(p)
		if (length(cn) == 2) {
			if (toupper(cn[1]) == 'Y' | toupper(cn[2]) == 'X')  {
				warning('Suspect column names (x and y reversed?)')
			}
			if (toupper(substr(cn[1],1,3) == 'LAT' | toupper(substr(cn[2],1,3)) == 'LON'))  {
				warning('Suspect column names (longitude and latitude reversed?)')
			}
		}		
	} else {
		stop('points should be vectors of length 2, matrices with 2 columns, or inheriting from a SpatialPoints or SpatVector object')
	}

	if (! is.numeric(p) ) { p[] <- as.numeric(p) }
	
	if (checkLonLat & nrow(p) > 0) {
		if (length(stats::na.omit(p[,1])) > 0) {
			if (min(p[,1], na.rm=TRUE) < -360) { stop('longitude < -360') }
			if (max(p[,1], na.rm=TRUE) > 360) {  stop('longitude > 360')  }
			if (min(p[,1], na.rm=TRUE) < -180) { warning('longitude < -180') }
			if (max(p[,1], na.rm=TRUE) > 180) {  warning('longitude > 180')  }
		}
		if (length(stats::na.omit(p[,2])) > 0) {
			if (min(p[,2], na.rm=TRUE) < -90) {  stop('latitude < -90')  }
			if (max(p[,2], na.rm=TRUE) > 90) {  stop('latitude > 90')  }
		}
	}
	
	
	if (poly) {
		if (! isTRUE(all.equal(p[1,], p[nrow(p),]))) {
			p <- rbind(p, p[1,])
		} 

		i <- p[-nrow(p),1] == p[-1,1] &  p[-nrow(p),2] == p[-1,2]
		i <- which(isTRUE(i))
		if (length(i) > 0) {
			p <- p[-i, ,drop=FALSE]
		}
	
		.isPolygon(p)
	}
	
	return(p)
}

