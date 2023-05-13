# Robert Hijmans
# May 2023
# version 1
# license GPL3

OSGB <- function(xy, precision, inverse=FALSE) {
	if (inverse) {
		xy <- .OSGBinv(xy, 1, TRUE)
		matrix(xy, ncol=2, dimnames=list(NULL, c("x", "y")))
	} else {
		xy <- .pointsToMatrix(xy, FALSE)
		.OSGB(xy[,1], xy[,2], precision[1])
	}
}

