#include <math.h>

#ifndef M_PI
#define M_PI  (3.1415926535897932384626433)
#endif

#ifndef M_2PI
#define M_2PI (3.1415926535897932384626433 * 2.0)
#endif

#ifndef M_PI_2 
#define M_PI_2 (3.1415926535897932384626433 / 2)
#endif



double mod(double x, double n) {
	return(x - n * floor(x/n));
}

double normalizeLonDeg(double lon) {
	return( mod( (lon + 180), 360 ) - 180 );
}

double normalizeLonRad(double lon) {
	return( mod( (lon + M_PI), M_2PI) - M_PI);
}


/* Convert degrees to radians */
double toRad(double deg) {
	return deg * 0.0174532925199433;
}

double toDeg(double rad) {
	return rad * 57.2957795130823 ;
}



