r = 5;
z = 50;
x = 600;
y = 400;

$fn=50;

module roundcube(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];
	r = radius;
	
	hull()
	{
		// bottom
		translate([r,r,r])
		sphere(r);
		translate([x-r,r,r])
		sphere(r);
		translate([r,y-r,r])
		sphere(r);
		translate([x-r,y-r,r])
		sphere(r);

		// top
		translate([r,r,z-r])
		sphere(r);
		translate([x-r,r,z-r])
		sphere(r);
		translate([r,y-r,z-r])
		sphere(r);
		translate([x-r,y-r,z-r])
		sphere(r);
	}
}

module roundcube_2d(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];
	r = radius;

	linear_extrude(height=z)
	hull()
	{
		// bottom
		translate([r,r,r])
		circle(r);
		translate([x-r,r,r])
		circle(r);
		translate([r,y-r,r])
		circle(r);
		translate([x-r,y-r,r])
		circle(r);
	}
}

color("green")
translate([-x,0,0])
roundcube_2d([x,y,z],r);

difference(){
	color("red")
		roundcube([x,y,z],r);
	color("blue")
	translate([3, 3,0])
		roundcube([x-6,y-6,z],r);
}