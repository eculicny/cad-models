include <./gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>

$fn = 60;
int_box_x = 150;
int_box_y = 60;
int_box_z = 110;
box_r = 2;
box_wall = 0.8;
box_x = int_box_x + 2 * box_wall;
box_y = int_box_y + 2 * box_wall;
box_z = int_box_z + box_wall;

difference() {
    roundcube_2d(size=[int_box_x + 2 * box_wall, int_box_y + 2 * box_wall, int_box_z + box_wall], radius=box_r);
    translate([box_wall, box_wall, box_wall])
        roundcube_2d(size=[int_box_x, int_box_y, int_box_z], radius=box_r);

    translate([box_x / 2 - 5 * box_x / 16, box_y + 5, box_z]) //adjust for trapezoid
        rotate(a=[90, 0, 0])
            linear_extrude(height=box_y + 10)
                polygon(
                    points=[[0, 0], [5 * box_x / 8, 0], [4 * box_x / 8, -box_z / 3], [box_x / 8, -box_z / 3]],
                    paths=[[0, 1, 2, 3]]
                );
}
