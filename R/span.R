# Author: Robert J. Hijmans, r.hijmans@gmail.com
# Date : April 2010
# Version 1
# Licence GPL v3



if (!isGeneric("span")) {
	setGeneric("span", function(x, ...)
		standardGeneric("span"))
}	



setMethod("span", signature(x='matrix'), 
function(x, nbands='fixed', n=100, res=0.1, fun, r=6378137, ...) {

	dif1 <- max(x[,1]) - min(x[,1])
	rotated <- FALSE
	if (dif1 > 180) {
		x2 <- x
		x2[,1] <- x2[,1] %% 360 - 180
		dif1 <- max(x[,1]) - min(x[,1])
		dif2 <- max(x2[,1]) - min(x2[,1]) 
		if (dif2 < dif1) {
			rotated <- TRUE
			x <- x2 
		}
	}
	
	x <- sp::SpatialPolygons(list(sp::Polygons(list(sp::Polygon(x)), 1)))
	if (missing(fun)) {
		x <- span(x, nbands=nbands, n=n, res=res, ...) 
	} else {	
		x <- span(x, nbands=nbands, n=n, res=res, fun=fun, ...) 
	}
	if (rotated & missing(fun)) {
		x$longitude = x$longitude + 180
	}
	return(x)
} )



setMethod("span", signature(x='SpatialPolygons'), 
function(x, nbands='fixed', n=100, res=0.1, fun, ...) {
	span(terra::vect(x), nbands=nbands, n=n, res=res, fun=fun, ...)
})

setMethod("span", signature(x='sf'), 
function(x, nbands='fixed', n=100, res=0.1, fun, ...) {
	span(terra::vect(x), nbands=nbands, n=n, res=res, fun=fun, ...)
})

setMethod("span", signature(x='SpatVector'), 
function(x, nbands='fixed', n=100, res=0.1, fun, ...) {
	
	if (! nbands %in% c('fixed', 'variable')) {
		stop('bandwidth should be "fixed" or "variable"')
	}
	
	if (nbands == 'fixed') {
		n = max(n, 1)
	} else {
		if (res <= 0) {
			stop('res should be larger than zero')
		}
	}

	npol <- nrow(x)
	lonspan <- list()
	latspan <- list()
	lon <- list()
	lat <- list()
	
	for (i in 1:npol) {
		pp <- x[i,]
		rs <- terra::rast(pp)
		if (nbands == 'fixed') {
			dim(rs) <- c(n, n)
		} else {
			terra::res(rs) <- res
		}
				
		latitude <- terra::yFromRow(rs, 1:nrow(rs))
		longitude <- terra::xFromCol(rs, 1:ncol(rs))
		xd <- distGeo(cbind(0,latitude), cbind(terra::xres(rs),latitude), ...)
		yd <- distGeo(cbind(0,0), cbind(0,terra::yres(rs)), ...)
		
		rs <- terra::rasterize(pp, rs)
		rs <- terra::values(rs, format='matrix')
		latspan[[i]] <- as.vector(apply(rs, 1, sum, na.rm=TRUE) * yd)
		lonspan[[i]] <- as.vector(apply(rs, 2, sum, na.rm=TRUE) * xd)
		lat[[i]] <- latitude
		lon[[i]] <- longitude
	}

	if (! missing(fun)) {
		lon = sapply(lonspan, fun)
		lat = sapply(latspan, fun)
		return(cbind(lon, lat))
	} else {
		return(c(lonspan=lonspan, latspan=latspan, longitude=lon, latitude=lat))
	}
}
)

