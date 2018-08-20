\name{plotArrows}

\alias{plotArrows}
  
\title{Plot}

\description{
Plot polygons with arrow heads on each line segment, pointing towards the next vertex. This shows the direction of each line segment.
}

\usage{
plotArrows(p, fraction=0.9, length=0.15, first='', add=FALSE, ...)
}

\arguments{
\item{p}{Polygons (either a 2 column matrix or data.frame; or a SpatialPolygons* object}
\item{fraction}{numeric between 0 and 1. When smaller then 1, interrupted lines are drawn}
\item{length}{length of the edges of the arrow head (in inches)}
\item{first}{Character to plot on first (and last) vertex }
\item{add}{Logical. If \code{TRUE}, the plot is added to an existing plot}

\item{...}{Additional arguments, see Details}
}

\author{Robert J. Hijmans}

\note{
Based on an example in Software for Data Analysis by John Chambers (pp 250-251) but adjusted such that the line segments follow great circles between vertices.
}

\examples{
pol <- rbind(c(-180,-20), c(-160,5), c(-60, 0), c(-160,-60), c(-180,-20))
plotArrows(pol)
}

\keyword{methods}
\keyword{spatial}
