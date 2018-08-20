
horizon <- function(h, r=6378137) {
	x = cbind(as.vector(h), as.vector(r))
	h = x[,1]
	r = x[,2]
	
	b = 0.8279
	sqrt( 2 * r * h / b ) 
}

