
refEllipsoids <- function() {

data.frame(
	ellipsoid = 
		c('Airy (1930)', 'Australian National', 'Bessel 1841', 'Ethiopia,  Indonesia,  Japan,  Korea', 'Namibia', 'Clarke 1866', 'Clarke 1880', 'Everest - Brunei & E. Malasia (Sabah & Sarawak)', 'Everest - India 1830', 'Everest - India 1956', 'Everest - Pakistan', 'Everest - W. Malasia and Singapore 1948', 'Everest - W. Malasia 1969', 'Geodetic Reference System 1980 (GRS 80)', 'Helmert 1906', 'Hough 1960', 'Indonesian 1974', 'International 1924', 'Krassovsky 1940', 'Modified Airy', 'Modified Fischer 1960 (South Asia)', 'South American 1969', 'World Geodetic System 1972 (WGS 72)', 'World Geodetic System 1984 (WGS 84)'),  

	code = 
		c('AA', 'AN', '??', 'BR', 'BN', 'CC', 'CD', 'EB', 'EA', 'EC', 'EF', 'EE', 'ED', 'RF', 'HE', 'HO', 'ID', 'IN', 'KA', 'AM', 'FA', 'SA', 'WD', 'WE'),  

	invf = 
		c(299.3249646, 298.25, 299.1528434, 299.1528128, 299.1528128, 294.9786982, 293.465, 300.8017, 300.8017, 300.8017, 300.8017, 300.8017, 300.8017, 298.2572221, 298.3, 297, 298.247, 297, 298.3, 299.3249646, 298.3, 298.25, 298.26, 298.2572236), 
		
	a = 
		c(6377563.396, 6378160, 6377397.155, 6377397.155, 6377483.865, 6378206.4, 6378249.145, 6377298.556, 6377276.345, 6377301.243, 6377309.613, 6377304.063, 6377295.664, 6378137, 6378200, 6378270, 6378160, 6378388, 6378245, 6377340.189, 6378155, 6378160, 6378135, 6378137), 
  
  	stringsAsFactors=FALSE ) 

}

