use <./frame_box_positive.scad>
use <./frame_box_negative.scad>

module frame_box(viewing_window_size_arr, backing_board_size_arr, frame_thickness, interior_wall_thickness) {
    difference() {
        frame_box_positive(
            backing_board_size_arr=backing_board_size_arr,
            frame_thickness=frame_thickness,
            interior_wall_thickness=interior_wall_thickness
        );
        frame_box_negative(
            viewing_window_size_arr=viewing_window_size_arr,
            backing_board_size_arr=backing_board_size_arr,
            frame_thickness=frame_thickness,
            interior_wall_thickness=interior_wall_thickness
        );
    }
}
