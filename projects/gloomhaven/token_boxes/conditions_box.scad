include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <shapes/roundcube.scad>
use <Round-Anything/polyround.scad>
use <Round-Anything/unionRoundMask.scad>

module conditions_box() {

// 159.2mm x ~40mm to work with (2mm acrylic sheet)

token_stack_height = 4;

$fn = 200;

// statuses
base_box_wall = 2 * GENERAL_WALL_THICKNESS;
base_box_floor = 2 * GENERAL_WALL_THICKNESS;
base_box_x = TOKEN_BOX_X / 3;
base_box_y = TOKEN_BOX_Y / 3;
base_box_z = token_box_z(token_stack_height=token_stack_height);
base_box_r = base_box_wall; // 2;
int_base_box_x = base_box_x - 2 * base_box_wall;
int_base_box_y = base_box_y - 2 * base_box_wall;
int_cutout_radius = 1.8 * int_base_box_y;

for (i = [0:2]) {
    for (j = [0:2]) {
        translate(v=[i * (base_box_x - base_box_wall), j * (base_box_y - base_box_wall), 0])
            difference() {
                roundcube_2d(size=[base_box_x, base_box_y, base_box_z], radius=base_box_r);

                // rounded box cutout
                translate(v=[base_box_wall, base_box_wall, base_box_floor])
                    roundcube(size=[int_base_box_x, int_base_box_y, 2 * base_box_z], radius=7);
            }
    }
}
}
conditions_box();
