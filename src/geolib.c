#include "geodesic.h"
#include <Rinternals.h>

/* Robert Hijmans, May 2015 */
 
SEXP _geodesic(SEXP longitude, SEXP latitude, SEXP azimuth, SEXP distance, SEXP pa, SEXP pf) {

  PROTECT(latitude = coerceVector(latitude, REALSXP));
  PROTECT(longitude = coerceVector(longitude, REALSXP));
  PROTECT(azimuth = coerceVector(azimuth, REALSXP));
  PROTECT(distance = coerceVector(distance, REALSXP));
  double a = REAL(pa)[0];
  double f = REAL(pf)[0];
  
  double *lat1, *lon1, *azi1, *s12, *xr;
  lat1 = REAL(latitude);
  lon1 = REAL(longitude);
  azi1 = REAL(azimuth);
  s12 = REAL(distance);

  double lat2, lon2, azi2;
  struct geod_geodesic g;

  geod_init(&g, a, f);

  int i;
  SEXP r;
  PROTECT( r = allocVector(REALSXP, 3 * length(latitude) ) );
  xr = REAL(r);  
  for (i=0; i < length(latitude); i++) {
    geod_direct(&g, lat1[i], lon1[i], azi1[i], s12[i], &lat2, &lon2, &azi2);
    xr[i*3] = lon2;
    xr[i*3+1] = lat2;
    xr[i*3+2] = azi2;	
  }
  UNPROTECT(5);
  return r;
  
}
 
 
 
SEXP _inversegeodesic(SEXP longitude1, SEXP latitude1, SEXP longitude2, SEXP latitude2, SEXP pa, SEXP pf) {

  PROTECT(latitude1 = coerceVector(latitude1, REALSXP));
  PROTECT(longitude1 = coerceVector(longitude1, REALSXP));
  PROTECT(latitude2 = coerceVector(latitude2, REALSXP));
  PROTECT(longitude2 = coerceVector(longitude2, REALSXP));
  double a = REAL(pa)[0];
  double f = REAL(pf)[0];

  double *lat1, *lon1, *lat2, *lon2, *xr;
  lat1 = REAL(latitude1);
  lon1 = REAL(longitude1);
  lat2 = REAL(latitude2);
  lon2 = REAL(longitude2);

  double azi1, azi2, s12;
  struct geod_geodesic g;
  geod_init(&g, a, f);
  
  SEXP r;
  PROTECT( r = allocVector(REALSXP, 3 * length(latitude1) ));
  xr = REAL(r);  
  int i;
  for (i=0; i < length(latitude1); i++) {
    geod_inverse(&g, lat1[i], lon1[i], lat2[i], lon2[i], &s12, &azi1, &azi2);
    xr[i*3] = s12;
    xr[i*3+1] = azi1;
    xr[i*3+2] = azi2;
  }
  
  UNPROTECT(5);
  return r;
}


SEXP _polygonarea(SEXP longitude, SEXP latitude, SEXP pa, SEXP pf) {


  PROTECT(latitude = coerceVector(latitude, REALSXP));
  PROTECT(longitude = coerceVector(longitude, REALSXP));
  double *lat, *lon, *xr;
  lat = REAL(latitude);
  lon = REAL(longitude);

  double a = REAL(pa)[0];
  double f = REAL(pf)[0];
  
/*  double a = 6378137, f = 1/298.257223563;  WGS84 */
  double A, P;
  int n, i;
  struct geod_geodesic g;
  struct geod_polygon p;
  
  geod_init(&g, a, f);
  geod_polygon_init(&p, 0);

  for (i=0; i<length(latitude); i++) {
    geod_polygon_addpoint(&g, &p, lat[i], lon[i]);
  }
  
  n = geod_polygon_compute(&g, &p, 0, 1, &A, &P);
  
  SEXP r;
  PROTECT( r = allocVector(REALSXP, 3) );
  xr = REAL(r);  
  xr[0] = n;
  xr[1] = P;
  xr[2] = A;

  UNPROTECT(3);
  return(r);  
}
