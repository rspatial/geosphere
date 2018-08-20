# Author: Robert J. Hijmans
# April 2010
# version 1
# license GPL3

.normalizeLonDeg <- function(x) {
	(x + 180) %% 360 - 180
}

.normalizeLonRad <- function(x) {
	(x + pi) %% (2*pi) - pi 
}


.isPolygon <- function(x, fix=FALSE) {
	x <- stats::na.omit(x)
	if (nrow(x) < 4) {
		stop('this is not a polygon (insufficent number of vertices)')
	}
	if (length(unique(x[,1]))==1) {
		stop('All longitudes are the same (not a polygon)')
	}
	if (length(unique(x[,2]))==1) {
		stop('All latitudes are the same (not a polygon)')
	}
	if (! all(!(is.na(x))) ) {
		stop('polygon has NA values)')
	}
	if (! isTRUE(all.equal(x[1,], x[nrow(x),]))) {
		stop('this is not a valid (closed) polygon. The first vertex is not equal to the last vertex')	
	}
	return(x)
}

