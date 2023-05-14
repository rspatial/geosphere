
#include "Rcpp.h"
//#include "geodesic.h"
#include <vector>
#include "Geodesic.h"

#include "OSGB.h"
#include "Utility.h"

//[[Rcpp::export(name = ".OSGB")]]
std::vector<std::string> osgb(std::vector<double> x, std::vector<double> y, int prec, bool geo) {

	if (geo) {
		for (size_t i=0; i<x.size(); i++) {
			GeographicLib::OSGB::Forward(y[i], x[i], x[i], y[i]);
			Rcpp::Rcout << x[i] << ", " << y[i] << std::endl;
		}		
	}

	std::vector<std::string> out(x.size());
	for (size_t i=0; i<x.size(); i++) {
		GeographicLib::OSGB::GridReference(x[i], y[i], prec, out[i]);
	}
	return out;
}
 
//[[Rcpp::export(name = ".OSGBinv")]]
std::vector<double> osgb_rev(std::vector<std::string> g, int prec, bool centerp) {
	size_t n = g.size();
	std::vector<double> out(2 * n);
	for (size_t i=0; i<g.size(); i++) {
		GeographicLib::OSGB::GridReference(g[i], out[i], out[i+n], prec, centerp);
	}
	return out;
}

