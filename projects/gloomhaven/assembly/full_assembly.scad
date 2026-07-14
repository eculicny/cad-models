use <../card_boxes/large_card_box.scad>
use <../card_boxes/small_card_box.scad>
use <../card_boxes/combat_card_box.scad>
use <../monster_boxes/monster_box_v1.scad>
use <../other_boxes/envelope_box.scad>
use <../other_boxes/manuals_box.scad>
use <../other_boxes/standee_holder_box.scad>
use <../class_boxes/miniature_box_holder.scad>
use <../hex_tile_boxes/tile_box_4x.scad>
use <../hex_tile_boxes/tile_box_6x.scad>
use <../hex_tile_boxes/tile_box_obstacles.scad>
use <../hex_tile_boxes/tile_box_summons.scad>
use <../hex_tile_boxes/base_stacked_token_box.scad>
use <../token_boxes/conditions_box.scad>
use <../token_boxes/damage_box.scad>
use <../token_boxes/gold_box.scad>
use <../map_tile_boxes/large_tile_box.scad>
use <../map_tile_boxes/small_tile_box.scad>
include <../gloomhaven_const.scad>

// needed for some modules
include <BOSL2/std.scad>

// TODO calculate
MONSTER_BOX_WIDTH = MONSTER_STAT_CARD_LENGTH + 2 * 2.35 + 0.1;
MONSTER_BOX_HEIGHT = 8.45;

// placeholder since it's still the default
module class_tuck_box() {
    cube(size=[PAPER_CLASS_BOX_LENGTH, PAPER_CLASS_BOX_HEIGHT, PAPER_CLASS_BOX_WIDTH]);
}

class_box_row_count = 18;
monster_box_normal_count_row_1 = 18;
monster_box_normal_count_row_2 = 7;
monster_box_large_count = 2;

/***** BOTTOM LAYER *****/

/* Class Tuck Boxes */
translate(v=[0, 0, PAPER_CLASS_BOX_LENGTH])
    union() {
        for (i = [0:class_box_row_count - 1]) {
            translate(v=[PAPER_CLASS_BOX_HEIGHT, i * (PAPER_CLASS_BOX_WIDTH + 1), 0])
                rotate(a=[0, 0, 90])
                    rotate(a=[0, 90, 0])
                        class_tuck_box();
        }

        translate(v=[PAPER_CLASS_BOX_HEIGHT + PAPER_CLASS_BOX_WIDTH + 1, class_box_row_count * (PAPER_CLASS_BOX_WIDTH + 1), 0])
            rotate(a=[0, 0, 180])
                rotate(a=[0, 90, 0])
                    class_tuck_box();
    }

/* Monster Boxes */
// TODO move calculations to consts
// normal
for (i = [0:monster_box_normal_count_row_1 - 1]) {
    translate(v=[0, i * (0.8 + (2 * (TOKEN_THICKNESS + 0.3)) + 0.75 + 1.9 + 1), 0])
        translate(v=[PAPER_CLASS_BOX_HEIGHT + MONSTER_STAT_CARD_LENGTH + 2 * 2.35 + 0.1, 0, MONSTER_STAT_CARD_LENGTH + 2.35 + 0.8 + 0.1 + 1.6])
            rotate(a=[0, 0, 90])
                rotate(a=[0, 90, 0])
                    monster_box_v1(2, 0.75);
}
for (i = [0:monster_box_normal_count_row_2 - 1]) {
    translate(v=[PAPER_CLASS_BOX_WIDTH + 1, i * (0.8 + (2 * (TOKEN_THICKNESS + 0.3)) + 0.75 + 1.9 + 1), 0])
        translate(v=[0, monster_box_normal_count_row_1 * (0.8 + (2 * (TOKEN_THICKNESS + 0.3)) + 0.75 + 1.9 + 1), 0])
            translate(v=[PAPER_CLASS_BOX_HEIGHT + MONSTER_STAT_CARD_LENGTH + 2 * 2.35 + 0.1, 0, MONSTER_STAT_CARD_LENGTH + 2.35 + 0.8 + 0.1 + 1.6])
                rotate(a=[0, 0, 90])
                    rotate(a=[0, 90, 0])
                        monster_box_v1(2, 0.75);
}
translate(v=[1, 0, 0])
    translate(v=[PAPER_CLASS_BOX_HEIGHT + MONSTER_STAT_CARD_LENGTH + 2 * 2.35 + 0.1, 0, MONSTER_STAT_CARD_LENGTH + 2.35 + 0.8 + 0.1 + 1.6])
        //rotate(a=[0, 0, 90])
        rotate(a=[0, 90, 0])
            monster_box_v1(2, 0.75);
// archer/guard
for (i = [0:monster_box_large_count - 1]) {
    translate(v=[0, i * (0.8 + (3 * (TOKEN_THICKNESS + 0.3)) + 1.9 + 1.9 + 1), 0])
        translate(v=[PAPER_CLASS_BOX_WIDTH + 1, (monster_box_normal_count_row_1 + monster_box_normal_count_row_2) * (0.8 + (2 * (TOKEN_THICKNESS + 0.3)) + 0.75 + 1.9 + 1), 0])
            translate(v=[PAPER_CLASS_BOX_HEIGHT + MONSTER_STAT_CARD_LENGTH + 2 * 2.35 + 0.1, 0, MONSTER_STAT_CARD_LENGTH + 2.35 + 0.8 + 0.1 + 1.6])
                rotate(a=[0, 0, 90])
                    rotate(a=[0, 90, 0])
                        monster_box_v1(3, 1.9);
}
// boss
translate(
    v=[
        PAPER_CLASS_BOX_WIDTH + 1,
        (monster_box_normal_count_row_1 + monster_box_normal_count_row_2) * (0.8 + (2 * (TOKEN_THICKNESS + 0.3)) + 0.75 + 1.9 + 1) + monster_box_large_count * (0.8 + (3 * (TOKEN_THICKNESS + 0.3)) + 1.9 + 1.9 + 1),
        0,
    ]
)
    translate(v=[PAPER_CLASS_BOX_HEIGHT + MONSTER_STAT_CARD_LENGTH + 2 * 2.35 + 0.1, 0, MONSTER_STAT_CARD_LENGTH + 2.35 + 0.8 + 0.1 + 1.6])
        rotate(a=[0, 0, 90])
            rotate(a=[0, 90, 0])
                monster_box_v1(5, 7);

translate(v=[PAPER_CLASS_BOX_HEIGHT + 1 + MONSTER_BOX_WIDTH + 1 + MONSTER_BOX_HEIGHT + 1, 0, 0])
    envelope_box();

translate(v=[PAPER_CLASS_BOX_HEIGHT + 1 + MONSTER_BOX_WIDTH + 1, TOKEN_BOX_Y + 1, 0])
    small_card_box();

translate(v=[PAPER_CLASS_BOX_HEIGHT + 1 + MONSTER_BOX_WIDTH + 1 + PAPER_CLASS_BOX_WIDTH + 1, TOKEN_BOX_Y + 1 + SMALL_CARD_BOX_WIDTH + 1, 0])
    large_card_box();

translate(v=[PAPER_CLASS_BOX_HEIGHT + 1 + MONSTER_BOX_WIDTH + 1 + PAPER_CLASS_BOX_WIDTH + 1, TOKEN_BOX_Y + 1 + SMALL_CARD_BOX_WIDTH + 1 + LARGE_CARD_BOX_WIDTH + 1, 0])
    miniature_box_holder();

/***** END BOTTOM LAYER *****/
/***** HEX BOX LAYERS *****/
translate(v=[PAPER_CLASS_BOX_HEIGHT + 1 + MONSTER_BOX_WIDTH + 1 + MONSTER_BOX_HEIGHT + 1, 0, 11 + 2 * 0.8 + 1])
    tile_box_6x();

translate(v=[PAPER_CLASS_BOX_HEIGHT + 1 + MONSTER_BOX_WIDTH + 1 + MONSTER_BOX_HEIGHT + 1, 0, (11 + 2 * 0.8) + 1 + token_box_z(6) + 1])
    tile_box_4x();

translate(v=[PAPER_CLASS_BOX_HEIGHT + 1 + MONSTER_BOX_WIDTH + 1 + MONSTER_BOX_HEIGHT + 1, 0, (11 + 2 * 0.8) + 1 + token_box_z(6) + 1 + token_box_z(4) + 1])
    tile_box_obstacles();

translate(v=[PAPER_CLASS_BOX_HEIGHT + 1 + MONSTER_BOX_WIDTH + 1 + MONSTER_BOX_HEIGHT + 1, 0, (11 + 2 * 0.8) + 1 + token_box_z(6) + 1 + token_box_z(4) + 1 + token_box_z(6) + 1])
    tile_box_summons();

/***** END HEX BOX LAYERS *****/

/***** STANDEE HOLDERS/CONDITIONS LAYER *****/
translate(v=[PAPER_CLASS_BOX_HEIGHT + 1 + MONSTER_BOX_WIDTH + 1 + MONSTER_BOX_HEIGHT + 1, 0, (11 + 2 * 0.8) + 1 + token_box_z(6) + 1 + token_box_z(4) + 1 + token_box_z(6) + 1 + token_box_z(6) + 1])
    conditions_box();

translate(v=[PAPER_CLASS_BOX_HEIGHT + 1 + MONSTER_BOX_WIDTH + 1, TOKEN_BOX_Y + 1, SMALL_CARD_BOX_HEIGHT + 1])
    standee_holder_box();

/***** END STANDEE HOLDERS/CONDITIONS LAYER *****/

/***** DAMAGE/COIN/COMBAT CARDS LAYER *****/
translate(v=[PAPER_CLASS_BOX_HEIGHT + 1 + MONSTER_BOX_WIDTH + 1 + MONSTER_BOX_HEIGHT + 1, 0, (11 + 2 * 0.8) + 1 + token_box_z(6) + 1 + token_box_z(4) + 1 + token_box_z(6) + 1 + token_box_z(6) + 1 + token_box_z(4) + 1])
    damage_box();

translate(v=[PAPER_CLASS_BOX_HEIGHT + 1 + MONSTER_BOX_WIDTH + 1 + MONSTER_BOX_HEIGHT + 1 + (50 + 1), 0, (11 + 2 * 0.8) + 1 + token_box_z(6) + 1 + token_box_z(4) + 1 + token_box_z(6) + 1 + token_box_z(6) + 1 + token_box_z(4) + 1])
    gold_box();

translate(v=[PAPER_CLASS_BOX_HEIGHT + 1 + MONSTER_BOX_WIDTH + 1 + PAPER_CLASS_BOX_WIDTH + 1 + (10), TOKEN_BOX_Y + 1 + SMALL_CARD_BOX_WIDTH + 1 + (-28), LARGE_CARD_BOX_HEIGHT + 1])
    combat_card_box();
/***** END DAMAGE/COIN/COMBAT CARDS LAYER *****/

/***** MAP TILE LATERS *****/
translate(v=[PAPER_CLASS_BOX_HEIGHT + 3, 0, (MONSTER_STAT_CARD_LENGTH + 2.35 + 0.8 + 0.1 + 1.6) + 1 + 5])
    large_tile_box();

translate(v=[0, 0, PAPER_CLASS_BOX_LENGTH + 5])
    cube(size=[MAP_BOARD_SIDE_LENGTH, MAP_BOARD_SIDE_LENGTH, MAP_BOARD_THICKNESS]);

translate(v=[0, 0, PAPER_CLASS_BOX_LENGTH + 5 + MAP_BOARD_THICKNESS + 2])
    manuals_box();

translate(v=[MANUALS_BOX_WIDTH + 2, 0, PAPER_CLASS_BOX_LENGTH + 5 + MAP_BOARD_THICKNESS + 2])
    small_tile_box();
/***** END MAP TILE LAYERS *****/
