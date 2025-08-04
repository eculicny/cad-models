use <shapes/roundcube_2d.scad>

r = 5;
z = 50;
x = 600;
y = 400;

$fn = 50;

color("green")
    translate([-x, 0, 0])
        roundcube_2d([x, y, z], r);
