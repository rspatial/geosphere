\name{geosphere-package}
\alias{geosphere-package}

\alias{geosphere}

\docType{package}

\title{Geosphere}

\description{
This package implements functions that compute various aspects of distance, direction, area, etc. for geographic (geodetic) coordinates. Some of the functions are based on an ellipsoid (spheroid) model of the world, other functions use a (simpler, but less accuarate) spherical model. Functions using an ellipsoid can be recognized by having arguments to specify the ellipsoid's radius and flattening (\code{a} and \code{f}). By setting the value for \code{f} to zero, the ellipsoid becomes a sphere. 

There are also functions to compute intersections of of rhumb lines. There are also functions to compute the distance between points and polylines, and to characterize spherical polygons; for random sampling on a sphere, and to compute daylength. See the vignette \code{vignette('geosphere')} for examples.

Geographic locations must be specified in latitude and longitude in degrees (NOT radians). Degrees are (obviously) in decimal notation. Thus 12 degrees, 30 minutes, 10 seconds = 12 + 30/60 + 10/3600 =  12.50278 degrees. The Southern and Western hemispheres have a negative sign.

The default unit of distance is meter; but this can be adjusted by supplying a different radius \code{r} to functions.

Directions are expressed in degrees (North = 0 and 360,  East = 90, Sout = 180, and West = 270 degrees).
}

\author{
Robert Hijmans, using code by C.F.F. Karney and Chris Veness; formulas by Ed Williams; and with contributions from George Wang, Elias Pipping and others.
Maintainer: Robert J. Hijmans <r.hijmans@gmail.com>
}

\references{
C.F.F. Karney, 2013. Algorithms for geodesics, J. Geodesy 87: 43-55. \url{https://dx.doi.org/10.1007/s00190-012-0578-z}. Addenda: \url{http://geographiclib.sf.net/geod-addenda.html}. Also see \url{http://geographiclib.sourceforge.net/}

\url{http://www.edwilliams.org/avform.htm}

\url{http://www.movable-type.co.uk/scripts/latlong.html}

\url{http://en.wikipedia.org/wiki/Great_circle_distance}

\url{http://mathworld.wolfram.com/SphericalTrigonometry.html}
}

\section{Acknowledgements}{
David Purdy, Bill Monahan and others for suggestions to improve the package.
}


\keyword{ package }
\keyword{ spatial }

