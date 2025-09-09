use <polyline_join.scad>
use <voronoi/vrn2_cells_space.scad>

// voronoi cell size
grid_w = 10;

width_x = 200;
height_y = 100;

cells = vrn2_cells_space([width_x, height_y], grid_w, 100);

for (cell = cells) {
    cell_pt = cell[0];
    cell_poly = cell[1];

    linear_extrude(.5)
        polyline_join([each cell_poly, cell_poly[0]])
            circle(.5);
}

color(c="RED")
    difference() {
        linear_extrude(height=1)
            square([width_x, height_y]);
        translate([1, 1, -1])
            linear_extrude(height=3)
                square([width_x - 2, height_y - 2]);
    }

color(c="BLUE")
    translate(v=[-grid_w, -grid_w, 0])
        difference() {
            linear_extrude(height=1)
                square([width_x + 2 * grid_w, height_y + 2 * grid_w]);
            translate([1, 1, -1])
                linear_extrude(height=3)
                    square([width_x + 2 * grid_w - 2, height_y + 2 * grid_w - 2]);
        }
