use <./picture_frame_box_positive.scad>
use <./picture_frame_box_negative.scad>

module picture_frame_box(viewing_window_size_arr, backing_board_size_arr, frame_thickness, interior_wall_thickness) {
    difference() {
        picture_frame_box_positive(
            backing_board_size_arr=backing_board_size_arr,
            frame_thickness=frame_thickness,
            interior_wall_thickness=interior_wall_thickness
        );
        picture_frame_box_negative(
            viewing_window_size_arr=viewing_window_size_arr,
            backing_board_size_arr=backing_board_size_arr,
            frame_thickness=frame_thickness,
            interior_wall_thickness=interior_wall_thickness
        );
    }
}
