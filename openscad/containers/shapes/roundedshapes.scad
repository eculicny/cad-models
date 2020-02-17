r = .1;
z = .5;
x = 6.25;
y = 4.25;

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
translate([-3,0,0])
roundcube_2d([x,y,z],r);

color("red")
roundcube([x,y,z],r);