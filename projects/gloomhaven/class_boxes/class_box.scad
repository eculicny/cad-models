include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <Round-Anything/polyround.scad>

// Stored Objects
// Ability cards unlocked/locked
// Modifier cards unlocked/locked
// Player modifier deck slot
// Items acquired
// class tokens (5x)
// Note pad
// Character board

// Features
// Image on lid?
// Image on short side (circle insert)
// Player # insert (circle insert?)
// writing implement - ~8mm for pencil

/*
    Height reqs
        - class paper box - 16mm
        - ability card stack - 9mm (preferably 9.5, old was 10)
        - stat card - 2.3mm (+.1)
        - notepad - 1mm (+.1)

    Internal req - 9.5 + 2.3 + 1 = 12.8 (13)
    Lid + floor = 15.5 - 13 = 2.5
    lid height = 2.5 - floor = 1.7
         - split 1.5 and 0.2 for extra height
*/

$fn = 200;
lid_overhang_height = 1.5;
lid_overhang_width = 2.3;
base_box_wall = 2 * GENERAL_WALL_THICKNESS;
base_box_floor = 0.8;
base_box_x = PAPER_CLASS_BOX_LENGTH;
base_box_y = PAPER_CLASS_BOX_HEIGHT;
base_box_z = PAPER_CLASS_BOX_WIDTH - lid_overhang_height;
base_box_r = 2;
small_card_slot_width = SMALL_CARD_WIDTH + 2;
small_card_slot_length = SMALL_CARD_LENGTH + 2;
large_card_slot_width = LARGE_CARD_WIDTH + 2;
large_card_slot_length = LARGE_CARD_LENGTH + 2;
tab_spacing = 10;
top_slot_width = 13;
top_slot_wider_width = 17.4; // estimated due to rounding of objects

lid_wall = lid_overhang_width + base_box_wall;
class_notepad_slot_length = CLASS_NOTEPAD_LENGTH + 1;
class_notepad_slot_width = CLASS_NOTEPAD_WIDTH + 1;
class_notepad_slot_thickness = CLASS_NOTEPAD_THICKNESS + 0.1;

class_icon_cutout_radius = 5;

module lid_slot(ridges, length, overhang_width, overhang_height) {
    translate(v=[GENERAL_WALL_THICKNESS, length, 0])
        rotate(a=[90, 0, 0])for (i = [0:ridges - 1]) {
            translate(v=[0, -i * overhang_height, 0])
                linear_extrude(height=length)
                    union() {
                        // split wall out to have some structure for slot
                        polygon(points=[[0, 0], [0, -overhang_height], [overhang_width - GENERAL_WALL_THICKNESS, 0]], paths=[[0, 1, 2]]);
                        polygon(points=[[0, 0], [0, -overhang_height], [-GENERAL_WALL_THICKNESS, -overhang_height], [-GENERAL_WALL_THICKNESS, 0]], paths=[[0, 1, 2, 3]]);
                    }
        }
}

difference() {
    union() {
        cube(size=[base_box_x, base_box_y, base_box_z]);
        // front slot
        translate(v=[base_box_x, base_box_y, base_box_z + lid_overhang_height])
            rotate(a=[0, 0, 180])
                lid_slot(1, base_box_y, lid_overhang_width, lid_overhang_height);
        // side slot
        translate(v=[0, base_box_y, base_box_z + lid_overhang_height])
            rotate(a=[0, 0, -90])
                lid_slot(1, base_box_x, lid_overhang_width, lid_overhang_height);
        // back slot
        translate(v=[0, 0, base_box_z + lid_overhang_height])
            lid_slot(1, base_box_y, lid_overhang_width, lid_overhang_height);
    }

    translate(v=[0, 0, base_box_floor])
        linear_extrude(height=base_box_z)
            union() {
                round2d(1, 1)
                    union() {
                        // individual card holes
                        // smaller boxes on the left
                        translate(v=[lid_wall, lid_wall, 0])
                            square([small_card_slot_width, small_card_slot_length]);
                        translate(v=[lid_wall, lid_wall + small_card_slot_length + 1.5 * base_box_wall, 0])
                            square([small_card_slot_width, small_card_slot_length]);
                        // large box on the right
                        translate([base_box_x - base_box_wall - large_card_slot_length, lid_wall, 0])
                            square([large_card_slot_length, large_card_slot_width]);
                        // cetner tab cutout
                        translate(v=[base_box_wall + small_card_slot_width - 5, lid_overhang_width + base_box_wall + small_card_slot_length * 1 / 4])
                            square(size=[base_box_x - lid_overhang_width - 2 * GENERAL_WALL_THICKNESS - large_card_slot_length - small_card_slot_width + 5, 1.5 * small_card_slot_length + base_box_wall]);
                    }
                round2d(1, 1)
                    union() {
                        // top slot
                        translate(v=[lid_wall, lid_wall + 2 * small_card_slot_length + 2.5 * base_box_wall, 0])
                            square(size=[base_box_x - lid_wall - base_box_wall, top_slot_width]);
                        // wider side
                        translate(v=[lid_wall + small_card_slot_width + base_box_wall, lid_wall + large_card_slot_width + base_box_wall, 0])
                            square(size=[base_box_x - (lid_wall + small_card_slot_width + 2 * base_box_wall), top_slot_wider_width]);
                    }
            }
    // class card inset
    translate(v=[lid_wall, lid_overhang_width, base_box_z - (CARDBOARD_THICKNESS + 0.2) - (class_notepad_slot_thickness)])
        cube([CLASS_STAT_CARD_LENGTH + 2, CLASS_STAT_CARD_WIDTH + 2, (CARDBOARD_THICKNESS + 0.2) + class_notepad_slot_thickness + 1]);
    // notepad inset
    color("aquamarine")
        translate(v=[base_box_x - base_box_wall - class_notepad_slot_length, (base_box_y - class_notepad_slot_width) / 2, base_box_z - class_notepad_slot_thickness])
            cube([class_notepad_slot_length, class_notepad_slot_width, class_notepad_slot_thickness]);
    // class token hole
    translate(
        v=[
            base_box_x - base_box_wall - 1,
            lid_wall + large_card_slot_width + base_box_wall + (top_slot_wider_width - 2 * class_icon_cutout_radius) / 2,
            (base_box_z + lid_overhang_height - 2 * class_icon_cutout_radius) / 2,
        ]
    )
        translate(v=[0, class_icon_cutout_radius, class_icon_cutout_radius])
            rotate(a=[0, 90, 0])
                cylinder(h=base_box_wall + 4, r=class_icon_cutout_radius);
}
