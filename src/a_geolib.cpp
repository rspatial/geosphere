
#include "Rcpp.h"
#include <vector>
#include "OSGB.h"

//[[Rcpp::export(name = ".OSGB")]]
std::vector<std::string> osgb(std::vector<double> x, std::vector<double> y, std::string p, bool geo) {

	std::vector<std::string> glv = {"100km", "10km", "1km", "100m", "10m", "1m", "500km", "50km", "5km", "500m" , "50m", "5m"};

	int prec;
    auto it = std::find(glv.begin(), glv.end(), p);
    if (it != glv.end()) {
        prec = std::distance(glv.begin(), it);
    } else {
		return std::vector<std::string>(0);
	}
	
	bool fiver = false;
	if (prec > 5) {
		prec = prec - 6;
		fiver = true;
	}

	if (geo) {
		for (size_t i=0; i<x.size(); i++) {
			GeographicLib::OSGB::Forward(y[i], x[i], x[i], y[i]);
		}		
	}

	std::vector<std::string> out(x.size());
	for (size_t i=0; i<x.size(); i++) {
		GeographicLib::OSGB::GridReference(x[i], y[i], prec, out[i]);
	}
	
	if (fiver) {
		if (prec == 0) {
			for (size_t i=0; i<x.size(); i++) {
				if (out[i] != "INVALID") {
					out[i] = out[i].substr(0, 1);
				}
			}
		} else {
			size_t off = prec+1;
			for (size_t i=0; i<x.size(); i++) {
				if (out[i] != "INVALID") {
					std::string EW = out[i].substr(off, 1) < "5" ? "W" : "E";
					std::string NS = out[i].substr(off+prec, 1) < "5" ? "S" : "N";
					out[i] = out[i].substr(0, off) + out[i].substr(off+1, prec-1) + NS + EW;
				}
			}
		}
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

