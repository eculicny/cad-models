include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <shapes/regular_polygon.scad>

token_stack_height = 4;
hex_row_max_count = 3;
row_count = 5;

token_tolerance = 0.3;
base_box_wall = 0.8;
spacing = 0.8; // space between token slots
base_box_floor = 2 * base_box_wall;
base_box_x = 150;
base_box_y = 110 - 2; // 11cm is exact fit, remove some tolerance for fit
base_box_z = token_stack_height * (TOKEN_THICKNESS + token_tolerance) + base_box_floor;
base_box_r = 2;

difference() {
    roundcube_2d(size=[base_box_x, base_box_y, base_box_z], radius=base_box_r);

    // 3-2-3-2 hex rows
    // hexagonal array
    translate(
        [
            0,
            (base_box_y - (hex_row_max_count * 2 * HEX_TOKEN_SLOT_APOTHEM + (hex_row_max_count - 1) * spacing)) / 2, // center array
            base_box_z + base_box_floor, // raise array
        ]
    )
        rotate(a=[0, 180, 0])
            rotate(a=[0, 0, 90])
                linear_extrude(height=base_box_z)
                    translate([HEX_TOKEN_SLOT_APOTHEM, HEX_TOKEN_SLOT_RADIUS, 0]) {
                        for (i = [0:row_count - 1]) {
                            // -HEX_TOKEN_SLOT_APOTHEM in x for long alternate rows
                            translate([(i % 2) * ( -HEX_TOKEN_SLOT_APOTHEM - spacing / 2), i * (3 * HEX_TOKEN_SLOT_RADIUS / 2 + spacing)]) {
                                // short alternate rows
                                //for (j = [0:(hex_row_max_count - 1) - (i % 2)])
                                // long alternate rows
                                for (j = [0:(hex_row_max_count - 1) + (i % 2)])
                                    translate([j * (2 * HEX_TOKEN_SLOT_APOTHEM + spacing), 0, 0])
                                        regular_polygon(6, HEX_TOKEN_SLOT_RADIUS);
                            }

                            translate(v=[-HEX_TOKEN_SLOT_RADIUS, i * (3 * HEX_TOKEN_SLOT_RADIUS / 2 + spacing) - HEX_TOKEN_SLOT_RADIUS / 2])
                                square(size=[base_box_x + 5, HEX_TOKEN_SLOT_RADIUS]);
                        }
                    }
}
