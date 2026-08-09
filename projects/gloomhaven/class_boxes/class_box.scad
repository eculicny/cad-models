include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <Round-Anything/polyround.scad>

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

class_stat_card_slot = CARDBOARD_THICKNESS + 0.2;

class_icon_wall = base_box_wall + 0.5;
class_icon_cutout_radius = 6.5;

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
    difference() {
        union() {
            cube(size=[base_box_x, base_box_y, base_box_z]);
            // front lid slot
            translate(v=[base_box_x, base_box_y, base_box_z + lid_overhang_height])
                rotate(a=[0, 0, 180])
                    lid_slot(1, base_box_y, lid_overhang_width, lid_overhang_height);
            // side lid slot
            translate(v=[0, base_box_y, base_box_z + lid_overhang_height])
                rotate(a=[0, 0, -90])
                    lid_slot(1, base_box_x, lid_overhang_width, lid_overhang_height);
            // back lid slot
            translate(v=[0, 0, base_box_z + lid_overhang_height])
                lid_slot(1, base_box_y, lid_overhang_width, lid_overhang_height);
        }

        // all insets
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
                                square(size=[base_box_x - lid_wall - base_box_wall - class_icon_wall, top_slot_width]);
                            // wider side
                            translate(v=[lid_wall + small_card_slot_width + base_box_wall, lid_wall + large_card_slot_width + base_box_wall, 0])
                                square(size=[base_box_x - (lid_wall + small_card_slot_width + 2 * base_box_wall + class_icon_wall), top_slot_wider_width]);
                        }
                }
    }

    // class card inset
     translate(v=[lid_wall, lid_overhang_width, base_box_z - (class_stat_card_slot)])
         cube([CLASS_STAT_CARD_LENGTH + 2, CLASS_STAT_CARD_WIDTH + 2, (class_stat_card_slot) + class_notepad_slot_thickness + 1]);
    // notepad inset
    color("aquamarine")
        translate(v=[(base_box_x - class_notepad_slot_length)/2, (base_box_y - class_notepad_slot_width) / 2, base_box_z - class_notepad_slot_thickness - class_stat_card_slot])
            cube([class_notepad_slot_length, class_notepad_slot_width, class_notepad_slot_thickness+class_stat_card_slot]);
    // class token hole
    translate(
        v=[
            base_box_x - base_box_wall - 0.1,
            lid_wall + large_card_slot_width + base_box_wall + (top_slot_wider_width - 2 * class_icon_cutout_radius) / 2,
            (base_box_z + lid_overhang_height - 2 * class_icon_cutout_radius) / 2,
        ]
    )
        translate(v=[0, class_icon_cutout_radius, class_icon_cutout_radius])
            rotate(a=[0, 90, 0])
                cylinder(h=base_box_wall + 0.1, r1=class_icon_cutout_radius, r2=class_icon_cutout_radius);
    // // class token slot
    // translate(v=[base_box_x - class_token_wall_position - lid_overhang_width, lid_wall + large_card_slot_width + base_box_wall + (top_slot_wider_width - 2 * class_icon_cutout_radius) / 2 - 1, base_box_floor])
    //     roundcube_2d([class_token_wall_position, 2 * (class_icon_cutout_radius + 1), base_box_z], radius=1);
}

// class token hole
// translate(
//     v=[
//         base_box_x - base_box_wall,
//         lid_wall + large_card_slot_width + base_box_wall + (top_slot_wider_width - 2 * class_icon_cutout_radius) / 2,
//         (base_box_z + lid_overhang_height - 2 * class_icon_cutout_radius) / 2,
//     ]
// )
//     translate(v=[0, class_icon_cutout_radius, class_icon_cutout_radius])
//         rotate(a=[0, 90, 0])
//             cylinder(h=base_box_wall, r1=class_icon_cutout_radius, r2=class_icon_cutout_radius - 0.5);
