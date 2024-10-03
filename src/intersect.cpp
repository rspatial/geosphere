/*

// https://sourceforge.net/p/geographiclib/discussion/1026621/thread/21aaff9f/?page=1#51e7

// Find intersection of two geodesics

#include <iostream>
#include <iomanip>
#include <GeographicLib/Gnomonic.hpp>
#include <GeographicLib/Geodesic.hpp>

class vector3 {
public:
  double _x, _y, _z;
  vector3(double x, double y, double z = 1) throw()
    : _x(x)
    , _y(y)
    , _z(z) {}
  vector3 cross(const vector3& b) const throw() {
    return vector3(_y * b._z - _z * b._y,
                   _z * b._x - _x * b._z,
                   _x * b._y - _y * b._x);
  }
  void norm() throw() {
    _x /= _z;
    _y /= _z;
    _z = 1;
  }
};

int intersect(double lata1, double lona1, double lata2, double lona2, double latb1, double lonb1, double latb2, double lonb2) {
  const GeographicLib::Geodesic& geod = GeographicLib::Geodesic::WGS84();
  const GeographicLib::Gnomonic gn(geod);
  double 
    lat0 = (lata1 + lata2 + latb1 + latb2)/4,
    // Possibly need to deal with longitudes wrapping around
    lon0 = (lona1 + lona2 + lonb1 + lonb2)/4;
  std::cout << std::setprecision(16);
  std::cout << "Initial guess " << lat0 << " " << lon0 << "\n";
  for (int i = 0; i < 10; ++i) {
    double xa1, ya1, xa2, ya2;
    double xb1, yb1, xb2, yb2;
    gn.Forward(lat0, lon0, lata1, lona1, xa1, ya1);
    gn.Forward(lat0, lon0, lata2, lona2, xa2, ya2);
    gn.Forward(lat0, lon0, latb1, lonb1, xb1, yb1);
    gn.Forward(lat0, lon0, latb2, lonb2, xb2, yb2);
    // See Hartley and Zisserman, Multiple View Geometry, Sec. 2.2.1
    vector3 va1(xa1, ya1); vector3 va2(xa2, ya2);
    vector3 vb1(xb1, yb1); vector3 vb2(xb2, yb2);
    // la is homogeneous representation of line A1,A2
    // lb is homogeneous representation of line B1,B2
    vector3 la = va1.cross(va2);
    vector3 lb = vb1.cross(vb2);
    // p0 is homogeneous representation of intersection of la and lb
    vector3 p0 = la.cross(lb);
    p0.norm();
    double lat1, lon1;
    gn.Reverse(lat0, lon0, p0._x, p0._y, lat1, lon1);
    std::cout << "Increment " << lat1-lat0 << " " << lon1-lon0 << "\n";
    lat0 = lat1;
    lon0 = lon1;
  }
  std::cout  << "Final result " << lat0 << " " << lon0 << "\n";
  double azi1, azi2;
  geod.Inverse(lata1, lona1, lat0, lon0, azi1, azi2);
  std::cout << "Azimuths on line A " << azi2 << " ";
  geod.Inverse(lat0, lon0, lata2, lona2, azi1, azi2);
  std::cout << azi1 << "\n";
  geod.Inverse(latb1, lonb1, lat0, lon0, azi1, azi2);
  std::cout << "Azimuths on line B " << azi2 << " ";
  geod.Inverse(lat0, lon0, latb2, lonb2, azi1, azi2);
  std::cout << azi1 << "\n";
}



// Find interception of a geodesic from a point

int intercept(double lata1, lona1, lata2, lona2, double latb1, lonb1) {
  const GeographicLib::Geodesic& geod = GeographicLib::Geodesic::WGS84();
  const GeographicLib::Gnomonic gn(geod);
  double
    lat0 = (lata1 + lata2)/2,
    // Possibly need to deal with longitudes wrapping around
    lon0 = (lona1 + lona2)/2;
  std::cout << std::setprecision(16);
  std::cout << "Initial guess " << lat0 << " " << lon0 << "\n";
  for (int i = 0; i < 10; ++i) {
    double xa1, ya1, xa2, ya2;
    double xb1, yb1;
    gn.Forward(lat0, lon0, lata1, lona1, xa1, ya1);
    gn.Forward(lat0, lon0, lata2, lona2, xa2, ya2);
    gn.Forward(lat0, lon0, latb1, lonb1, xb1, yb1);
    // See Hartley and Zisserman, Multiple View Geometry, Sec. 2.2.1
    vector3 va1(xa1, ya1); vector3 va2(xa2, ya2);
    // la is homogeneous representation of line A1,A2
    vector3 la = va1.cross(va2);
    vector3 vb1(xb1, yb1);
    // lb is homogeneous representation of line thru B1 perpendicular to la
    vector3 lb(la._y, -la._x, la._x * yb1 - la._y * xb1);
    // p0 is homogeneous representation of intersection of la and lb
    vector3 p0 = la.cross(lb);
    p0.norm();
    double lat1, lon1;
    gn.Reverse(lat0, lon0, p0._x, p0._y, lat1, lon1);
    std::cout << "Increment " << lat1-lat0 << " " << lon1-lon0 << "\n";
    lat0 = lat1;
    lon0 = lon1;
  }
  std::cout  << "Final result " << lat0 << " " << lon0 << "\n";
  double azi1, azi2;
  geod.Inverse(lat0, lon0, lata1, lona1, azi1, azi2);
  std::cout << "Azimuth to A1 " << azi1 << "\n";
  geod.Inverse(lat0, lon0, lata2, lona2, azi1, azi2);
  std::cout << "Azimuth to A2 " << azi1 << "\n";
  geod.Inverse(lat0, lon0, latb1, lonb1, azi1, azi2);
  std::cout << "Azimuth to B1 " << azi1 << "\n";
}

*/
