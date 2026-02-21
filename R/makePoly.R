# author Robert Hijmans
# April 2010
# version 0.1
# license GPL



.makeSinglePoly <- function(p, interval=10000, ...) {
	res <- p[1,]
	for (i in 1:(nrow(p)-1)) {
		if (! isTRUE( all.equal(p[i,], p[i+1,]) )) {
			d <- distGeo(p[i,], p[i+1,], ...)
			n <- floor(d / interval)
			if (n > 0) {
				pts <- gcIntermediate(p[i,],p[i+1,], n)
				pts <- rbind(p[i,], pts, p[i+1,])
				res <- rbind(res, pts, p[i+1,])
			} else {
				res <- rbind(res, p[i+1,])
			}
		}
	}
	if (nrow(res) < 3) stop('cannot make a valid polygon')
	return(res)
}
 
 
 
.makeSingleLine <- function(p, interval=10000, ...) {
	res <- p[1,]
	for (i in 1:(nrow(p)-1)) {
		if (! isTRUE( all.equal(p[i,], p[i+1,]) )) {
			d <- distGeo(p[i,], p[i+1,], ...)
			n <- floor(d / interval)
			if (n > 0) {
				pts <- gcIntermediate(p[i,],p[i+1,], n)
				pts <- rbind(p[i,], pts, p[i+1,])
				res <- rbind(res, pts, p[i+1,])
			} else {
				res <- rbind(res, p[i+1,])
			}
		}
	}
	if (nrow(res) < 2) stop('cannot make a valid line')
	return(res)
}
 
 
makePoly <- function(p, interval=10000, sp=FALSE, ...) {
	if (inherits(p, 'SpatialPolygons')) {
		test <- !sp::is.projected(p)
		if (! isTRUE (test) ) {
			if (is.na(test)) {
				warning('Coordinate reference system of sp::SpatialPolygons object is not set. Assuming it is degrees (longitude/latitude)!')  			
			} else {
				stop('Points are projected. They should be in degrees (longitude/latitude)')  
			}
			# or rather transform them ....?
		}
	
		x <- p@polygons
		n <- length(x)
		polys = list()
		for (i in 1:n) {
			parts <- length(x[[i]]@Polygons )
			partlist <- list()
			for (j in 1:parts) {
				crd <- x[[i]]@Polygons[[j]]@coords
				crd <- .makeSinglePoly(crd, interval=interval, ...)
				partlist[[j]] <- sp::Polygons(crd)
			}
			polys[[i]] <- sp::Polygons(partlist, i)
		}
		polys <- sp::SpatialPolygons(polys)
		if (inherits(p, 'SpatialPolygonsDataFrame')) {
			rownames(p@data) <- 1:nrow(p@data)
			polys <- sp::SpatialPolygonsDataFrame(polys, p@data)	
		}
		polys@proj4string <- p@proj4string
		return(polys)
	} else {
		p <- .pointsToMatrix(p)
		if (nrow(p) < 3) {
			stop('cannot make a polygon (insufficent number of vertices)')
		}
		if (! isTRUE(all.equal(p[1,], p[nrow(p),]))) {
			p <- rbind(p, p[1,])
		}
		res <- .makeSinglePoly(p, interval=interval, ...) 
		if (sp) {
			res <- sp::SpatialPolygons(list(sp::Polygons(list(sp::Polygon(res)), 1)))
			res@proj4string <- sp::CRS("+proj=longlat +datum=WGS84")
		}
		return(res)
	}
} 



makeLine <- function(p, interval=10000, sp=FALSE, ...) {
	if (inherits(p, 'SpatialLines')) {
		test <- !sp::is.projected(p)
		if (! isTRUE (test) ) {
			if (is.na(test)) {
				warning('Coordinate reference system of sp::SpatialPolygons object is not set. Assuming it is degrees (longitude/latitude)!')  			
			} else {
				stop('Points are projected. They should be in degrees (longitude/latitude)')  
			}
			# or rather transform them ....?
		}
	
	
		x = p@lines
		n = length(x)
		lines = list()
		for (i in 1:n) {
			parts = length(x[[i]]@Lines )
			partlist = list()
			for (j in 1:parts) {
				crd = x[[i]]@Lines[[j]]@coords
				crd = .makeSingleLine(crd, interval=interval, ...)
				partlist[[j]] = sp::Line(crd)
			}
			lines[[i]] = sp::Lines(partlist, i)
		}
		lines <- sp::SpatialLines(lines)
		if (inherits(p, 'SpatialLinesDataFrame')) {
			lines <- sp::SpatialLinesDataFrame(lines, p@data)	
		}
		lines@proj4string <- p@proj4string
		return(lines)
	} else {
		p <- .pointsToMatrix(p)
		if (nrow(p) < 3) {
			stop('cannot make a polygon (insufficent number of vertices)')
		}
		res <- .makeSingleLine(p, interval=interval, ...) 
		if (sp) {
			res <- sp::SpatialLines(list(sp::Lines(list(sp::Line(res)), 1)))
			res@proj4string <- sp::CRS("+proj=longlat +datum=WGS84")
		}
		return(res)
	}
} 



