use <rounded_square.scad>
// use <polyline_join.scad>
// need to include any libraries that rely on BOSL2 of separately include those dependencies
include <BOSL2/std.scad>
include <BOSL2/threading.scad>

// supports
module support(lithophane_size, border_width, base_edge, base_thickness) {
    x = lithophane_size[0];
    y = lithophane_size[1] + base_thickness - border_width;
    z = lithophane_size[2];

    support_thickness = base_edge + 2 * z;

    difference() {
        union() {
            linear_extrude(y)
                rounded_square(size=[support_thickness, support_thickness], corner_r=5, center=true);
            // flattening corners
            rotate([0, 0, 90])
                cube(size=[support_thickness / 2, support_thickness / 2, y]);
            rotate([0, 0, 270])
                cube(size=[support_thickness / 2, support_thickness / 2, y]);
        }
        // corner cut
        translate(v=[support_thickness / 4, support_thickness / 4])
            cube(size=[support_thickness / 4, support_thickness / 4, y]);
        // lithophane slots
        translate([support_thickness / 2 - border_width / 2, 0, y / 2 - 1])
            cube([border_width, z, y + 5], center=true);
        rotate([0, 0, 90])
            translate([support_thickness / 2 - border_width / 2, 0, y / 2 - 1])
                cube([border_width, z, y + 5], center=true);
        // bolt hole m3-4
        translate([-1, -1, y - 3])
            threaded_rod(d=3, height=40, pitch=.5, $fa=1, $fs=1, internal=true);

        // translate(v=[support_thickness/2, .5, y / 2])
        //     rotate(a=[90, 0, 0])
        //         linear_extrude(2)
        //             draw_spirals(scrolls);
        // translate(v=[-1.5, support_thickness/2, y / 2 + 1])
        //     rotate(a=[90, 0, 90])
        //         linear_extrude(2)
        //             draw_spirals(scrolls);
    }
}

// base plate(s)
module top_cage(lithophane_size, border_width, base_edge = 4, base_thickness = 8) {
    lx = lithophane_size[0];
    ly = lithophane_size[1];
    lz = lithophane_size[2];

    // square support
    support_thickness = 2 * lz;

    x = lx + 2 * support_thickness - 2 * border_width + 2 * base_edge;
    echo(x, support_thickness);

    union() {
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
        }
        // corner supports
        for (i = [0:1:4]) {
            rotate([0, 0, i * 90])
                translate(
                    v=[
                        -x / 2 + support_thickness / 2 + base_edge / 2,
                        -x / 2 + support_thickness / 2 + base_edge / 2,
                        0,
                    ]
                )
                    support(lithophane_size, border_width, base_edge, base_thickness);
        }
    }
}

$fn = 40;

//top_cage(lithophane_size, border_width);
