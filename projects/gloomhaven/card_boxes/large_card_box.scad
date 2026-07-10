include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <Round-Anything/polyround.scad>
use <Round-Anything/unionRoundMask.scad>

module large_card_box() {

$fn = 200;
extra_box_tolerance = 1.2; // 66
label_card_overage = GENERAL_CARD_DIVIDER_TEXT_HEIGHT + 1;
base_box_wall = 0.8;
base_box_floor = 2 * base_box_wall;
base_box_x = 150;
base_box_int_x = base_box_x - 2 * base_box_wall;
base_box_int_y = LARGE_CARD_BOX_INT_WIDTH;
base_box_y = LARGE_CARD_BOX_WIDTH;
base_box_z = LARGE_CARD_BOX_HEIGHT;
base_box_r = 2;

module end_wall() {
    linear_extrude(height=base_box_wall)
        union() {
            round2d(2, 16)
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
}
large_card_box();
