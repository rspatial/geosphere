# Author: Robert Hijmans
# April 2010
# version 0.1
# license GPL

# inspired by an example in Software for Data Analysis by John Chambers (pp 250-1)
# but adjusted to follow great circles, rather than straight (2D) lines.


.doArrows <- function(p, line, fraction, length, interval, ...) {

	if (fraction >= 1) {
		graphics::lines(line, ...)
	} else {
		dist <- distGeo(p[-nrow(p),], p[-1,]) * (1 - fraction)
		bearing <- bearing(p[-nrow(p),], p[-1,])
		p0 <- destPoint(p[-nrow(p),], bearing, dist)
		for (i in 1:nrow(p0)) {
			line = .makeSinglePoly(rbind(p0[i,], p[i+1,]), interval=interval)
			graphics::lines(line)
		}
	}
		
	bearing = finalBearing(p[-nrow(p),], p[-1,])
	bearing = (bearing + 180) %% 360
	pp = destPoint(p[-1,], bearing, interval)
	x0 <- pp[,1]
	y0 <- pp[,2]
	x1 <- p[,1][-1]
	y1 <- p[,2][-1]
#	delta = sqrt(mean((x1-x0)^2 + (y1-y0)^2, na.rm=TRUE))
#	delta = delta * (par("pin")[1] / diff(range(x, na.rm=TRUE)))
	graphics::arrows(x0, y0, x1, y1, code=2, length=length, ...)
}


plotArrows <- function(p, fraction=0.9, length=0.15, first='', add=FALSE, ...) {
	asp=1
	if (inherits(p, 'Spatial')) {
		bb = t(sp::bbox(p))
		interval = distm(bb)[2][1] / 1000
		if (! add) { plot(bb, asp=asp, type='n') }
		p = p@polygons
		n = length(p)
		for (i in 1:n) {
			parts = length(p[[i]]@Polygons )
			sumarea = 0
			for (j in 1:parts) {
				pp =  p[[i]]@Polygons[[j]]@coords 
				line = .makeSinglePoly(pp, interval=interval)
				.doArrows(pp, line, fraction, length, interval=interval, ...)
			}
			graphics::points(pp[1,1], pp[1,2], pch=first, cex=2)
		}
	} else {
		interval = max(distm(p), na.rm=TRUE) / 1000
		line = .makeSinglePoly(p, interval=interval)
		if (! add) { plot(line, asp=asp, type='n') }
		.doArrows(p, line=line, fraction, length, interval=interval, ...)
		graphics::points(p[1,1], p[1,2], pch=first, cex=2)
	}
}


