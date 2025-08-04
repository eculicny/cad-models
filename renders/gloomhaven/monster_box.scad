include <./gloomhaven_const.scad>
use <boxes/split_box.scad>
use <boxes/standard_box.scad>
use <boxes/box_lid.scad>
use <boxes/box_text.scad>

inset_thickness = 1.5; // ~distance between the lid and top ledge for ability cards
token_stack_count = 3;
$fn = 150;

SLOT_INSET = MATERIAL_THICKNESS;

interior_x = MONSTER_STAT_CARD_LENGTH + 1; //+1 padding
interior_y = MONSTER_STAT_CARD_WIDTH + 1; //+1 padding
small_interior_x = MONSTER_ABILITY_CARD_LENGTH + 2; // +2 padding
small_interior_y = MONSTER_ABILITY_CARD_WIDTH + 2; // +2 padding

height_z = 2 * MATERIAL_THICKNESS + token_stack_count * TOKEN_THICKNESS + 1; //1 padding

inneredge_height = MATERIAL_THICKNESS + token_stack_count * TOKEN_THICKNESS + 1 - inset_thickness;

full_x = 2 * MATERIAL_THICKNESS + interior_x;
full_y = 2 * MATERIAL_THICKNESS + interior_y;

full_lid_x = full_x - MATERIAL_THICKNESS - .5; // .5 padding
full_lid_y = full_y - SLOT_INSET;

// array arguments
lid_dim_xy = [full_lid_x, full_lid_y];
box_dim_xyz = [full_x, full_y, height_z];
box_small_dim_xy = [small_interior_x, small_interior_y];
slot_vars = [SLOT_HEIGHT, SLOT_OFFSET];

color("blue")
    translate([0, -15, 0])
        mirror([0, 1, 0]) {
            box_text(height_z, MATERIAL_THICKNESS, BOSS);
        }

translate([-5 / 4 * full_x, 0, 0])
    standardBox(box_dim_xyz, slot_vars, SLOT_INSET, RADIUS_EXT, MATERIAL_THICKNESS, LID_SCALE, BOSS);

splitBox(box_dim_xyz, box_small_dim_xy, slot_vars, SLOT_INSET, inneredge_height, RADIUS_EXT, MATERIAL_THICKNESS, LID_SCALE, BOSS);

translate([0, full_y + 30, 0])
    color("purple")
        boxLid(lid_dim_xy, MATERIAL_THICKNESS, LID_SCALE);
