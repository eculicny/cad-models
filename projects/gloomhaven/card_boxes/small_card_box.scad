include <../gloomhaven_const.scad>
use <Round-Anything/polyround.scad>
use <Round-Anything/unionRoundMask.scad>

$fn = 200;
base_box_wall = SMALL_CARD_BOX_WALL;
base_box_floor = SMALL_CARD_BOX_FLOOR;
base_box_x = SMALL_CARD_BOX_LENGTH;
base_box_int_x = base_box_x - 2 * base_box_wall;
base_box_int_y = SMALL_CARD_LENGTH + GENERAL_CARD_TOLERANCE;
base_box_y = base_box_int_y + 2 * base_box_wall;
base_box_z = SMALL_CARD_BOX_HEIGHT;
base_box_r = 2;

module end_wall() {
    linear_extrude(height=base_box_wall)
        union() {
            round2d(2, 10)
                difference() {
                    //full wall
                    square(size=[base_box_z, base_box_y]);
                    //cutout of wall
                    translate(v=[base_box_z - base_box_z / 2, base_box_y / 2 / 2])
                        square(size=[base_box_z / 2, base_box_y / 2]);
                }
            difference() {
                //full wall
                square(size=[base_box_z, base_box_y]);
                //cutout of wall
                translate(v=[base_box_z - base_box_z / 2, (base_box_y / 2 - 5) / 2])
                    square(size=[base_box_z / 2, base_box_y / 2 + 5]);
            }
        }
}

//union(){
unionRoundMask(r=1, detail=$preview ? 3 : 10, q=$preview ? 10 : 70, showMask=false) {
    union() {
        translate([base_box_wall, 0, 0])
            rotate(a=[0, -90, 0])
                end_wall();

        translate([base_box_x, 0, 0])
            rotate(a=[0, -90, 0])
                end_wall();
    }
    difference() {
        cube(size=[base_box_x, base_box_y, base_box_z]);
        translate(v=[-base_box_wall, base_box_wall, base_box_floor])
            cube(size=[base_box_x + base_box_wall, base_box_int_y, base_box_z]);
    }

    // mask corners
    for (i = [0:1])
        translate(v=[-base_box_x / 2, (i % 2) * (base_box_y) - base_box_wall, 0])
            cube(size=[2 * base_box_x, 2 * base_box_wall, base_box_z + 5]);
}
