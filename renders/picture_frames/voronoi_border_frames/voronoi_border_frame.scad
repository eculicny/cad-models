use <frames/frame_box_negative.scad>
use <frames/frame_box_positive.scad>
use <frames/frame_backing_board_holder.scad>
use <shapes/voronoi_sheet_rand_fill.scad>
// need to include any libraries that rely on BOSL2 of separately include those dependencies
include <frames/frame_backing_board.scad>
include <BOSL2/std.scad>
include <BOSL2/threading.scad>

// replace with better lib version
module m3_bolt_hole(h) {
    difference() {
        cylinder(r=2.5, h=h, center=true, $fn=15);
        translate(v=[0, 0, 2])
            threaded_rod(d=3, height=h, pitch=.5, $fa=1, $fs=1, internal=true);
    }
}

module voronoi_border_frame(
    backing_board_size_arr,
    viewing_window_size_arr,
    frame_thickness,
    border_width,
    interior_wall_thickness,
    insert_thickness,
    voronoi_cell_size
) {
    backing_board_width = backing_board_size_arr[0];
    backing_board_height = backing_board_size_arr[1];
    backing_board_thickness = backing_board_size_arr[2];

    viewing_window_width = viewing_window_size_arr[0];
    viewing_window_height = viewing_window_size_arr[1];

    width_x = backing_board_width + 2 * border_width + 2 * interior_wall_thickness;
    height_y = backing_board_height + 2 * border_width + 2 * interior_wall_thickness;

    // frame definition
    difference() {
        union() {
            translate([-(backing_board_width / 2 + interior_wall_thickness), -(backing_board_height / 2 + interior_wall_thickness), 0])
                frame_box_positive(
                    backing_board_size_arr=[backing_board_width, backing_board_height, backing_board_thickness],
                    frame_thickness=frame_thickness,
                    interior_wall_thickness=interior_wall_thickness
                );
            // Initial voronoi generation looks shifted by half grid size on x-axis
            translate([-width_x / 2 + voronoi_cell_size / 4, -height_y / 2, 0])
                voronoi_sheet_rand_fill(
                    voronoi_space_size=[width_x, height_y],
                    voronoi_grid_w=voronoi_cell_size,
                    thickness=frame_thickness
                );
            translate(v=[backing_board_width / 2 + 1.25, backing_board_height / 2 + 1.25, (frame_thickness - 2) / 2 + 2])
                cylinder(r=2.5, h=frame_thickness - 2, center=true, $fn=15);
            translate(v=[-(backing_board_width / 2 + 1.25), backing_board_height / 2 + 1.25, (frame_thickness - 2) / 2 + 2])
                cylinder(r=2.5, h=frame_thickness - 2, center=true, $fn=15);
            translate(v=[backing_board_width / 2 + 1.25, -(backing_board_height / 2 + 1.25), (frame_thickness - 2) / 2 + 2])
                cylinder(r=2.5, h=frame_thickness - 2, center=true, $fn=15);
            translate(v=[-(backing_board_width / 2 + 1.25), -(backing_board_height / 2 + 1.25), (frame_thickness - 2) / 2 + 2])
                cylinder(r=2.5, h=frame_thickness - 2, center=true, $fn=15);
            translate(v=[backing_board_width / 2 + 2.5, 0, (frame_thickness - 2) / 2 + 2])
                cylinder(r=2.5, h=frame_thickness - 2, center=true, $fn=15);
            translate(v=[0, backing_board_height / 2 + 2.5, (frame_thickness - 2) / 2 + 2])
                cylinder(r=2.5, h=frame_thickness - 2, center=true, $fn=15);
            translate(v=[0, -(backing_board_height / 2 + 2.5), (frame_thickness - 2) / 2 + 2])
                cylinder(r=2.5, h=frame_thickness - 2, center=true, $fn=15);
            translate(v=[-(backing_board_width / 2 + 2.5), 0, (frame_thickness - 2) / 2 + 2])
                cylinder(r=2.5, h=frame_thickness - 2, center=true, $fn=15);
        }
        translate([-(backing_board_width / 2 + interior_wall_thickness), -(backing_board_height / 2 + interior_wall_thickness), 0])
            frame_box_negative(
                viewing_window_size_arr=viewing_window_size_arr,
                backing_board_size_arr=backing_board_size_arr,
                frame_thickness=frame_thickness,
                interior_wall_thickness=interior_wall_thickness
            );
        translate(v=[backing_board_width / 2 + 1.25, backing_board_height / 2 + 1.25, 2 + 2 + 2])
            threaded_rod(d=3, height=frame_thickness - 2, pitch=.5, $fa=1, $fs=1, internal=true);
        translate(v=[-(backing_board_width / 2 + 1.25), backing_board_height / 2 + 1.25, 2 + 2 + 2])
            threaded_rod(d=3, height=frame_thickness - 2, pitch=.5, $fa=1, $fs=1, internal=true);
        translate(v=[backing_board_width / 2 + 1.25, -(backing_board_height / 2 + 1.25), 2 + 2 + 2])
            threaded_rod(d=3, height=frame_thickness - 2, pitch=.5, $fa=1, $fs=1, internal=true);
        translate(v=[-(backing_board_width / 2 + 1.25), -(backing_board_height / 2 + 1.25), 2 + 2 + 2])
            threaded_rod(d=3, height=frame_thickness - 2, pitch=.5, $fa=1, $fs=1, internal=true);
        translate(v=[backing_board_width / 2 + 2.5, 0, 2 + 2 + 2])
            threaded_rod(d=3, height=frame_thickness - 2, pitch=.5, $fa=1, $fs=1, internal=true);
        translate(v=[0, backing_board_height / 2 + 2.5, 2 + 2 + 2])
            threaded_rod(d=3, height=frame_thickness - 2, pitch=.5, $fa=1, $fs=1, internal=true);
        translate(v=[0, -(backing_board_height / 2 + 2.5), 2 + 2 + 2])
            threaded_rod(d=3, height=frame_thickness - 2, pitch=.5, $fa=1, $fs=1, internal=true);
        translate(v=[-(backing_board_width / 2 + 2.5), 0, 2 + 2 + 2])
            threaded_rod(d=3, height=frame_thickness - 2, pitch=.5, $fa=1, $fs=1, internal=true);
    }

    // backing board
    translate([0, 0, 50])
        frame_backing_board([backing_board_width, backing_board_height, backing_board_thickness], insert_thickness=insert_thickness);

    // backing board holders
    for (i = [0:1:7]) {
        translate([-30 + (i * 13), 0, 25])
            frame_backing_board_holder();
    }

    // Voronoi space perimeter for centering
    // translate([-width_x / 2, -height_y / 2, 0])
    //     color(c="RED")
    //         difference() {
    //             linear_extrude(height=1)
    //                 square([width_x, height_y]);
    //             translate([1, 1, -1])
    //                 linear_extrude(height=3)
    //                     square([width_x - 2, height_y - 2]);
    //         }
}
