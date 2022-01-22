# Robert Hijmans
# April 2010
# version 1
# License GPL3

if (!isGeneric("perimeter")) {
	setGeneric("perimeter", function(x, ...)
		standardGeneric("perimeter"))
}	


setMethod("perimeter", signature(x='SpatialPolygons'), 
function(x, a=6378137, f=1/298.257223563, ...) {
	x <- x@polygons
	n <- length(x)
	res <- vector(length=n)
	for (i in 1:n) {
		parts <- length( x[[i]]@Polygons )
		perim <- 0
		for (j in 1:parts) {
			if (! x[[i]]@Polygons[[j]]@hole) {
				crd <- x[[i]]@Polygons[[j]]@coords
				perim <- perim + perimeter(crd, a=a, f=f, ...)
			}
		}
		res[i] <- perim
	}
	return(res)
} )


setMethod("perimeter", signature(x='SpatialLines'), 
function(x, a=6378137, f=1/298.257223563, ...) {
	x <- x@lines
	n <- length(x)
	res <- vector(length=n)
	for (i in 1:n) {
		parts <- length( x[[i]]@Lines )
		lng <- 0
		for (j in 1:parts) {
			crd <- x[[i]]@Lines[[j]]@coords
			lng <- lng + perimeter(crd, a=a, f=f, ...)
		}
		res[i] <- lng
	}
	return(res)
} )


setMethod("perimeter", signature(x='data.frame'), 
function(x, a=6378137, f=1/298.257223563, ...) {
	perimeter(as.matrix(x), a=a, f=f, ...)
} )


setMethod("perimeter", signature(x='matrix'), 
function(x, a=6378137, f=1/298.257223563, ...) {

	r <- list(...)$r
	if (!is.null(r)) {
		# for backwards compatibility
		warning('removed argument "r" to use improved method')
		return( .old_perimeter(x, r=r) )
	}

	n <- nrow(x)
	d <- .inversegeodesic(as.double(x[-n,1]), as.double(x[-n,2]), as.double(x[-1,1]), as.double(x[-1,2]), as.double(a), as.double(f))
	sum(abs(x))
})


.old_perimeter <- function(x, r=6378137, ...) {
	x <- x[,1:2]
	if (isTRUE(all.equal(x[1,], x[nrow(x),]))) {
		x <- x[-nrow(x), ]
	}
	y <- rbind(x[-1,], x[1,])
	d <- distHaversine(x, y, r=r)
	return(sum(d))
} 


