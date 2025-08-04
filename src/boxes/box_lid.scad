module boxLid(size, mt, angle) {
    x = size[0];
    y = size[1];

    divot_depth = 1;

    difference() {
        translate([x / 2, y / 2, 0])
            linear_extrude(3, scale=[1, angle])
                square([x, y], center=true);

        translate([mt, y / 2 - (1 / 4 * y) / 2, mt - divot_depth])
            linear_extrude(divot_depth)
                square([mt, 1 / 4 * y]);
    }
}
