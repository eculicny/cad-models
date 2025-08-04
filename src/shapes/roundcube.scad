module roundcube(size, radius) {
    x = size[0];
    y = size[1];
    z = size[2];
    r = radius;

    hull() {
        // bottom
        translate([r, r, r])
            sphere(r);
        translate([x - r, r, r])
            sphere(r);
        translate([r, y - r, r])
            sphere(r);
        translate([x - r, y - r, r])
            sphere(r);

        // top
        translate([r, r, z - r])
            sphere(r);
        translate([x - r, r, z - r])
            sphere(r);
        translate([r, y - r, z - r])
            sphere(r);
        translate([x - r, y - r, z - r])
            sphere(r);
    }
}
