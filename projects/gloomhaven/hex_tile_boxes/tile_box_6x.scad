include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <shapes/regular_polygon.scad>
use <./base_stacked_token_box.scad>

module tile_box_6x() {

$fn = 100;

token_stack_height = 6;
hex_row_max_count = HEX_ROW_MAX_COUNT;
row_count = HEX_NUM_ROWS;

token_tolerance = GENERAL_TOKEN_TOLERANCE;
base_box_wall = GENERAL_WALL_THICKNESS;
base_box_floor = 2 * base_box_wall;
base_box_x = TOKEN_BOX_X;
base_box_y = TOKEN_BOX_Y;
base_box_z = token_box_z(token_stack_height);
base_box_r = TOKEN_BOX_R;

module double_hex_token_slot() {
    linear_extrude(height=base_box_z)
        union() {
            for (i = [0, 1]) {
                translate(v=[0, (i % 2) * 2 * HEX_TOKEN_SLOT_APOTHEM])
                    rotate(a=[0, 0, 30])
                        regular_polygon(n=6, r=HEX_TOKEN_SLOT_RADIUS);
            }
        }
}

difference() {
    base_stacked_token_box(token_stack_height=token_stack_height);

    // Second/Forth Row
    for (i = [2, 4]) {
        translate(
            v=[
                // nth-row move
                // center on row (full radius for odd row, half for even row) + move to row (2 radii per odd row, 1 radii per even row passed)
                HEX_TOKEN_SLOT_RADIUS * (1 + (i % 2)) / 2 + floor((i - 1) / 2) * HEX_TOKEN_SLOT_RADIUS + ceil((i - 1) / 2) * 2 * HEX_TOKEN_SLOT_RADIUS + (i - 1) * base_box_wall,
                // center row along y-direction
                (base_box_y - (4 * HEX_TOKEN_SLOT_APOTHEM)) / 2,
                0,
            ]
        )
            translate(
                v=[
                    0,
                    HEX_TOKEN_SLOT_APOTHEM,
                    base_box_floor,
                ]
            )
                double_hex_token_slot();
    }

    // First/Third/Fifth Row
    for (i = [0:2]) {
        translate(
            v=[
                // nth-row move
                (i * 3) * HEX_TOKEN_SLOT_RADIUS + (i * 2) * base_box_wall,
                // center row along y-direction
                (base_box_y - (6 * HEX_TOKEN_SLOT_APOTHEM + base_box_wall)) / 2,
                0,
            ]
        )
            union() {
                // double token slot
                translate(
                    v=[
                        HEX_TOKEN_SLOT_RADIUS,
                        HEX_TOKEN_SLOT_APOTHEM,
                        base_box_floor,
                    ]
                )
                    double_hex_token_slot();
                // single token slot
                translate(
                    v=[
                        HEX_TOKEN_SLOT_RADIUS,
                        5 * HEX_TOKEN_SLOT_APOTHEM + base_box_wall,
                        base_box_floor,
                    ]
                )
                    linear_extrude(height=base_box_z)
                        rotate(a=[0, 0, 30])
                            regular_polygon(n=6, r=HEX_TOKEN_SLOT_RADIUS);
            }
    }

    // With interior cutouts
    for (j = [1:5]) {
        translate(
            v=[
                HEX_TOKEN_SLOT_RADIUS * (1 + (j % 2)) / 2 + floor((j - 1) / 2) * HEX_TOKEN_SLOT_RADIUS + ceil((j - 1) / 2) * 2 * HEX_TOKEN_SLOT_RADIUS + (j - 1) * base_box_wall,
                0,
                0,
            ]
        ) {
            // center on x and y, raise z
            translate(v=[-HEX_TOKEN_SLOT_RADIUS * 3 / 8, (base_box_y - (base_box_y + HEX_TOKEN_SLOT_APOTHEM / 2 - (1 - j % 2) * 2 * HEX_TOKEN_SLOT_APOTHEM)) / 2, base_box_floor])
                cube(size=[HEX_TOKEN_SLOT_RADIUS * 3 / 4, base_box_y + HEX_TOKEN_SLOT_APOTHEM / 2 - (1 - j % 2) * 2 * HEX_TOKEN_SLOT_APOTHEM, base_box_z + 5]);
        }
    }

    // Only end cap slots
    // for (j = [1:5]) {
    //     translate(
    //         v=[
    //             HEX_TOKEN_SLOT_RADIUS * (1 + (j % 2)) / 2 + floor((j - 1) / 2) * HEX_TOKEN_SLOT_RADIUS + ceil((j - 1) / 2) * 2 * HEX_TOKEN_SLOT_RADIUS + (j - 1) * base_box_wall,
    //             0,
    //             0,
    //         ]
    //     ) {
    //         for (i = [0:1]) {
    //             // center on x and y, raise z
    //             translate(v=[-HEX_TOKEN_SLOT_RADIUS * 3 / 8, i * base_box_y - HEX_TOKEN_SLOT_APOTHEM / 2 + (1 - j % 2) * ( (-1) ^ (i % 2)) * (HEX_TOKEN_SLOT_APOTHEM + base_box_wall), base_box_floor])
    //                 cube(size=[HEX_TOKEN_SLOT_RADIUS * 3 / 4, HEX_TOKEN_SLOT_APOTHEM, base_box_z + 5]);
    //         }
    //     }
    // }
}
}
tile_box_6x();
