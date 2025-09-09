use <polyline_join.scad>
use <voronoi/vrn2_cells_space.scad>
use <util/degrees.scad>
use <frames/picture_frame_box_negative.scad>
use <frames/picture_frame_box_positive.scad>

// 8 1/8 x 10 3/16, lip 1/4
// 206.375 x 258.7625, lip 6.35
// TODO little big currently, mesasure actual frame viewing window

// image size
viewing_window_width = 197; //188.9125; // 7 7/16 in
viewing_window_height = 250; //246.0625; // 9 11/16 in

// backboard size
backing_board_width = 207; // 206.375;
backing_board_height = 260; // 258.7625;
backing_board_thickness = 3;

// frame sizing
border_width = 20; // border width (excluding inset)
frame_thickness = 7; // frame thickness
interior_wall_thickness = 1; // wall thickness between inset and border

// voronoi cell size
grid_w = 10;

width_x = backing_board_width + 2 * border_width + 2 * interior_wall_thickness;
height_y = backing_board_height + 2 * border_width + 2 * interior_wall_thickness;

// switched to uniform for better dovetail joints due to print area size for large frame
function filled_probability(x, y, max_x, max_y) =
    // sin(degrees(x / max_x * PI + PI / 2)) * cos(degrees(y / max_y * PI)) * .5 * .7 + 0.5;
    .5;

module voronoi_border(voronoi_space_size, voronoi_grid_w, thickness) {
    cells = vrn2_cells_space(voronoi_space_size, voronoi_grid_w);
    // pregenerated random numbers
    filled_nums = rands(0, 1, len(cells));
    for (i = [0:len(cells) - 1]) {
        cell = cells[i];
        cell_pt = cell[0];
        cell_poly = cell[1];

        linear_extrude(frame_thickness)
            polyline_join([each cell_poly, cell_poly[0]])
                circle(.5);
        if (filled_nums[i] > filled_probability(cell_pt[0], cell_pt[1], voronoi_space_size[0], voronoi_space_size[1])) {
            translate([0, 0, 2])
                translate(cell_pt)
                    linear_extrude(frame_thickness - 2)
                        translate(-cell_pt)
                            polygon(cell_poly);
        }
    }
}

// frame definition
difference() {
    union() {
        translate([-(backing_board_width / 2 + interior_wall_thickness), -(backing_board_height / 2 + interior_wall_thickness), 0])
            picture_frame_box_positive(
                backing_board_size_arr=[backing_board_width, backing_board_height, backing_board_thickness],
                frame_thickness=frame_thickness,
                interior_wall_thickness=interior_wall_thickness
            );
        // Initial voronoi generation looks shifted by half grid size on x-axis
        translate([-width_x / 2 + grid_w / 4, -height_y / 2, 0])
            voronoi_border(
                voronoi_space_size=[width_x, height_y],
                voronoi_grid_w=grid_w,
                thickness=frame_thickness
            );
    }
    translate([-(backing_board_width / 2 + interior_wall_thickness), -(backing_board_height / 2 + interior_wall_thickness), 0])
        picture_frame_box_negative(
            viewing_window_size_arr=[viewing_window_width, viewing_window_height, frame_thickness],
            backing_board_size_arr=[backing_board_width, backing_board_height, backing_board_thickness],
            frame_thickness=frame_thickness,
            interior_wall_thickness=interior_wall_thickness
        );
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
