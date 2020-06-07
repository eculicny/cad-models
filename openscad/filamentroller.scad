$fn = 100;

cylinder_height = 85;

cutout_side = 20;

cylinder_radius = sqrt(2*pow(cutout_side,2))/2 + 5;

difference(){
	cylinder(cylinder_height, r=cylinder_radius);
	linear_extrude(cylinder_height)
		square(cutout_side,center=true);
}