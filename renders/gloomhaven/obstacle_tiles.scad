include <./gloomhaven_const.scad>
use <shapes/roundcube.scad>

module regular_polygon(order = 4, r = 1) {
    angles = [for (i = [0:order - 1]) i * (360 / order)];
    coords = [for (th = angles) [r * cos(th), r * sin(th)]];
    polygon(coords);
}

module hex_slots(dim = [3, 5], spacing = 1, slot_height = 10) {
    translate([0, 0, 0])for (i = [1:dim[0]]) {
        for (j = [1:dim[1]]) {
            translate([j * 20 + (j - 1) * (20 + 1), i * (10 * sqrt(3)) + (i - 1) * (1 + 10 * sqrt(3)), 0])
                linear_extrude(height=slot_height)
                    //rotate([0, 0, (360/6)/2])
                    regular_polygon(6, 20);
        }
    }
}

stack_height = 10 * MATERIAL_THICKNESS;

difference() {
    color("purple")
        roundcube([5 * 40 + 4 * 1, 2 * (20 * sqrt(3)) + 1 * 1, stack_height], RADIUS_EXT);
    //color("blue")
    translate([0, 0, MATERIAL_THICKNESS])
        hex_slots([2, 5], slot_height=stack_height);
}
