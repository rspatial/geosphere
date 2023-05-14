# Robert Hijmans
# May 2023
# version 1
# license GPL3

OSGB <- function(xy, precision, geo=FALSE, inverse=FALSE) {
	if (inverse) {
		xy <- .OSGBinv(xy, 1, TRUE)
		matrix(xy, ncol=2, dimnames=list(NULL, c("x", "y")))
	} else {
		stopifnot(precision %in% c('1m', '10m', '100m', '1km', '10km', '100km', '5m', '50m', '500m', '5km', '50km', '500km'))
		xy <- .pointsToMatrix(xy, FALSE)
		.OSGB(xy[,1], xy[,2], precision[1], geo[1])
	}
}


