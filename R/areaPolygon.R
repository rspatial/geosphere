# Robert Hijmans
# April 2010
# version 1
# license GPL3


if (!isGeneric("areaPolygon")) {
	setGeneric("areaPolygon", function(x, ...)
		standardGeneric("areaPolygon"))
}	

setMethod('areaPolygon', signature(x='data.frame'), 
	function(x, a=6378137, f=1/298.257223563, ...) {
		areaPolygon(as.matrix(x), a=a, f=f, ...)
} )


setMethod('areaPolygon', signature(x='SpatialPolygons'), 
function(x, a=6378137, f=1/298.257223563, ...) {

	test <- is.projected(x)
	if ( isTRUE (test) ) {
		if (is.na(test)) {
			warning('Coordinate reference system of SpatialPolygons object is not set. Assuming it is degrees (longitude/latitude)!') 
		} else {
			stop('The coordinate reference system is not longitude/latitude.')  
		}
		# or rather transform them ....?
	}


	x <- x@polygons
	n <- length(x)
	res <- vector(length=n)
	for (i in 1:n) {
		parts <- length(x[[i]]@Polygons )
		sumarea <- 0
		for (j in 1:parts) {
			crd <- x[[i]]@Polygons[[j]]@coords
			ar <- areaPolygon(crd, a=a, f=f, ...)
			if (x[[i]]@Polygons[[j]]@hole) {
				sumarea <- sumarea - ar
			} else {
				sumarea <- sumarea + ar
			}
		}
		res[i] <- sumarea
	}
	return(res)
} )


setMethod('areaPolygon', signature(x='matrix'), 
function(x, a=6378137, f=1/298.257223563, ...) {
	r <- list(...)$r
	if (!is.null(r)) {
		# for backwards compatibility
		warning('remove argument "r" to use an better algorithm')
		return( .old_areaPolygon(x, r=r) )
	}

	# calling geographiclib	
	x <- .Call("_polygonarea", as.double(x[,1]), as.double(x[,2]), as.double(a), as.double(f), PACKAGE='geosphere')
	abs(x[3])
})
	

	
	
.old_areaPolygon <- function(x, r=6378137, ...) {

# Based on code by Jason_Steven (http://forum.worldwindcentral.com/showthread.php?p=69704)
# Reference: Bevis, M. and G. Cambareri, 1987. Computing the area of a spherical polygon of arbitrary shape. Mathematical Geology 19: 335-346

	haversine <- function(y) { (1-cos(y))/2 }

	x <- .pointsToMatrix(x, poly=TRUE) 
	x <- makePoly(x) # for some corner cases
	
	# rotate?
	dif1 <- max(x[,1]) - min(x[,1])
	if (dif1 > 180) {
		x2 <- x
		x2[,1] <- x2[,1] %% 360 - 180
		#dif1 <- max(x[,1]) - min(x[,1])
		dif2 <- max(x2[,1]) - min(x2[,1]) 
		if (dif2 < dif1) {
			x <- x2 
		}
	}
	x <- x * pi / 180 
	
	r <- r[1]
	j <- 1:nrow(x)
	k <- c(2:nrow(x), 1)
	i <- x[j,1] != x[k,1]
	j <- j[i]
	k <- k[i]
	lam1 <- x[j,1]
	lam2 <- x[k,1]
	beta1 <- x[j,2]
	beta2 <- x[k,2]
	cosB1 <- cos( beta1 )
	cosB2 <- cos( beta2 )

	hav <- haversine( beta2 - beta1 ) + cosB1 * cosB2 * haversine( lam2 - lam1 )
	a <- 2 * asin( sqrt( hav ) )
	b <- pi / 2 - beta2
	c <- pi / 2 - beta1
	s <- 0.5 * ( a + b + c )
	t <- tan( s / 2 ) * tan( ( s - a ) / 2 ) *  tan( ( s - b ) / 2 ) * tan( ( s - c ) / 2 )
	
	excess <- abs( 4 * atan( sqrt( abs( t ) ) ) )
	excess[lam2 < lam1] <- -excess[lam2 < lam1]
	
	arsum <- abs( sum( excess ) ) * r * r
    return(arsum )
} 
