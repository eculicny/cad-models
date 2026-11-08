include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <Round-Anything/polyround.scad>

$fn = 200;

module lid_slot(ridges, length, overhang_width, overhang_height) {
    translate(v=[GENERAL_WALL_THICKNESS, length, 0])
        rotate(a=[90, 0, 0])for (i = [0:ridges - 1]) {
            translate(v=[0, -i * overhang_height, 0])
                linear_extrude(height=length, convexity=5)
                    union() {
                        // split wall out to have some structure for slot
                        polygon(points=[[0, 0], [0, -overhang_height], [overhang_width - GENERAL_WALL_THICKNESS, 0]], paths=[[0, 1, 2]]);
                        polygon(points=[[0, 0], [0, -overhang_height], [-GENERAL_WALL_THICKNESS, -overhang_height], [-GENERAL_WALL_THICKNESS, 0]], paths=[[0, 1, 2, 3]]);
                    }
        }
}

module class_box() {
    base_box_wall = CLASS_BOX_WALL;
    base_box_floor = GENERAL_WALL_THICKNESS;
    base_box_x = CLASS_BOX_LENGTH;
    base_box_y = CLASS_BOX_HEIGHT;
    base_box_z = CLASS_BOX_WIDTH - CLASS_BOX_LID_OVERHANG_HEIGHT;
    base_box_r = GENERAL_ROUNDING_RADIUS;

    lid_wall = CLASS_BOX_LID_OVERHANG_WIDTH + GENERAL_WALL_THICKNESS;

    class_icon_wall = CLASS_BOX_LID_OVERHANG_WIDTH + CLASS_BOX_WALL;

    difference() {
        difference() {
            union() {
                cube(size=[base_box_x, base_box_y, base_box_z]);
                // front lid slot
                translate(v=[base_box_x, base_box_y, base_box_z + CLASS_BOX_LID_OVERHANG_HEIGHT])
                    rotate(a=[0, 0, 180])
                        lid_slot(1, base_box_y, CLASS_BOX_LID_OVERHANG_WIDTH, CLASS_BOX_LID_OVERHANG_HEIGHT);
                // side lid slot
                translate(v=[0, base_box_y, base_box_z + CLASS_BOX_LID_OVERHANG_HEIGHT])
                    rotate(a=[0, 0, -90])
                        lid_slot(1, base_box_x, CLASS_BOX_LID_OVERHANG_WIDTH, CLASS_BOX_LID_OVERHANG_HEIGHT);
                // back lid slot
                translate(v=[0, 0, base_box_z + CLASS_BOX_LID_OVERHANG_HEIGHT])
                    lid_slot(1, base_box_y, CLASS_BOX_LID_OVERHANG_WIDTH, CLASS_BOX_LID_OVERHANG_HEIGHT);
            }

            // all insets
            translate(v=[0, 0, base_box_floor])
                linear_extrude(height=base_box_z, convexity=5)
                    union() {
                        round2d(1, 1)
                            union() {
                                // individual card holes
                                // smaller boxes on the left
                                translate(v=[lid_wall, lid_wall, 0])
                                    square([CLASS_BOX_SMALL_CARD_SLOT_WIDTH, CLASS_BOX_SMALL_CARD_SLOT_LENGTH]);
                                translate(v=[lid_wall, lid_wall + CLASS_BOX_SMALL_CARD_SLOT_LENGTH + CLASS_BOX_SMALL_CARD_SLOT_DIV_WALL, 0])
                                    square([CLASS_BOX_SMALL_CARD_SLOT_WIDTH, CLASS_BOX_SMALL_CARD_SLOT_LENGTH]);
                                // large box on the right
                                translate([base_box_x - lid_wall - CLASS_BOX_LARGE_CARD_SLOT_LEGNTH, lid_wall, 0])
                                    square([CLASS_BOX_LARGE_CARD_SLOT_LEGNTH, CLASS_BOX_LARGE_CARD_SLOT_WIDTH]);
                                // cetner tab cutout
                                translate(v=[base_box_wall + CLASS_BOX_SMALL_CARD_SLOT_WIDTH - 5, CLASS_BOX_LID_OVERHANG_WIDTH + base_box_wall + CLASS_BOX_SMALL_CARD_SLOT_LENGTH * 1 / 4])
                                    square(size=[base_box_x - CLASS_BOX_LID_OVERHANG_WIDTH - 2 * GENERAL_WALL_THICKNESS - CLASS_BOX_LARGE_CARD_SLOT_LEGNTH - CLASS_BOX_SMALL_CARD_SLOT_WIDTH + 5, 1.5 * CLASS_BOX_SMALL_CARD_SLOT_LENGTH + base_box_wall]);
                            }
                        round2d(1, 1)
                            union() {
                                // top slot
                                translate(v=[lid_wall, lid_wall + 2 * CLASS_BOX_SMALL_CARD_SLOT_LENGTH + CLASS_BOX_SMALL_CARD_SLOT_DIV_WALL + CLASS_BOX_TOP_SLOT_DIV_WALL, 0])
                                    square(size=[base_box_x - lid_wall - base_box_wall - class_icon_wall, CLASS_BOX_TOP_SLOT_SMALL_WIDTH]);
                                // wider side
                                translate(v=[lid_wall + CLASS_BOX_SMALL_CARD_SLOT_WIDTH + base_box_wall, lid_wall + CLASS_BOX_LARGE_CARD_SLOT_WIDTH + base_box_wall, 0])
                                    square(size=[base_box_x - (lid_wall + CLASS_BOX_SMALL_CARD_SLOT_WIDTH + 2 * base_box_wall + class_icon_wall), CLASS_BOX_TOP_SLOT_LARGE_WIDTH]);
                            }
                    }
        }

        // class card inset
        translate(v=[lid_wall, CLASS_BOX_LID_OVERHANG_WIDTH, base_box_z - (CLASS_STAT_CARD_SLOT_THICKNESS)])
            cube([CLASS_STAT_CARD_SLOT_LENGTH, CLASS_STAT_CARD_SLOT_WIDTH, (CLASS_STAT_CARD_SLOT_THICKNESS) + CLASS_NOTEPAD_SLOT_THICKNESS + 1]);
        // notepad inset
        color("aquamarine")
            translate(v=[(base_box_x - CLASS_NOTEPAD_SLOT_LENGTH) / 2, (base_box_y - CLASS_NOTEPAD_SLOT_WIDTH) / 2, base_box_z - CLASS_NOTEPAD_SLOT_THICKNESS - CLASS_STAT_CARD_SLOT_THICKNESS])
                cube([CLASS_NOTEPAD_SLOT_LENGTH, CLASS_NOTEPAD_SLOT_WIDTH, CLASS_NOTEPAD_SLOT_THICKNESS + CLASS_STAT_CARD_SLOT_THICKNESS + DIFF_EPS]);
        // class token hole
        translate(
            v=[
                base_box_x - base_box_wall - 0.1,
                lid_wall + CLASS_BOX_LARGE_CARD_SLOT_WIDTH + base_box_wall + (CLASS_BOX_TOP_SLOT_LARGE_WIDTH - 2 * CLASS_BOX_ICON_CUTOUT_RADIUS) / 2,
                (base_box_z + CLASS_BOX_LID_OVERHANG_HEIGHT - 2 * CLASS_BOX_ICON_CUTOUT_RADIUS) / 2,
            ]
        )
            translate(v=[0, CLASS_BOX_ICON_CUTOUT_RADIUS, CLASS_BOX_ICON_CUTOUT_RADIUS])
                rotate(a=[0, 90, 0])
                    cylinder(h=CLASS_BOX_ICON_CUTOUR_THICKNESS + DIFF_EPS, r1=CLASS_BOX_ICON_CUTOUT_RADIUS, r2=CLASS_BOX_ICON_CUTOUT_RADIUS);
    }
}

class_box();
