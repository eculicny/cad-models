include <./gloomhaven_const.scad>
use <shapes/roundcube.scad>

$fn = 150;

module regular_polygon(order = 4, r = 1) {
    angles = [for (i = [0:order - 1]) i * (360 / order)];
    coords = [for (th = angles) [r * cos(th), r * sin(th)]];
    polygon(coords);
}

module double_hex(length) {
    translate([length, length / 2 * sqrt(3), 0])
        union() {
            translate([3 / 2 * length, length / 2 * sqrt(3), 0])
                regular_polygon(6, length);
            regular_polygon(6, length);
        }
}

module triple_hex(length) {
    translate([length, length / 2 * sqrt(3), 0])
        rotate([0, 0, 360 / 6])
            union() {
                translate([3 / 2 * length, length / 2 * sqrt(3), 0])
                    regular_polygon(6, length);
                translate([3 / 2 * length, -length / 2 * sqrt(3), 0])
                    regular_polygon(6, length);
                regular_polygon(6, length);
            }
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

stack_height = 10 * TOKEN_THICKNESS;

difference() {
    union() {
        color("purple")
            roundcube([3 * (3 * 20) + 2 * 2 + 10, 3 * 20 / 2 * sqrt(3), stack_height], RADIUS_EXT);

        color("blue")
            translate([2 * 3 * 20 + 2, 0, 0])
                roundcube([3 * 20 + 10 + 2, 4 * 20 / 2 * sqrt(3), stack_height], RADIUS_EXT);
    }

    translate([0, 0, MATERIAL_THICKNESS])
        linear_extrude(height=stack_height)
            union() {
                double_hex(20);

                color("blue")
                    translate([3 * 20 + 2, 0, 0])
                        double_hex(20);

                color("purple")
                    translate([6 * 20 + 4, 0, 0])
                        triple_hex(20);
            }

    translate([20, 3 * 20 / 2 * sqrt(3) - HP_MEDIUM_DIAMETER / 2 + 2, MATERIAL_THICKNESS])
        cylinder(h=stack_height, r=HP_MEDIUM_DIAMETER / 2);
    translate([4 * 20 + 2, 3 * 20 / 2 * sqrt(3) - HP_MEDIUM_DIAMETER / 2 + 2, MATERIAL_THICKNESS])
        cylinder(h=stack_height, r=HP_MEDIUM_DIAMETER / 2);

    translate([2 * 20 + 10, HP_SMALL_DIAMETER / 2 - .5, MATERIAL_THICKNESS])
        cylinder(h=stack_height, r=HP_SMALL_DIAMETER / 2);
    translate([5 * 20 + 10 + 2, HP_SMALL_DIAMETER / 2 - .5, MATERIAL_THICKNESS])
        cylinder(h=stack_height, r=HP_SMALL_DIAMETER / 2);
    translate([8 * 20 + 10 + 4, HP_SMALL_DIAMETER / 2 - .5, MATERIAL_THICKNESS])
        cylinder(h=stack_height, r=HP_SMALL_DIAMETER / 2);
}

//HP_SMALL_DIAMETER = 14;
//HP_SMALL_COUNT = 28;
//HP_MEDIUM_DIAMETER = 18;
//HP_MEDIUM_COUNT = 12;
//HP_LARGE_DIAMETER = 24;
//HP_LARGE_COUNT = 6;
