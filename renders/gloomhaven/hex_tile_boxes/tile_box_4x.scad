include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <shapes/regular_polygon.scad>
use <./base_stacked_token_box.scad>

$fn = 100;
token_stack_height = 4;

// TODO fix parameterization of base_box since size values are needed for cutout calculations
base_box_floor = 2 * GENERAL_WALL_THICKNESS;
base_box_x = TOKEN_BOX_X;
base_box_y = TOKEN_BOX_Y;
base_box_z = token_box_z(token_stack_height);

union() {
    difference() {
        base_stacked_token_box(token_stack_height);

        // 3-2-3-2-3 hex rows
        // hexagonal array
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
                            for (i = [0:HEX_NUM_ROWS - 1]) {
                                translate([(i % 2) * (HEX_TOKEN_SLOT_APOTHEM + GENERAL_WALL_THICKNESS / 2), i * (3 * HEX_TOKEN_SLOT_RADIUS / 2 + GENERAL_WALL_THICKNESS)]) {
                                    // short alternate rows
                                    for (j = [0:(HEX_ROW_MAX_COUNT - 1) - (i % 2)])
                                        translate([j * (2 * HEX_TOKEN_SLOT_APOTHEM + GENERAL_WALL_THICKNESS), 0, 0])
                                            regular_polygon(6, HEX_TOKEN_SLOT_RADIUS);
                                }
                                if (i % 2 == 0) {
                                    translate(v=[-HEX_TOKEN_SLOT_RADIUS, i * (3 * HEX_TOKEN_SLOT_RADIUS / 2 + GENERAL_WALL_THICKNESS) - HEX_TOKEN_SLOT_RADIUS / 2])
                                        square(size=[base_box_x + 5, HEX_TOKEN_SLOT_RADIUS]);
                                } else {
                                    // only remove center dividers on short rows
                                    translate(
                                        v=[
                                            (base_box_y - (HEX_ROW_MAX_COUNT * 2 * HEX_TOKEN_SLOT_APOTHEM + (HEX_ROW_MAX_COUNT - 1) * GENERAL_WALL_THICKNESS)) / 2 - 4 * GENERAL_WALL_THICKNESS,
                                            i * (3 * HEX_TOKEN_SLOT_RADIUS / 2 + GENERAL_WALL_THICKNESS) - (HEX_TOKEN_SLOT_RADIUS) / 2,
                                        ]
                                    )
                                        square(size=[2 * (HEX_ROW_MAX_COUNT - 1) * (HEX_TOKEN_SLOT_APOTHEM + GENERAL_WALL_THICKNESS), HEX_TOKEN_SLOT_RADIUS]);
                                }
                            }
                        }

        // remove walls for 3-hex cone tile
        color("BLUE")
            translate(
                v=[
                    3 * HEX_TOKEN_SLOT_RADIUS / 2,
                    ( (base_box_y - HEX_ROW_MAX_COUNT * (2 * HEX_TOKEN_SLOT_APOTHEM + GENERAL_WALL_THICKNESS)) / 2) + HEX_TOKEN_SLOT_APOTHEM + GENERAL_WALL_THICKNESS,
                    base_box_floor,
                ]
            )
                cube(size=[HEX_TOKEN_SLOT_RADIUS, 2 * (HEX_TOKEN_SLOT_APOTHEM), base_box_z + 5]);
    }
}
