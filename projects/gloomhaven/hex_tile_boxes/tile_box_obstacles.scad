include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <shapes/regular_polygon.scad>
use <./base_stacked_token_box.scad>

module tile_box_obstacles() {

$fn = 100;

token_stack_height = 6;

base_box_wall = GENERAL_WALL_THICKNESS;
base_box_floor = 2 * base_box_wall;
base_box_x = TOKEN_BOX_X;
base_box_y = TOKEN_BOX_Y;
base_box_z = token_box_z(token_stack_height);
base_box_r = TOKEN_BOX_R;

difference() {
    // base box with hex-like cutouts
    union() {

        difference() {
            base_stacked_token_box(token_stack_height=token_stack_height);

            // hex array 3-2
            translate(
                [
                    0,
                    (base_box_y - (HEX_ROW_MAX_COUNT * 2 * HEX_TOKEN_SLOT_APOTHEM + (HEX_ROW_MAX_COUNT - 1) * GENERAL_WALL_THICKNESS)) / 2, // center array
                    base_box_z + base_box_floor, // raise array
                ]
            )
                rotate(a=[0, 180, 0])
                    rotate(a=[0, 0, 90])
                        linear_extrude(height=base_box_z)
                            translate([HEX_TOKEN_SLOT_APOTHEM, HEX_TOKEN_SLOT_RADIUS, 0]) {
                                // only three hex slots (constant?)
                                for (i = [0:1]) {
                                    translate([(i % 2) * (HEX_TOKEN_SLOT_APOTHEM + GENERAL_WALL_THICKNESS / 2), i * (3 * HEX_TOKEN_SLOT_RADIUS / 2 + GENERAL_WALL_THICKNESS)]) {
                                        // short alternate rows
                                        for (j = [0:(HEX_ROW_MAX_COUNT - 1) - (i % 2)])
                                            translate([j * (2 * HEX_TOKEN_SLOT_APOTHEM + GENERAL_WALL_THICKNESS), 0, 0])
                                                regular_polygon(6, HEX_TOKEN_SLOT_RADIUS);
                                    }
                                }
                            }

            // With interior cutouts
            // for 3rd one leave no dividers
            for (j = [1:2]) {
                translate(
                    v=[
                        (HEX_TOKEN_SLOT_RADIUS * (1 + (j % 2)) / 2) + floor((j - 1) / 2) * HEX_TOKEN_SLOT_RADIUS + ceil((j - 1) / 2) * 2 * HEX_TOKEN_SLOT_RADIUS + (j - 1) * base_box_wall,
                        0,
                        0,
                    ]
                ) {
                    // center on x and y, raise z
                    translate(v=[-HEX_TOKEN_SLOT_RADIUS * 3 / 8, (base_box_y - (base_box_y + HEX_TOKEN_SLOT_APOTHEM / 2 - (1 - j % 2) * 2 * HEX_TOKEN_SLOT_APOTHEM)) / 2, base_box_floor])
                        cube(size=[HEX_TOKEN_SLOT_RADIUS * 3 / 4, base_box_y + HEX_TOKEN_SLOT_APOTHEM / 2 - (1 - j % 2) * 2 * HEX_TOKEN_SLOT_APOTHEM, base_box_z + 5]);
                }
            }
        }

        // add back in the "tops" of the last row of hexes
        //     translate(
        //         v=[
        //             // move to insert location in x-direction
        //             (5 * HEX_TOKEN_SLOT_RADIUS + 2 * base_box_wall) - HEX_TOKEN_SLOT_RADIUS / 2, // could be parameterized off of HEX_NUM_ROWS like 6x box
        //             // center in y-direction
        //             (base_box_y - HEX_ROW_MAX_COUNT * 2 * HEX_TOKEN_SLOT_APOTHEM - (HEX_ROW_MAX_COUNT - 1) * base_box_wall) / 2,
        //             0,
        //         ]
        //     ) {
        //         for (i = [0:HEX_ROW_MAX_COUNT - 1]) {
        //             translate(v=[-HEX_TOKEN_SLOT_RADIUS / 2, HEX_TOKEN_SLOT_APOTHEM + i * (2 * HEX_TOKEN_SLOT_APOTHEM + base_box_wall), 0])
        //                 rotate(a=[0, 0, 90])
        //                     linear_extrude(height=base_box_z)
        //                         difference() {
        //                             regular_polygon(6, HEX_TOKEN_SLOT_RADIUS);
        //                             translate(v=[0, HEX_TOKEN_SLOT_RADIUS / 2, 0])
        //                                 rotate(a=[0, 0, 45])
        //                                     regular_polygon(4, 2 * HEX_TOKEN_SLOT_RADIUS / sqrt(2));
        //                         }
        //         }
        //     }
    }

    translate(v=[base_box_x - 30, ALTAR_SLOT_LENGTH - base_box_r, base_box_floor])
        roundcube_2d(size=[20, 20, base_box_z], radius=base_box_r);
    color("GREEN")
        translate(v=[7 / 2 * HEX_TOKEN_SLOT_RADIUS + 2 * base_box_wall + ALPHANUMERIC_SLOT_DIAMETER, 0, base_box_floor])
            union() {
                // ALTAR
                translate(v=[2 * HEX_TOKEN_SLOT_RADIUS + 2 * base_box_wall, base_box_wall, 0])
                    roundcube_2d(size=[ALTAR_SLOT_WIDTH, ALTAR_SLOT_LENGTH, base_box_z], radius=base_box_r);
                // SARCOPHAGUS
                translate(v=[TABLE_AND_CHAIR_SLOT_WIDTH + base_box_wall + WORKBENCH_SLOT_WIDTH + base_box_wall, base_box_y - SARCOPHAGUS_SLOT_LENGTH - 2 * base_box_wall, 0])
                    roundcube_2d(size=[SARCOPHAGUS_SLOT_WIDTH, SARCOPHAGUS_SLOT_LENGTH, base_box_z], radius=base_box_r);
                // WORKBENCH
                translate(v=[TABLE_AND_CHAIR_SLOT_WIDTH + base_box_wall, (base_box_y - 57) / 2, 0])
                    roundcube_2d(size=[WORKBENCH_SLOT_WIDTH, WORKBENCH_SLOT_LENGTH, base_box_z], radius=base_box_r);
                // TABLE_AND_CHAIR
                translate(v=[0, (base_box_y - TABLE_AND_CHAIR_SLOT_LENGTH) / 2, 0])
                    roundcube_2d(size=[TABLE_AND_CHAIR_SLOT_WIDTH, TABLE_AND_CHAIR_SLOT_LENGTH, base_box_z], radius=base_box_r);
                // TABLE_AND_CHAIR CUTOUT
                translate(v=[TABLE_AND_CHAIR_SLOT_WIDTH * 5 / 16, (base_box_y - TABLE_AND_CHAIR_SLOT_LENGTH - 20) / 2, 0])
                    cube(size=[TABLE_AND_CHAIR_SLOT_WIDTH / 2, TABLE_AND_CHAIR_SLOT_LENGTH + 20, base_box_z]);
                // ALPHANUMERIC CUTOUT
                translate(v=[-ALPHANUMERIC_SLOT_DIAMETER - base_box_wall, base_box_wall, 0])
                    roundcube_2d(size=[ALPHANUMERIC_SLOT_DIAMETER, base_box_y - 2 * base_box_wall, base_box_z], radius=base_box_r);
                ;
            }
}
}
tile_box_obstacles();
