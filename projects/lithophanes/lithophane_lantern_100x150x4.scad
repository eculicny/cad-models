// rectangular lantern for 100x150x4 lithophanes
include <lithophane_lantern_rounded_top_cage.scad>

// material tolerance
tolerance = .15; // jessie petg

// [lithophane_width, lithophane_height, lithophane_border_thickness]
lithophane_size = [100 + 2 * tolerance, 150 + 2 * tolerance, 4 + 2 * tolerance];
lithophane_border_width = 3;

top_cage(lithophane_size=lithophane_size, border_width=lithophane_border_width);
