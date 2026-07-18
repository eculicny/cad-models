include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>

module small_tile_box() {

    $fn = 100;
    base_box_r = 2;
    base_box_wall = 2 * GENERAL_WALL_THICKNESS;
    base_box_full_x = GAME_BOX_INTERIOR_LENGTH - MANUALS_BOX_WIDTH;
    base_box_full_int_x = base_box_full_x - 2 * base_box_wall;
    // -1 for map board tolerance
    base_box_depression_x = GAME_BOX_INTERIOR_LENGTH - MAP_BOARD_SIDE_LENGTH - 1;
    base_box_depression_int_x = base_box_depression_x - 2 * base_box_wall;
    base_box_y = F_MAP_TILE_LENGTH + 0.4 + 0.8; // tolerance + 2x 0.4mm thin walls
    base_box_int_y = base_box_y - 2 * base_box_wall;
    base_box_short_z = MANUALS_BOX_HEIGHT;
    // +1 for map board tolerance
    base_box_long_z = GAME_BOX_INTERIOR_HEIGHT - PAPER_CLASS_BOX_LENGTH + 1;

    difference() {
        union() {
            roundcube_2d(size=[base_box_full_x, base_box_y, base_box_short_z], radius=base_box_r);
            // depression shell
            translate(v=[base_box_full_x - base_box_depression_x, 0, -(base_box_long_z - base_box_short_z)])
                roundcube_2d(size=[base_box_depression_x, base_box_y, base_box_long_z], radius=base_box_r);
        }

        translate(v=[base_box_wall, base_box_wall, base_box_wall])
            union() {
                // main cutout
                roundcube_2d(size=[base_box_full_int_x, base_box_int_y, base_box_short_z], radius=base_box_r);
                // depression cutout with hardcoded adjustments to remove y-walls
                translate(v=[base_box_full_x - base_box_depression_x, -3, -(base_box_long_z - base_box_short_z)])
                    cube(size=[base_box_depression_int_x, base_box_y + 5, base_box_long_z]);
            }
    }
}
small_tile_box();
