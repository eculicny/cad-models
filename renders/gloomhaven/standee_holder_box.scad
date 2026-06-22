include <./gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <Round-Anything/polyround.scad>
use <Round-Anything/unionRoundMask.scad>

$fn = 200;
card_tolerance = 1.5;
base_box_wall = 0.8;
base_box_floor = 2 * base_box_wall;
base_box_x = 150;
base_box_int_x = base_box_x - 2 * base_box_wall;
base_box_int_y = SMALL_CARD_LENGTH + card_tolerance;
base_box_y = base_box_int_y + 2 * base_box_wall;
base_box_z = 30.8; // monster box - small card box height
base_box_r = 2;

difference() {
    roundcube_2d(size=[base_box_x, base_box_y, base_box_z], radius=base_box_r);
    translate(v=[base_box_wall, base_box_wall, base_box_floor])
        roundcube_2d(size=[base_box_int_x, base_box_int_y, base_box_z], radius=base_box_r);
}
