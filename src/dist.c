/* Robert Hijmans, June 2011 */

#include    <R.h>
#include	<stdio.h>
#include	<stdlib.h>
#include	<math.h>
#include "Rmath.h"
#include "util.h"





double distPlane(double x1, double y1, double x2, double y2) {
	return( sqrt(pow((x2-x1),2) + pow((y2-y1), 2)) );
}


double distCos(double lon1, double lat1, double lon2, double lat2, double r) {
	double cosd;
	lon1 = toRad(lon1);
	lon2 = toRad(lon2);
	lat1 = toRad(lat1);
	lat2 = toRad(lat2);
	cosd = sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(lon1-lon2);
	return acos(cosd) * r;
}


double distHav(double lon1, double lat1, double lon2, double lat2, double r) {

	double dLat, dLon, a;

	lon1 = toRad(lon1);
	lon2 = toRad(lon2);
	lat1 = toRad(lat1);
	lat2 = toRad(lat2);

	dLat = lat2-lat1;
	dLon = lon2-lon1;
	a = sin(dLat/2.) * sin(dLat/2.) + cos(lat1) * cos(lat2) * sin(dLon/2.) * sin(dLon/2.);
	return 2. * atan2(sqrt(a), sqrt(1.-a)) * r;
}




double distVinSph(double lon1, double lat1, double lon2, double lat2, double r) {

	double x, x1, x2, y;

	lon1 = toRad(lon1);
	lon2 = toRad(lon2);
	lat1 = toRad(lat1);
	lat2 = toRad(lat2);

	x1 = sqrt(cos(lat2) * sin(lon1-lon2));
	x2 = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon1-lon2);
	x = x1*x1 + x2*x2;
	y = sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(lon1-lon2);
	
	return r * atan2(x, y);
}



double distVinEll(double lon1, double lat1, double lon2, double lat2, double a, double b, double f) {
/*  Vincenty Inverse Solution of Geodesics on the Ellipsoid (c) Chris Veness 2002-2009           
 Calculate geodesic distance (in m) between two points specified by latitude/longitude 
 (in numeric degrees) using Vincenty inverse formula for ellipsoids
 based on source http://www.movable-type.co.uk/scripts/latlong-vincenty.html (c) 2002-2009 Chris Veness
*/
	double L, U1, U2, sinU1, cosU1, sinU2, cosU2, lambda, sinLambda, cosLambda, sinSigma, 
			cosSigma, sigma, sinAlpha, cosSqAlpha, cos2SigmaM, C, lambdaP, uSq, A, B, deltaSigma;
			
	int iterLimit, cont;

	if ((lon1 == lon2) & (lat1 == lat2))  {

		return 0.;
		
	} else if ( isnan(lon1) | isnan(lat1) | isnan(lon2) | isnan(lat2)) {
	
		return R_NaReal;
		
	} else {
		
		lon1 = toRad(lon1);
		lon2 = toRad(lon2);
		lat1 = toRad(lat1);
		lat2 = toRad(lat2);
	
		L = (lon2-lon1);
		U1 = atan((1.-f) * tan(lat1));
		U2 = atan((1.-f) * tan(lat2));
		sinU1 = sin(U1);
		cosU1 = cos(U1);
		sinU2 = sin(U2);
		cosU2 = cos(U2);
		lambda = L;
		iterLimit = 100;
		cont = 1;
		
		while (cont) {
			sinLambda = sin(lambda);
			cosLambda = cos(lambda);
			sinSigma = sqrt((cosU2*sinLambda) * (cosU2*sinLambda) + (cosU1*sinU2-sinU1*cosU2*cosLambda) * (cosU1*sinU2-sinU1*cosU2*cosLambda));
			
			cosSigma = sinU1*sinU2 + cosU1*cosU2*cosLambda;
			sigma = atan2(sinSigma, cosSigma);
			sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma;
			cosSqAlpha = 1. - sinAlpha*sinAlpha;
			cos2SigmaM = cosSigma - 2.*sinU1*sinU2/cosSqAlpha;
			
			if (isnan(cos2SigmaM)) {
				cos2SigmaM = 0.;  // equatorial line: cosSqAlpha=0 (§6)
			}
				
			C = f/16.*cosSqAlpha*(4.+f*(4.-3.*cosSqAlpha));
			lambdaP = lambda;
			lambda = L + (1.-C) * f * sinAlpha * (sigma + C*sinSigma*(cos2SigmaM+C*cosSigma*(-1.+2.*cos2SigmaM*cos2SigmaM)));
			
			iterLimit = iterLimit - 1;
			cont = (fabs(lambda-lambdaP) > 1e-12 && iterLimit > 0);
		} 
		
		if (iterLimit==0) {
			return R_NaReal;  // formula failed to converge
		} else {
			uSq = cosSqAlpha * (a*a - b*b) / (b*b);
			A = 1. + uSq/16384.*(4096.+uSq*(-768.+uSq*(320.-175.*uSq)));
			B = uSq/1024. * (256.+uSq*(-128.+uSq*(74.-47.*uSq)));
			deltaSigma = B*sinSigma*(cos2SigmaM+B/4.*(cosSigma*(-1.+2.*cos2SigmaM*cos2SigmaM)- B/6.*cos2SigmaM*(-3.+4.*sinSigma*sinSigma)*(-3.+4.*cos2SigmaM*cos2SigmaM)));
			return  b*A*(sigma-deltaSigma);
		}
	}
}


void distanceEllipsoid(int *n, double *lon1, double *lat1, double *lon2, double *lat2, double *a, double *b, double *f, int *m, double *dist) {
	int i;
	if (*m > 0) {
		for(i=0; i < *n; i++) {
			dist[i] = distVinEll(lon1[i], lat1[i], lon2[i], lat2[i], a[i], b[i], f[i]);
		}
	}
}

