use <polyline_join.scad>
use <voronoi/vrn2_cells_space.scad>
use <util/degrees.scad>

// switched to uniform for better dovetail joints due to print area size for large frame
function filled_probability(x, y, max_x, max_y) =
    // sin(degrees(x / max_x * PI + PI / 2)) * cos(degrees(y / max_y * PI)) * .5 * .7 + .5;
    .5;

module voronoi_sheet_rand_fill(voronoi_space_size, voronoi_grid_w, thickness) {
    cells = vrn2_cells_space(voronoi_space_size, voronoi_grid_w);
    // pregenerated random numbers
    filled_nums = rands(0, 1, len(cells));
    for (i = [0:len(cells) - 1]) {
        cell = cells[i];
        cell_pt = cell[0];
        cell_poly = cell[1];

        linear_extrude(thickness)
            polyline_join([each cell_poly, cell_poly[0]])
                circle(.5);
        if (filled_nums[i] > filled_probability(cell_pt[0], cell_pt[1], voronoi_space_size[0], voronoi_space_size[1])) {
            translate([0, 0, 2])
                translate(cell_pt)
                    linear_extrude(thickness - 2)
                        translate(-cell_pt)
                            polygon(cell_poly);
        }
    }
}
