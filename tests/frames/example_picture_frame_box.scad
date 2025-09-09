use <frames/picture_frame_box.scad>

// viewing window size
viewing_window_width = 188.9125; // 7 7/16 in
viewing_window_height = 246.0625; // 9 11/16 in

// backing_board size
backing_board_width = 206.375;
backing_board_height = 258.7625;
backing_board_thickness = 3;

// frame sizing
thickness = 7; // frame thickness
interior_wall_thickness = 4; // wall thickness between frame and border
inset_ledge_width = 4; // inset ledge width
inset_ledge_thickness = 3; // inset ledge thickness/depth

picture_frame_box(
    viewing_window_size_arr=[viewing_window_width, viewing_window_height],
    backing_board_size_arr=[backing_board_width, backing_board_height, backing_board_thickness],
    frame_thickness=thickness,
    interior_wall_thickness=interior_wall_thickness
);

echo(actual);
