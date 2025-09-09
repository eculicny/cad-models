module picture_frame_box_negative(viewing_window_size_arr, backing_board_size_arr, frame_thickness, interior_wall_thickness) {
    viewing_window_width = viewing_window_size_arr[0];
    viewing_window_height = viewing_window_size_arr[1];

    backing_board_width = backing_board_size_arr[0];
    backing_board_height = backing_board_size_arr[1];
    backing_board_thickness = backing_board_size_arr[2];

    inset_ledge_size_x = (backing_board_width - viewing_window_width)/2;
    inset_ledge_size_y = (backing_board_height - viewing_window_height)/2;

    union() {
        // inset cut
        translate([interior_wall_thickness, interior_wall_thickness, backing_board_thickness])
            linear_extrude(height=frame_thickness + 5)
                square([viewing_window_width + 2 * inset_ledge_size_x, viewing_window_height + 2 * inset_ledge_size_y]);
        // viewing window cut
        translate([interior_wall_thickness + inset_ledge_size_x, interior_wall_thickness + inset_ledge_size_y, -1])
            linear_extrude(height=frame_thickness + 5)
                square([viewing_window_width, viewing_window_height]);
    }
}
