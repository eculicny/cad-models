include <lithophane_lantern_rounded_top_cage.scad>
// need to include any libraries that rely on BOSL2 of separately include those dependencies
include <BOSL2/std.scad>
include <BOSL2/threading.scad>

// material tolerance
tolerance = .15; // jessie petg

// [lithophane_width, lithophane_height, lithophane_border_thickness]
lithophane_size = [100 + 2 * tolerance, 150 + 2 * tolerance, 4 + 2 * tolerance];
border_width = 3;

base_edge = 4;
base_thickness = 8;
lx = lithophane_size[0];
ly = lithophane_size[1];
lz = lithophane_size[2];

// square support
support_thickness = 2 * lz;
// add border width since supports are height of lithophane
y = ly + base_thickness + border_width;
x = lx + 2 * support_thickness - 2 * border_width + 2 * base_edge;

module bolt_hole() {
    union() {
        // bolt hole m3-4
        threaded_rod(d=3, height=40, pitch=.5, $fa=1, $fs=1, internal=true);
        translate([0, 0, -20])
            cylinder(h=base_thickness / 2, r=3);
    }
}

difference() {
    linear_extrude(height=base_thickness)
        rounded_square(size=[x, x], corner_r=5, center=true);
    difference() {
        translate([0, 0, base_thickness - border_width])
            linear_extrude(height=base_thickness)
                square(size=[x - 2 * base_edge, x - 2 * base_edge], center=true);
        translate([0, 0, base_thickness - border_width])
            linear_extrude(height=base_thickness)
                square(size=[x - 2 * base_edge - 2 * lz, x - 2 * base_edge - 2 * lz], center=true);
    }
    // remove wire hole and lamp hole
    translate(v=[0, 0, -5])
        cylinder(h=base_thickness + 10, r=15);
    rotate(a=[0, 90, 0])
        cylinder(h=y / 2, r=2 * base_thickness / 3);
    // remove top cage insets
    translate([0, 0, y])
        rotate(a=[180, 0, 0])
            top_cage(lithophane_size, border_width);
    // remove screw holes
    // corner supports
    for (i = [0:1:4]) {
        rotate([0, 0, i * 90])
            translate(
                v=[
                    -x / 2 + support_thickness / 2 + base_edge / 4,
                    -x / 2 + support_thickness / 2 + base_edge / 4,
                    20,
                ]
            )
                bolt_hole();
    }
}

// rotate([0, 0, 90])
//     translate(
//         v=[
//             -x / 2 + support_thickness / 2 + base_edge / 4,
//             -x / 2 + support_thickness / 2 + base_edge / 4,
//             20,
//         ]
//     )
//         bolt_hole();

// translate([0, 0, y])
//     rotate(a=[180, 0, 0])
//         top_cage(lithophane_size, border_width);
