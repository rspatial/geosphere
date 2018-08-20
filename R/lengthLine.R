# Author: Robert J. Hijmans
# August 2016
# version 1
# license GPL3
	

lengthLine <- function(line) {

	if (inherits(line, 'SpatialPolygons')) {
		requireNamespace('raster')
		line <- raster::geom(methods::as(line, 'SpatialLines'))
	} else if (inherits(line, 'SpatialLines')) {
		requireNamespace('raster')
		line <- raster::geom(line)
	} else {
		line <- cbind(object=1, part=1, cump=1, line[, 1:2])
		colnames(line)[4:5] <- c('x', 'y')
	}

	
	ids <- unique(line[,1])
	len <- rep(0, length(ids))
	for (i in 1:length(ids)) {
		d <- line[line[,1] == ids[i], ]
		parts <- unique(d[,2])
		for (p in parts) {
			dd <- d[d[,2] == p, ,drop=FALSE]
			for (j in 1:(nrow(dd)-1)) {
				len[i] <- len[i] + distGeo(dd[j, c('x', 'y'), drop=FALSE], dd[j+1, c('x', 'y'), drop=FALSE])
			}
		}
	}
	return(len)
}

