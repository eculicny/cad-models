include <./gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>

module standee_holder_box() {

    $fn = 200;
    base_box_wall = SMALL_CARD_BOX_WALL;
    base_box_floor = 2 * base_box_wall;
    base_box_x = SMALL_CARD_BOX_LENGTH;
    base_box_int_x = base_box_x - 2 * SMALL_CARD_BOX_WALL;
    base_box_int_y = SMALL_CARD_BOX_INT_WIDTH;
    base_box_y = base_box_int_y + 2 * SMALL_CARD_BOX_WALL + 2; // slightly widen to fit over the small card box
    base_box_z = STANDEE_BOX_HEIGHT;
    base_box_r = 2;
    combat_card_cutout_tolerance = 2;

    union() {
        difference() {
            roundcube_2d(size=[base_box_x, base_box_y, base_box_z], radius=base_box_r);
            translate(v=[base_box_wall, base_box_wall, base_box_floor])
                roundcube_2d(size=[base_box_int_x, base_box_int_y, base_box_z], radius=base_box_r);

            // awkward cutout for combat card box to sit on top
            translate(v=[base_box_x, base_box_y - (COMBAT_CARD_BOX_LENGTH - LARGE_CARD_BOX_WIDTH) - combat_card_cutout_tolerance, LARGE_CARD_BOX_HEIGHT - SMALL_CARD_BOX_HEIGHT])
                rotate(a=[0, 0, 90])
                    cube(size=[COMBAT_CARD_BOX_LENGTH, COMBAT_CARD_BOX_WIDTH + combat_card_cutout_tolerance, base_box_z]);
        }

        // TODO add feet to fit in the small card box better
    }
}
standee_holder_box();
