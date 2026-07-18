include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
module large_tile_box() {

    $fn = 100;

    // mini box overage 4mm, monster box to class box height ~41mm
    // need to add tolerance for them

    tolerance = 3;
    base_box_x = GAME_BOX_INTERIOR_LENGTH - PAPER_CLASS_BOX_HEIGHT - 2;
    base_box_y = GAME_BOX_INTERIOR_WIDTH - 2;
    // TODO parameterize the monster box
    // shorten for tolerance fit slightly under class box height
    base_box_z = PAPER_CLASS_BOX_LENGTH - (107.55) - 2;
    base_box_wall = 2 * GENERAL_WALL_THICKNESS;
    base_box_r = 2;

    MINI_BOX_OVERAGE = 4; // TODO move to const
    mini_box_cutout_x = MINI_BOX_HOLDER_LENGTH + tolerance;
    mini_box_cutout_y = MINI_BOX_HOLDER_WIDTH + tolerance;
    mini_box_cutout_z = MINI_BOX_OVERAGE + tolerance;
    mini_box_cutout_shell_x = mini_box_cutout_x + base_box_wall;
    mini_box_cutout_shell_y = mini_box_cutout_y + base_box_wall;
    mini_box_cutout_shell_z = mini_box_cutout_z + base_box_wall;

    difference() {
        union() {
            difference() {
                // TODO split initial box into 2 to round class box cutout corners
                roundcube_2d(size=[base_box_x, base_box_y, base_box_z], radius=base_box_r);
                translate(v=[base_box_wall, base_box_wall, base_box_wall])
                    roundcube_2d(size=[base_box_x - 2 * base_box_wall, base_box_y - 2 * base_box_wall, base_box_z], radius=base_box_r);
                // mini box cutout
                translate(v=[base_box_x - (MINI_BOX_HOLDER_LENGTH + tolerance), base_box_y - (MINI_BOX_HOLDER_WIDTH + tolerance), 0])
                    cube(size=[MINI_BOX_HOLDER_LENGTH + tolerance, MINI_BOX_HOLDER_WIDTH + tolerance, MINI_BOX_OVERAGE + tolerance]);
            }
            // class box cutout wall
            translate(v=[0, base_box_y - (PAPER_CLASS_BOX_HEIGHT + tolerance) - base_box_wall, 0])
                roundcube_2d(size=[PAPER_CLASS_BOX_WIDTH + tolerance + base_box_wall, PAPER_CLASS_BOX_HEIGHT + tolerance + base_box_wall, base_box_z], radius=base_box_r);
            // mini box cutout wall
            translate(v=[base_box_x - mini_box_cutout_shell_x, base_box_y - mini_box_cutout_shell_y, 0])
                difference() {
                    roundcube_2d(size=[mini_box_cutout_shell_x, mini_box_cutout_shell_y, mini_box_cutout_shell_z], radius=base_box_r);
                    translate(v=[base_box_wall, base_box_wall, -base_box_wall])
                        cube(size=[mini_box_cutout_shell_x, mini_box_cutout_shell_y, mini_box_cutout_shell_z]);
                }
        }

        // class box cutout
        translate(v=[0, base_box_y - (PAPER_CLASS_BOX_HEIGHT + tolerance), 0])
            cube(size=[PAPER_CLASS_BOX_WIDTH + tolerance, PAPER_CLASS_BOX_HEIGHT + tolerance, base_box_z]);
    }
}
large_tile_box();
