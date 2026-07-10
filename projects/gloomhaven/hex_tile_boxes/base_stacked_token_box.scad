include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <shapes/regular_polygon.scad>

module base_stacked_token_box() {

// TODO generalize?
module half_hex(n, r) {
    difference() {
        rotate(a=[0, 0, 30]) // rotate turn depending on n
            regular_polygon(n, r);

        rotate(a=[180, 0, 0])
            translate(v=[-r, 0, 0])
                square(size=[2 * r, 2 * r]);
    }
}

/*
    Base box form with default sizes set.

    Assumes tile slots are centered hexagonal arrays 3-2-3-2-3.
    Lift holes are set in incomplete hexes on short rows
*/ module base_stacked_token_box(
    token_stack_height
) {
    base_box_x = TOKEN_BOX_X;
    base_box_y = TOKEN_BOX_Y;
    base_box_z = token_box_z(token_stack_height);

    difference() {
        roundcube_2d(size=[base_box_x, base_box_y, base_box_z], radius=TOKEN_BOX_R);

        // slots for lifting bar
        // probably not 6 generalized
        // TODO make nicer with matrix arithmetic? 5-6 should be functions of row parameters
        translate(v=[(5) / 2 * HEX_TOKEN_SLOT_RADIUS + GENERAL_WALL_THICKNESS, (base_box_y - HEX_ROW_MAX_COUNT * (2 * HEX_TOKEN_SLOT_APOTHEM + GENERAL_WALL_THICKNESS)) / 2, 0])
            linear_extrude(height=base_box_z)
                half_hex(n=6, r=HEX_TOKEN_SLOT_RADIUS);
        translate(v=[(5 + 6) / 2 * HEX_TOKEN_SLOT_RADIUS + HEX_ROW_MAX_COUNT * GENERAL_WALL_THICKNESS, (base_box_y - HEX_ROW_MAX_COUNT * (2 * HEX_TOKEN_SLOT_APOTHEM + GENERAL_WALL_THICKNESS)) / 2, 0])
            linear_extrude(height=base_box_z)
                half_hex(n=6, r=HEX_TOKEN_SLOT_RADIUS);

        translate(v=[(5) / 2 * HEX_TOKEN_SLOT_RADIUS + GENERAL_WALL_THICKNESS, (base_box_y + HEX_ROW_MAX_COUNT * (2 * HEX_TOKEN_SLOT_APOTHEM + GENERAL_WALL_THICKNESS)) / 2, 0])
            linear_extrude(height=base_box_z)
                rotate(a=[180, 0, 0])
                    half_hex(n=6, r=HEX_TOKEN_SLOT_RADIUS);
        translate(v=[(5 + 6) / 2 * HEX_TOKEN_SLOT_RADIUS + HEX_ROW_MAX_COUNT * GENERAL_WALL_THICKNESS, (base_box_y + HEX_ROW_MAX_COUNT * (2 * HEX_TOKEN_SLOT_APOTHEM + GENERAL_WALL_THICKNESS)) / 2, 0])
            linear_extrude(height=base_box_z)
                rotate(a=[180, 0, 0])
                    half_hex(n=6, r=HEX_TOKEN_SLOT_RADIUS);
    }
}
base_stacked_token_box(5);
}
base_stacked_token_box();
