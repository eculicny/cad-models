include <./gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>

$fn = 100;
base_box_r = 2;

difference() {
    roundcube_2d(size=[MANUALS_BOX_WIDTH, MANUALS_BOX_LENGTH, MANUALS_BOX_HEIGHT], radius=base_box_r);
    translate(v=[MANUALS_BOX_WALL, MANUALS_BOX_WALL, MANUALS_BOX_WALL])
        cube(size=[MANUALS_BOX_INT_WIDTH, MANUALS_BOX_INT_LENGTH, MANUALS_BOX_HEIGHT]);
}
