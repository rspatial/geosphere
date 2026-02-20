# Author: Robert J. Hijmans
# April 2010
# version 0.1
# license GPL3

# See http://local.wasp.uwa.edu.au/~pbourke/geometry/polyarea/

.basiccentroid <- function(p) {
	p2 <- rbind(p[-1,], p[1,])
	P <- p[,1] * p2[,2] - p2[,1] * p[,2]
	area6 <- 6 * sum(P) / 2
    x <- sum((p[,1] + p2[,1]) * P)
    y <- sum((p[,2] + p2[,2]) * P)
	return(cbind(x, y) / area6 )
}

if (!isGeneric("centroid")) {
	setGeneric("centroid", function(x, ...)
		standardGeneric("centroid"))
}	


setMethod("centroid", signature(x='data.frame'), 
function(x) {
	centroid(as.matrix(x))
})



setMethod("centroid", signature(x='matrix'), 
function(x) {

	x <- .pointsToMatrix(x, poly=TRUE)

	dif1 <- max(x[,1]) - min(x[,1])
	rotated <- FALSE
	if (dif1 > 180) {
		x2 <- x
		x2[,1] <- x2[,1]%%(360) - 180
		dif1 <- max(x[,1]) - min(x[,1])
		dif2 <- max(x2[,1]) - min(x2[,1]) 
		if (dif2 < dif1) {
			rotated <- TRUE
			x <- x2 
		}
	}
	
	x <- mercator(x, r=1)
	cenM <- .basiccentroid(x)
	cenG <- mercator(cenM, r=1, inverse=TRUE)
	
	if (rotated) {
		cenG[,1] <- cenG[,1] + 180
		cenG[,1] <- .normalizeLonDeg(cenG[,1])
	}
	
	rownames(cenG) <- NULL
	return(cenG)
}
)



setMethod("centroid", signature(x='SpatialPolygons'), 
function(x) {

	if ( isTRUE(sp::is.projected(x)) ) {
		return( sp::coordinates(x)) 
	}

	x <- x@polygons
	n <- length(x)
	res <- matrix(nrow=n, ncol=2)
	for (i in 1:n) {
		parts <- length(x[[i]]@Polygons )
		parea <- sapply(x[[i]]@Polygons, function(y){ methods::slot(y, "area")} )
		hole <- sapply(x[[i]]@Polygons, function(y){ methods::slot(y, "hole")} )
		parea[hole] <- -1
		j <- which.max(parea)
		crd <- x[[i]]@Polygons[[j]]@coords
		res[i,] <- centroid(crd)
	}
	return(res)
} )

