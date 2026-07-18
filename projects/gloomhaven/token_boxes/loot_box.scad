include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <shapes/roundcube.scad>
use <Round-Anything/polyround.scad>
use <Round-Anything/unionRoundMask.scad>

module gold_box() {

// 159.2mm x ~40mm to work with (2mm acrylic sheet)

token_stack_height = 6;

$fn = 100;
gold_5_slot_length = 2 * (GOLD_5_DIAMETER + GENERAL_HORIZONTAL_TOKEN_TOLERANCE);
gold_5_slot_width = GOLD_5_DIAMETER + GENERAL_HORIZONTAL_TOKEN_TOLERANCE;
base_box_r = 2;
base_box_floor = 2 * GENERAL_WALL_THICKNESS;
base_box_wall = 2 * GENERAL_WALL_THICKNESS;
base_box_x = gold_5_slot_length + 2 * base_box_wall;
base_box_y = TOKEN_BOX_Y;
base_box_z = token_box_z(token_stack_height=token_stack_height);

difference() {
    roundcube_2d(size=[base_box_x, base_box_y, base_box_z], radius=base_box_r);

    // box for stacking 5 golds
    translate(v=[base_box_wall, base_box_wall, base_box_floor])
        roundcube_2d(
            size=[
                gold_5_slot_length,
                gold_5_slot_width,
                base_box_z,
            ], radius=base_box_r
        );

    // attached slot for stacking treasure chest
    translate(v=[base_box_wall, gold_5_slot_width + 2 * base_box_wall, base_box_floor])
        roundcube_2d(size=[TREASURE_CHEST_SLOT_WIDTH, TREASURE_CHEST_SLOT_LENGTH, base_box_z], radius=base_box_r);
    // cutout
    translate(v=[-TREASURE_CHEST_SLOT_WIDTH / 2, gold_5_slot_width + 2 * base_box_wall + TREASURE_CHEST_SLOT_WIDTH / 4, base_box_floor])
        roundcube_2d(size=[TREASURE_CHEST_SLOT_WIDTH, TREASURE_CHEST_SLOT_WIDTH, base_box_z], radius=base_box_r);

    // attached box for chaotic 1 golds
    // TODO switch to round anything to round interior corner
    translate(v=[base_box_wall, gold_5_slot_width + 2 * base_box_wall, base_box_floor])
        linear_extrude(height=base_box_z)
            round2d(2, 2)
                union() {
                    translate(v=[0, TREASURE_CHEST_SLOT_LENGTH + base_box_wall, 0])
                        square(size=[base_box_x - 2 * base_box_wall, base_box_y - 2 * base_box_wall - TREASURE_CHEST_SLOT_LENGTH - base_box_wall - gold_5_slot_width - base_box_wall]);
                    translate(v=[base_box_x - (base_box_x - TREASURE_CHEST_SLOT_WIDTH - 2 * base_box_wall) - base_box_wall, 0, 0])
                        square(size=[base_box_x - TREASURE_CHEST_SLOT_WIDTH - 3 * base_box_wall, base_box_y - gold_5_slot_width - 3 * base_box_wall]);
                }
}
}
gold_box();
