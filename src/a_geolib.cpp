
#include "Rcpp.h"
//#include "geodesic.h"
#include <vector>
#include "Geodesic.h"

#include "OSGB.h"
#include "Utility.h"

//[[Rcpp::export(name = ".OSGB")]]
std::vector<std::string> osgb(std::vector<double> x, std::vector<double> y, int prec) {

	std::vector<std::string> out(x.size());
	for (size_t i=0; i<x.size(); i++) {
		GeographicLib::OSGB::GridReference(x[i], y[i], prec, out[i]);
	}
	return out;
}
 