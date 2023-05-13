# Robert Hijmans
# May 2023
# version 1
# license GPL3

OSGB <- function(xy, precision) {
	xy <- .pointsToMatrix(xy, FALSE)
	.OSGB(xy[,1], xy[,2], precision[1])
}

