include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>

/**************************TODO: CHANGE THESE VALUES**************************/
/*
    1.4mm - for >1 stat card (guard/archer/imps)
    0.75mm - for 1 stat card
*/
stat_card_depression = 0.75;
/*
    2 for most
    3 for guards/archers
    ? for Boss
*/
standee_layer_count = 2;
/******************************END CHANGE VALUES*******************************/

/*
    Lid Slot
*/
module lid_slot(ridges, length, overhang_width) {
    translate(v=[base_box_wall, length, 0])
        rotate(a=[90, 0, 0])for (i = [0:ridges - 1]) {
            translate(v=[0, -i * lid_overhang_height, 0])
                linear_extrude(height=length)
                    union() {
                        // split wall out to have some structure for slot
                        polygon(points=[[0, 0], [0, -lid_overhang_height], [overhang_width - base_box_wall, 0]], paths=[[0, 1, 2]]);
                        polygon(points=[[0, 0], [0, -lid_overhang_height], [-base_box_wall, -lid_overhang_height], [-base_box_wall, 0]], paths=[[0, 1, 2, 3]]);
                    }
        }
}

$fn = 60;

stat_card_tolerance = 0.1;
ability_card_tolerance = 0.1;
lid_overhang_width = 2.35;
lid_overhang_height = 1.9; // reduced from 2.2, 2.1 prints
initiative_slot_ext_width = 5.1 - lid_overhang_width;
initiative_slot_width = initiative_slot_ext_width;
initiative_slot_outer_length = 47.3;
initiative_slot_inner_length = 47.3 + 2 * 2.1; // increased from 1.9
initiative_cutout_edge = 43;
base_box_wall = 0.8;
initiative_slot_lip_height = base_box_wall + 1.2;
initiative_slot_lip_width = base_box_wall;
base_box_r = 2;
base_box_x = MONSTER_STAT_CARD_LENGTH + 2 * lid_overhang_width + stat_card_tolerance;
base_box_y = MONSTER_STAT_CARD_LENGTH + lid_overhang_width + base_box_wall + stat_card_tolerance; // only one slot

ability_card_corner_wall = 1.2;
ability_card_corner_length = 13.2; //includes wall technically
ability_card_box_x = MONSTER_ABILITY_CARD_WIDTH + ability_card_tolerance;
ability_card_box_y = MONSTER_ABILITY_CARD_LENGTH + ability_card_tolerance;

stat_card_overhang_width = lid_overhang_width + 2;
stat_card_cutout_width = 20;
stat_card_cutout_height = 10;

// standdard height for initiative marker
// base_box_z = 11.9; // height not including slot
/*
    minimized height for 1-tile stacks
    - cardboard measures 2.2mm (0.3 for buffer and slight difference with ability card stack)
*/
base_box_z = base_box_wall + (standee_layer_count * TOKEN_THICKNESS + 0.3);

union() {
    /*
        Base Box w/o Lid Slot/Overhang
    */
    difference() {
        cube(size=[base_box_x, base_box_y, base_box_z]);

        translate(v=[base_box_wall, base_box_wall, base_box_wall])
            roundcube_2d(
                size=[
                    base_box_x - 2 * base_box_wall,
                    base_box_y - 2 * base_box_wall,
                    base_box_z + 5,
                ],
                radius=base_box_r
            );
        /*
            Stat card cutout
        */
        // extra modifications to translation are "centering" for aesthetics
        translate(v=[stat_card_cutout_width / 2 + 2 * lid_overhang_width - base_box_wall, 5, base_box_z + base_box_wall])
            rotate(a=[90, 90, 0])
                scale([stat_card_cutout_height, stat_card_cutout_width, 1])
                    cylinder(h=5, d=1);
    }

    /*
        Ability card corner
    */
    translate(
        v=[
            // lid_overhang_width removed to make taking cards out easier and not catching them on the overhang
            base_box_x - base_box_wall - ability_card_corner_length,
            base_box_y - base_box_wall - ability_card_box_y - lid_overhang_width,
            0,
        ]
    )
        linear_extrude(height=base_box_z - stat_card_depression)
            square(size=[ability_card_corner_length, ability_card_corner_wall]);
    translate(
        v=[
            // lid_overhang_width removed to make taking cards out easier and not catching them on the overhang
            base_box_x - base_box_wall - ability_card_box_x - lid_overhang_width,
            base_box_y - base_box_wall - ability_card_corner_length,
            0,
        ]
    )
        translate(v=[ability_card_corner_wall, 0, 0])
            rotate(a=[0, 0, 90])
                linear_extrude(height=base_box_z - stat_card_depression)
                    square(size=[ability_card_corner_length, ability_card_corner_wall]);

    // left side slot
    translate([0, 0, lid_overhang_height + base_box_z])
        lid_slot(2, base_box_y, lid_overhang_width);
    // right side slot
    translate([base_box_x, base_box_y, lid_overhang_height + base_box_z])
        rotate([0, 0, -180])
            lid_slot(2, base_box_y, lid_overhang_width);
    // back side slot
    translate([0, base_box_y, lid_overhang_height + base_box_z])
        rotate([0, 0, -90])
            lid_slot(1, base_box_x, lid_overhang_width);

    /*
        Stat Card Overhang
    */
    // to the top of the box at the depression distance from the bottom of the lid slot
    // back ledge
    translate([0, base_box_y, base_box_z - stat_card_depression])
        rotate([0, 0, -90])
            lid_slot(1, base_box_y, stat_card_overhang_width);
    // front ledge
    translate([base_box_x, 0, base_box_z - stat_card_depression])
        rotate([0, 0, 90])
            // +2 for padding
            lid_slot(1, base_box_y - stat_card_cutout_width - 2 * lid_overhang_width, stat_card_overhang_width);

    /*
        Initiative marker slot
    */
    difference() {
        translate(v=[-initiative_slot_ext_width, 0, 0])
            cube(size=[initiative_slot_ext_width, base_box_y, base_box_z + lid_overhang_height]);

        // center box cut
        translate(v=[-initiative_slot_ext_width, base_box_y / 2 - initiative_slot_outer_length / 2, initiative_slot_lip_height])
            cube(size=[initiative_slot_width, initiative_slot_outer_length, base_box_z + lid_overhang_height]);
        // slot bos cut
        translate(v=[-initiative_slot_ext_width + base_box_wall, base_box_y / 2 - initiative_slot_inner_length / 2, base_box_wall / 2])
            cube(size=[initiative_slot_width - initiative_slot_lip_width, initiative_slot_inner_length, base_box_z + lid_overhang_height]);
        // bottom slot
        translate([-initiative_cutout_edge, base_box_y / 2 - initiative_cutout_edge / 2, -1])
            roundcube_2d([initiative_cutout_edge, initiative_cutout_edge, 5], 5);
    }
}
