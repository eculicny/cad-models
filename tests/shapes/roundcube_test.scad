use <shapes/roundcube.scad>

r = 5;
z = 50;
x = 600;
y = 400;

$fn = 50;

difference() {
    color("red")
        roundcube([x, y, z], r);
    color("blue")
        translate([3, 3, 0])
            roundcube([x - 6, y - 6, z], r);
}
