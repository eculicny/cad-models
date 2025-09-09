module picture_frame_box_positive(backing_board_size_arr, frame_thickness, interior_wall_thickness) {
    backing_board_width = backing_board_size_arr[0];
    backing_board_height = backing_board_size_arr[1];

    linear_extrude(height=frame_thickness)
        square([backing_board_width + 2 * interior_wall_thickness, backing_board_height + 2 * interior_wall_thickness]);
}
