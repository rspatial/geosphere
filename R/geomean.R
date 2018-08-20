# Author: Robert J. Hijmans
# February 2012
# version 1
# license GPL3


geomean <- function(xy, w=NULL) {

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
	
	xy[,1] <- xy[,1] + 180
	xy <- xy * pi / 180 
		
	Sx <- mean(sin(xy[,1]) * w)
	Cx <- mean(cos(xy[,1]) * w)
	x <- atan2(Sx, Cx)
	x <- x %% (2 * pi) - pi
		
	Sy <- mean(sin(xy[,2]) * w)
	Cy <- mean(cos(xy[,2]) * w)
	y <- atan2(Sy, Cy)
		
	cbind(x,y) * 180 / pi
}

