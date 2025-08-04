module roundcube_2d(size, radius) {
    x = size[0];
    y = size[1];
    z = size[2];
    r = radius;

    linear_extrude(height=z)
        hull() {
            // bottom
            translate([r, r, r])
                circle(r);
            translate([x - r, r, r])
                circle(r);
            translate([r, y - r, r])
                circle(r);
            translate([x - r, y - r, r])
                circle(r);
        }
}
