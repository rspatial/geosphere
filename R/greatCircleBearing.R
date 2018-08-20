# author Robert Hijmans
# April 2010
# version 0.1
# license GPL


greatCircleBearing <- function(p, brng, n=360) {
	p <- .pointsToMatrix(p)
	p <- cbind(p[,1], p[,2], as.vector(brng), n)
	p2 <- destPoint(p[,1:2], p[,3], 10000000)
	return(greatCircle(p[,1:2], p2, n=p[,4]))
}
 

#greatCircleBearing(rbind(cbind(5,52), cbind(5,15)), 60, n=12)
