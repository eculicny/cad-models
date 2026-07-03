// need to include any libraries that rely on BOSL2 of separately include those dependencies
include <voronoi_border_frame.scad>

// 8 1/8 x 10 3/16, lip 1/4
// 206.375 x 258.7625, lip 6.35
// TODO little big currently, mesasure actual frame viewing window

// image size
viewing_window_width = 197; //188.9125; // 7 7/16 in
viewing_window_height = 250; //246.0625; // 9 11/16 in

// backboard size
backing_board_width = 207; // 206.375;
backing_board_height = 260; // 258.7625;
backing_board_thickness = 6;
// size of displayed stuff/glass
insert_thickness = 3;

// frame sizing
border_width = 20; // border width (excluding inset)
frame_thickness = 8; // frame thickness
interior_wall_thickness = 1; // wall thickness between inset and border
voronoi_cell_size = 10;

voronoi_border_frame(
    backing_board_size_arr=[backing_board_width, backing_board_height, backing_board_thickness],
    viewing_window_size_arr=[viewing_window_width, viewing_window_height],
    frame_thickness=frame_thickness,
    border_width=border_width,
    interior_wall_thickness=interior_wall_thickness,
    insert_thickness=insert_thickness,
    voronoi_cell_size=voronoi_cell_size
);
