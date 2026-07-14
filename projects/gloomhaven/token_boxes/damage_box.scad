include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <shapes/roundcube.scad>
use <Round-Anything/polyround.scad>
use <Round-Anything/unionRoundMask.scad>

module damage_box() {

// 159.2mm x ~40mm to work with (2mm acrylic sheet)

token_stack_height = 6; // set stack height to match other box heights

$fn = 100;

// damage
// TODO long box for falling stack 10s -- 61mm long x token width x 11mm high
// TODO long box for falling stack 5s -- slightly shorter (~50) x token width x 11mm high (for 6 of them)
// TODO box for chaotic 1s
base_box_floor = 2 * GENERAL_WALL_THICKNESS;
base_box_wall = 2 * GENERAL_WALL_THICKNESS;
gold_5_slot_length = 2 * (GOLD_5_DIAMETER + GENERAL_HORIZONTAL_TOKEN_TOLERANCE); // TODO move this to build constants
base_box_x = 50;
base_box_y = TOKEN_BOX_Y;
base_box_z = token_box_z(token_stack_height=token_stack_height);
base_box_r = 2;

hp_large_slot_width = HP_LARGE_DIAMETER + 2 * GENERAL_HORIZONTAL_TOKEN_TOLERANCE;
hp_large_slot_length = 61;
hp_medium_slot_width = HP_MEDIUM_DIAMETER + 2 * GENERAL_HORIZONTAL_TOKEN_TOLERANCE;
hp_medium_slot_length = 50;

difference() {
    roundcube_2d(size=[base_box_x, base_box_y, base_box_z], radius=base_box_r);
    translate(v=[base_box_wall, base_box_wall, base_box_floor])
        roundcube_2d(size=[base_box_x - 2 * base_box_wall, hp_large_slot_width, base_box_z], radius=base_box_r);
    translate(v=[base_box_wall, hp_large_slot_width + 2 * base_box_wall, base_box_floor])
        roundcube_2d(size=[base_box_x - 2 * base_box_wall, hp_medium_slot_width * 1.5, base_box_z], radius=base_box_r);
    translate(v=[base_box_wall, hp_large_slot_width + hp_medium_slot_width * 1.5 + 3 * base_box_wall, base_box_floor])
        roundcube_2d(size=[base_box_x - 2 * base_box_wall, base_box_y - 4 * base_box_wall - hp_large_slot_width - hp_medium_slot_width * 1.5, base_box_z], radius=base_box_r);
}
}
damage_box();
