# author Robert Hijmans
# July 2010
# version 0.1
# license GPL

# Based on pascal code by Nils Haeck, simdesign.nl
# http://mathforum.org/kb/message.jspa?messageID=3985660&tstart=0

regularCoordinates <- function(N) {
	N <- round(N)
	if (N < 1) {stop('N should be >= 1')}
# subdivision angle
	beta <- 0.5 * pi / N
# line segment length
	A <- 2 * sin(beta/2);
# endcap
	points <- rbind(c(0, 0, 1), c(0, 0, -1))
# rings
	R <- sin(1:N * beta)
	Z <- cos(1:N * beta)
	M <- round(R * 2 * pi / A)

	for (i in 1:N) {
		j <- 0:(M[i]-1)
		Alpha <- j/M[i] * 2 * pi
		X <- cos(Alpha) * R[i]
		Y <- sin(Alpha) * R[i]
		points <- rbind(points, cbind(X, Y, Z[i]))
		if (i != N) {
			points <- rbind(points, cbind(X, Y, -Z[i]))
		}
	}
	
    r <- sqrt(points[,1]^2 + points[,2]^2 + points[,3]^2)
    theta <- acos(points[,3] / r)
    phi <- atan2(points[,2], points[,1])
    lat <- theta * 180 / pi - 90
    lon <- phi * 180 / pi
    return(cbind(lon,lat))
}

