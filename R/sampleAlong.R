# Based on code by Barry Rowlingson
#http://r-sig-geo.2731867.n2.nabble.com/how-to-generate-perpendicular-transects-along-a-line-feature-td7583710.html

# Some adaptations by Robert Hijmans
# January 2016
# version 0.1
# License GPL3


.evenspace <- function(xy, sep, start=0, size, direction=FALSE){ 

	dx <- c(0,diff(xy[,1])) 
	dy <- c(0,diff(xy[,2])) 
	dseg <- sqrt(dx^2+dy^2) 
	dtotal <- cumsum(dseg) 

	linelength <- sum(dseg) 
	pos <- seq(start,linelength, by=sep) 

	whichseg <- unlist(lapply(pos, function(x){sum(dtotal<=x)})) 

	x0 <- xy[whichseg,1]
	y0 <- xy[whichseg,2]
	x1 <- xy[whichseg+1,1]
	y1 <- xy[whichseg+1,2]
	dtotal <- dtotal[whichseg]

	further <- pos - dtotal 
	dseg <- dseg[whichseg+1]
	f <- further/dseg 
	
	x <- x0 + f * (x1-x0) 
	y <- y0 + f * (y1-y0) 

	r <- data.frame(x, y)
	
#	if (direction) {
#		r$direction <- atan2(y0-y1,x0-x1) 
#	} 
	r
} 

.transect <- function(pts, len){ 

  pts$thetaT = pts$theta+pi/2 
  dx <- len*cos(pts$thetaT) 
  dy <- len*sin(pts$thetaT) 
  data.frame(x0 = pts$x + dx, 
             y0 = pts$y + dy, 
             x1 = pts$x - dx, 
             y1 = pts$y -dy) 
} 


.sampleAlong <- function(x, interval) {
	if (inherits(x, 'SpatialPolygons')) {
		x <- terra::as.lines(terra::vect(x))
	} else if (inherits(x, 'SpatialLines')) {
		x <- terra::vect(x)
	} else if (inherits(x, 'sf')) {
		x <- terra::as.lines(terra::vect(x))
	}
	if (inherits(x, "SpatVector")) {
		x <- terra::densify(x, interval)
		terra::crds(x)
	} else {
		x <- .pointsToMatrix(x)
		.evenspace(x, interval, direction=FALSE)
	}
}
    

.sampleAlongPerpendicular <- function(x, interval, pdist, np=1 ) {
	if (inherits(x, 'SpatialPolygons')) {
		line <- terra::as.lines(terra::vect(line))
	} else if (inherits(x, 'SpatialLines')) {
		line <- terra::vect(line)
	} else if (inherits(x, "sf")) {
		line <- terra::vect(line)
	}
	if (inherits(line, "SpatVector")) {
		x <- data.frame(terra::geom(x))
		allpts <- NULL
		cump <- as.integer(interaction(x$geom, x$part))
		for (p in unique(cump)) {
			y <- x[cump==p, c('x', 'y')]
			tspts <- .evenspace(y, interval) 
			pts <- NULL
			for (i in 1:np) {
				pts1 <- .transect(tspts, i * pdist)
				pts <- cbind(pts, pts1)
			}
			allpts <- rbind(allpts, pts)
		}
		return(allpts)
	} else {
		x <- .pointsToMatrix(x)
		y <- .evenspace(x, interval) 
		pts <- NULL
		for (i in 1:np) {
			pts1 <- .transect(y, i * pdist)
			pts <- cbind(pts, pts1)
		}
		return(pts)
	}    

}
    


