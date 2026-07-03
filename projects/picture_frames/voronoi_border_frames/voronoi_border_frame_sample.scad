// need to include any libraries that rely on BOSL2 of separately include those dependencies
include <voronoi_border_frame.scad>

// image size
viewing_window_width = 60;
viewing_window_height = 80;

// backboard size
backing_board_width = 70;
backing_board_height = 90;
backing_board_thickness = 6;
// size of displayed stuff/glass
insert_thickness = 3;

// frame sizing
border_width = 10; // border width (excluding inset)
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
