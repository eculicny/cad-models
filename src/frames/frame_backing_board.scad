include <frames/frame_hanging_teeth.scad>

module frame_backing_board(backing_board_size_arr, insert_thickness) {
    backing_board_width = backing_board_size_arr[0];
    backing_board_height = backing_board_size_arr[1];
    backing_board_thickness = backing_board_size_arr[2] - insert_thickness;

    union() {
        translate([backing_board_width / 2, backing_board_width / 5, 2 * backing_board_thickness - .1])
            frame_hanging_teeth();
        cube(size=[backing_board_width, backing_board_height, backing_board_thickness]);
    }
}
