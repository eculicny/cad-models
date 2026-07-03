use <shapes/roundcube.scad>
use <boxes/box_lid.scad>
use <boxes/box_text.scad>
include <./gloomhaven_const.scad>

large_x = LARGE_CARD_WIDTH;
large_y = LARGE_CARD_LENGTH;
small_x_ = SMALL_CARD_WIDTH;
small_y_ = SMALL_CARD_LENGTH;
inset_y = CLASS_STAT_CARD_WIDTH;
inset_x = CLASS_STAT_CARD_LENGTH;

full_lid_x = MATERIAL_THICKNESS + inset_x - 2; // -1 padding
full_lid_y = 2 * MATERIAL_THICKNESS + inset_y - MATERIAL_THICKNESS - .5; // -.5 padding

height_z = 2 * MATERIAL_THICKNESS + CLASS_ACTION_DECK_COUNT * CARD_THICKNESS + CARDBOARD_THICKNESS + 1;

//CARDBOARD_THICKNESS;
inneredge_height = height_z - MATERIAL_THICKNESS - CARDBOARD_THICKNESS - 1;

text_val = "";

$fn = 150;

module splitDoubleBox(inset_size, small_size, large_size, z, slot, inneredge_height, r, mt, angle, box_text) {
    small_x = small_size[0];
    small_y = small_size[1];

    large_x = large_size[0];
    large_y = large_size[1];

    inx = inset_size[0];
    iny = inset_size[1];

    slot_height = slot[0];
    slot_offset = slot[1];

    inx_usable = large_x + small_x + mt / 2;
    iny_usable = max(large_y, 2 * small_y + mt / 2);

    x = 2 * mt + inx;
    y = 2 * mt + iny;

    difference() {
        roundcube([x, y, z], r);

        // lid slot
        translate([mt, mt / 2, z - slot_height - slot_offset])
            union() {
                translate([x / 2, (y - mt) / 2, .5])
                    linear_extrude(3, scale=[1, angle])
                        square([x, y - mt], center=true);
                linear_extrude(.5)
                    square([x, y - mt]);
            }
        // trims overhang edge of slot
        translate([mt, mt, z - slot_height - slot_offset])
            cube([x, y - 2 * mt, z]);

        // text engraving
        translate([mt, mt / 4, (z + mt) / 4])
            rotate([90, 0, 0])
                box_text(z, mt, box_text);

        // space between lid and top of box for card
        color("blue")
            translate([mt, mt, inneredge_height])
                cube([inx, iny, 2 * z]);

        // individual card holes
        color("purple")
            translate([x / 2 - (small_x + mt / 2 + large_x) / 2, 3 / 2 * mt, mt])
                union() {
                    // smaller boxes on the left
                    roundcube([small_x, small_y, z], r);
                    translate([0, y - 3 * mt - small_y, 0])
                        roundcube([small_x, small_y, z], r);

                    // large box on the right
                    translate([small_x + mt, iny_usable / 2 - large_y / 2, 0])
                        roundcube([large_x, large_y, z], r);

                    // center cutout
                    translate([small_x - x / 8, small_y - y / 8, 0])
                        roundcube([x / 4, y / 4, height_z], r);
                }
    }
}

splitDoubleBox([inset_x, inset_y], [small_x_, small_y_], [large_x, large_y], height_z, [SLOT_HEIGHT, SLOT_OFFSET], inneredge_height, RADIUS_EXT, MATERIAL_THICKNESS - 1, LID_SCALE, text_val);

//translate([MATERIAL_THICKNESS - 1, .75, height_z - MATERIAL_THICKNESS])
//translate([0, inset_y + 40,0])
//color("yellow")
//	boxLid([full_lid_x, full_lid_y], MATERIAL_THICKNESS, LID_SCALE);
