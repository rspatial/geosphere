# Author: Robert J. Hijmans
# March 2012
# version 1
# license GPL3



.geomedian <- function(xy, w=NULL) {

	xy <- .pointsToMatrix(xy)

	if (is.null(w)) {
		w <- 1
	} else if (length(w) != nrow(xy)) {
		stop('length of weights not correct. It should be: ', nrow(xy))
	}
	w <- w / sum(w)
	
	xyw <- cbind(xy, w)
	xy <- stats::na.omit(xyw)
	xy <- xyw[,1:2]
	w <- xyw[,3]

	est <- geomean(xy, w)

	fun <- function(p) { 
		if (p[2] > 90 | p[2] < -90) {
			return(Inf)
		} else {
			p[1] = (p[1] + 180) %% 360 - 180
			sum( distCosine(xy, p) * w) 
		}
	}
	
	opt <- stats::optim(geomean(xy), fun)
	if (!is.null(opt$message)) {
		warning(opt$message)
	}
	return(opt$par)
	
}



..geomedian_ndcor <- function(xy, w=NULL, threshold=100, maxiter=100) {
	
	if (inherits(xy, 'SpatialPolygons') | inherits(xy, 'SpatialPoints')) {
		stopifnot(terra::is.lonlat(terra::vect(xy))) 
		xy <- sp::coordinates(xy)
	} 

	if (is.null(w)) {
		w <- 1
	} else if (length(w) != nrow(xy)) {
		stop('length of weights not correct. It should be: ', nrow(xy))
	}
	w <- w / sum(w)
	
	xyw <- cbind(xy, w)
	xy <- stats::na.omit(xyw)
	xy <- xyw[,1:2]
	w <- xyw[,3]

	est <- geomean(xy, w)
	estold <- est
	iter = 1
	while (TRUE) {
		d <- distCosine(xy, est)
		x <- sum(w*xy[,1] / d) / sum(w/d)
		y <- sum(w*xy[,2] / d) / sum(w/d)
		est <- cbind(x,y)
		dif <- distCosine(est, estold)
		if (dif < threshold) {
			return(est)
		} else if (iter > maxiter) {
			warning('maxiter reached')
			return(est)
		}
		estold <- est
		iter <- iter + 1
	}
}

