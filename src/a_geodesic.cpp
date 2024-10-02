
#include "Rcpp.h"
//#include "geodesic.h"
#include <vector>
#include "Geodesic.h"

#include "PolygonArea.h"
//#include "Constants.hpp"
#include "GeodesicLine.h"


//using namespace GeographicLib;

/* 
Robert Hijmans 
May 2015 
December 2021
*/
 
 
//SEXP _geodesic(SEXP longitude, SEXP latitude, SEXP azimuth, SEXP distance, SEXP pa, SEXP pf) {
/*
//[[Rcpp::export(name = ".geodesic")]]
std::vector<double> geodesic(std::vector<double> lon1, std::vector<double> lat1, std::vector<double> azi1, std::vector<double> s12, double a, double f) {
	struct geod_geodesic g;
	geod_init(&g, a, f);
	size_t n = lat1.size();
	std::vector<double> r(n * 3);
	for (size_t i=0; i < n; i++) {
		size_t j = i * 3;
		geod_direct(&g, lat1[i], lon1[i], azi1[i], s12[i], &r[j], &r[j+1], &r[j+2]);
	}
	return r;
}
*/


//[[Rcpp::export(name = ".geodesic")]]
std::vector<double> geodesic(std::vector<double> lon1, std::vector<double> lat1, std::vector<double> azi1, std::vector<double> s12, double a, double f) {
    GeographicLib::Geodesic geod(a, f);
	size_t n = lat1.size();
	std::vector<double> r(n * 3);
	for (size_t i=0; i < n; i++) {
		size_t j = i * 3;
		geod.Direct(lat1[i], lon1[i], azi1[i], s12[i], r[j+1], r[j], r[j+2]);
	}
	return r;
}
 
 
//SEXP _inversegeodesic(SEXP longitude1, SEXP latitude1, SEXP longitude2, SEXP latitude2, SEXP pa, SEXP pf) {
/*
//[[Rcpp::export(name = ".inversegeodesic")]]
std::vector<double> inversegeodesic(std::vector<double> lon1, std::vector<double> lat1, std::vector<double> lon2, std::vector<double> lat2, double a, double f) {
	struct geod_geodesic g;
	geod_init(&g, a, f);
	size_t n = lat1.size();
	std::vector<double> r(n * 3);
	for (size_t i=0; i < n; i++) {
		size_t j = i * 3;
		geod_inverse(&g, lat1[i], lon1[i], lat2[i], lon2[i], &r[j], &r[j+1], &r[j+2]);
	}
	return r;
}
*/
 
//[[Rcpp::export(name = ".inversegeodesic")]]
std::vector<double> inversegeodesic(std::vector<double> lon1, std::vector<double> lat1, std::vector<double> lon2, std::vector<double> lat2, double a, double f) {
	GeographicLib::Geodesic geod(a, f);
	size_t n = lat1.size();
	std::vector<double> r(n * 3);
	for (size_t i=0; i < n; i++) {
		size_t j = i * 3;
		geod.Inverse(lat1[i], lon1[i], lat2[i], lon2[i], r[j], r[j+1], r[j+2]);
	}
	return r;
}



//SEXP _polygonarea(SEXP longitude, SEXP latitude, SEXP pa, SEXP pf) {

/*
//[[Rcpp::export(name = ".polygonarea")]]
std::vector<double> polygonarea(std::vector<double> lon, std::vector<double> lat, double a, double f) {

	struct geod_geodesic g;
	struct geod_polygon p; 
	geod_init(&g, a, f);
	geod_polygon_init(&p, 0);
	double A, P;
	for (size_t i=0; i<lat.size(); i++) {
		geod_polygon_addpoint(&g, &p, lat[i], lon[i]);
	}
    double n = geod_polygon_compute(&g, &p, 0, 1, &A, &P);

	std::vector<double> r = {n, P, A};
	return(r);  
}
*/


//[[Rcpp::export(name = ".polygonarea")]]
std::vector<double> polygonarea(std::vector<double> lon, std::vector<double> lat, double a, double f) {
	std::vector<double> out(3); // n, perimeter, area;
	GeographicLib::Geodesic geod(a, f);
	GeographicLib::PolygonArea poly(geod);
	try {
		for (size_t i=0; i<lat.size(); i++) {
			poly.AddPoint(lat[i], lon[i]);
		}
		out[0] = poly.Compute(false, true, out[1], out[2]);
	} catch (...) {
		out= {-1, -1, -1};
    }
	return out;
}


//[[Rcpp::export(name = ".geod_intermediate")]]
std::vector<std::vector<double>> geodesic_nodes(double lon1, double lat1, double lon2, double lat2, size_t n, double distance, bool arc, double a, double f) {

    GeographicLib::Geodesic geod(a, f);
    GeographicLib::GeodesicLine line = geod.InverseLine(lat1, lon1, lat2, lon2);
	// number of intervals
    if (n == 0) {
		if (distance <= 0) {
			n = 1;
		} else {
			n = int(ceil(line.Distance() / std::abs(distance))); 
		}
	}
	std::vector<std::vector<double>> out(2);
	out[0].reserve(n+1);
	out[1].reserve(n+1);

	out[0].push_back(lon1);
	out[1].push_back(lat1);	
	if (arc) {
      // intervals of equal arc length
		double da = line.Arc() / n;
		for (size_t i=1; i<n; i++) {
			double lat, lon;
			line.ArcPosition(i * da, lat, lon);
			out[0].push_back(lon);
			out[1].push_back(lat);
		}
    } else 	{
      // intervals of equal length
		double ds = line.Distance() / n;
		for (size_t i=1; i<n; i++) {
			double lat, lon;
			line.Position(i * ds, lat, lon);
			out[0].push_back(lon);
			out[1].push_back(lat);
		}
    }

	out[0].push_back(lon2);
	out[1].push_back(lat2);
	return out;
}

