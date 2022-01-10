# R implementation of 
# /*
 # * This is a C implementation of the geodesic algorithms described in
 # *
 # *   C. F. F. Karney,
 # *   Algorithms for geodesics,
 # *   J. Geodesy <b>87</b>, 43--55 (2013);
 # *   https://dx.doi.org/10.1007/s00190-012-0578-z
 # *   Addenda: http://geographiclib.sf.net/geod-addenda.html
 # *
 # * See the comments in geodesic.h for documentation.
 # *
 # * Copyright (c) Charles Karney (2012-2014) <charles@karney.com> and licensed
 # * under the MIT/X11 License.  For more information, see
 # * http://geographiclib.sourceforge.net/
 # */

# 
# Robert Hijmans
# May 2015
# version 1
# license GPL3


# Solve the direct geodesic problem.
geodesic <- function(p, azi, d, a=6378137, f=1/298.257223563, ...) { 
	p <- .pointsToMatrix(p)
	p <- cbind(p[,1], p[,2], azi, d)
	r <- .geodesic(as.double(p[,1]), as.double(p[,2]), as.double(p[,3]), as.double(p[,4]), as.double(a), as.double(f))
	r <- matrix(r, ncol=3, byrow=TRUE)
	colnames(r) <- c('longitude', 'latitude', 'azimuth')
	r
}

# Solve the inverse geodesic problem.
geodesic_inverse <- function(p1, p2, a=6378137, f=1/298.257223563, ...) { 
	p1 <- .pointsToMatrix(p1)
	p2 <- .pointsToMatrix(p2)
	p <- cbind(p1[,1], p1[,2], p2[,1], p2[,2])
	r <- .inversegeodesic(as.double(p[,1]), as.double(p[,2]), as.double(p[,3]), as.double(p[,4]), as.double(a), as.double(f))
	r <- matrix(r, ncol=3, byrow=TRUE)
	colnames(r) <- c('distance', 'azimuth1', 'azimuth2')
	r
}

