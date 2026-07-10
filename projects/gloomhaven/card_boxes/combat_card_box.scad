include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <Round-Anything/polyround.scad>
use <Round-Anything/unionRoundMask.scad>
include <BOSL2/std.scad>

$fn = 200;
base_box_wall = COMBAT_CARD_BOX_WALL;
base_box_floor = COMBAT_CARD_BOX_WALL;
base_box_x = COMBAT_CARD_BOX_WIDTH;
base_box_y = COMBAT_CARD_BOX_LENGTH;
base_box_z = COMBAT_CARD_STACK_HEIGHT + base_box_floor;
base_box_r = 2;

cutout_depth = COMBAT_CARD_STACK_HEIGHT;
long_side = SMALL_CARD_CUTOUT_WIDTH / 2;
short_side = SMALL_CARD_CUTOUT_WIDTH / 2 / 2;
side_wall_width = SMALL_CARD_CUTOUT_WIDTH + 2 * base_box_wall;

module side_wall() {

    linear_extrude(height=base_box_wall)
        union() {
            round2d(2, 2)
                difference() {
                    //full wall
                    square(size=[base_box_z, side_wall_width]);
                    //cutout of wall
                    // arrange in wall
                    translate(v=[0, (side_wall_width - long_side) / 2])
                        // center in space
                        translate(v=[cutout_depth / 2, long_side / 2])
                            rotate(a=[0, 0, 90])
                                //square(size=[cutout_depth, long_side]);
                                trapezoid(h=cutout_depth, w1=short_side, w2=long_side);
                }
            //needed to unround the wall corners
            difference() {
                //full wall
                square(size=[base_box_z, side_wall_width]);
                //cutout of wall
                // arrange in wall
                translate(v=[0, (side_wall_width - long_side) / 2])
                    // center in space
                    translate(v=[cutout_depth / 2, long_side / 2])
                        rotate(a=[0, 0, 90])
                            //square(size=[cutout_depth, long_side + 5]);
                            trapezoid(h=cutout_depth, w1=short_side + 5, w2=long_side + 5);
            }
        }
}

union() {
    difference() {
        cube(size=[base_box_x, base_box_y, base_box_z]);
        // center on box
        translate(v=[base_box_wall, 0, base_box_floor])
            // create card tray array
            linear_extrude(height=base_box_z) {
                for (i = [0:1]) {
                    translate(v=[i * (SMALL_CARD_CUTOUT_WIDTH + base_box_wall), 0, 0])
                        square(size=[SMALL_CARD_CUTOUT_WIDTH, base_box_y + base_box_wall]);
                    // extra added to base_box_y for precision issue
                }
            }
    }

    union() {
        for (i = [0:2]) {
            translate(v=[0, i * (base_box_y - base_box_wall) / 2 + base_box_wall, base_box_z])
                rotate(a=[0, 90, 0])
                    rotate(a=[90, 0, 0]) {

                        side_wall();
                        translate(v=[0, side_wall_width - base_box_wall, 0])
                            side_wall();
                    }
        }
    }
}
