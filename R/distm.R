# Robert Hijmans
# April 2010
# version 1
# License GPL3


.distm1 <- function(x, fun) {
	n = nrow(x)
	dm = matrix(0, ncol=n, nrow=n)
	if (n == 1) {	
		return(dm) 	
	}
	for (i in 2:n) {
		j = 1:(i-1)
		dm[i,j] = fun(x[i,], x[j,])
	}

	dm <- dm+t(dm)
	return(dm)
}


distm <- function(x, y, fun=distGeo) {
	x <- .pointsToMatrix(x)
	
	if (missing(y)) {
		return( .distm1(x, fun) )
	}
	
	y <- .pointsToMatrix(y)
	n = nrow(x)
	m = nrow(y)
	
	dm = matrix(ncol=m, nrow=n)
	for (i in 1:n) {
		dm[i,] = fun(x[i,], y)
	}
	return(dm)
}

