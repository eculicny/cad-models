include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <Round-Anything/polyround.scad>

file_name = "../img/x.svg";
scale_factor = 0.75;
tab_offset = 1.5;

module small_class_card_divider(file_name, scale_factor, tab_offset) {
    base_box_x = CLASS_BOX_SMALL_DIVIDER_WIDTH;
    base_box_y = CLASS_BOX_SMALL_DIVIDER_LENGTH;
    base_box_z = CLASS_BOX_SMALL_DIVIDER_THICKNESS;
    base_box_r = GENERAL_ROUNDING_RADIUS;
    tab_size = CLASS_BOX_DIVIDER_TAB_SIZE;
    icon_height = GENERAL_TEXT_THICKNESS;

    linear_extrude(height=base_box_z)
        round2d(base_box_r, base_box_r)
            union() {
                translate(v=[-base_box_x / 2 - tab_size / 2, -base_box_y / 2 + tab_size / 2 + tab_offset, 0])
                    square(size=[base_box_x, base_box_y], center=true);

                square(size=[tab_size, tab_size], center=true);
            }

    color("aqua")
        translate(v=[0, 0, base_box_z])
            linear_extrude(height=icon_height)
                scale(v=[scale_factor, scale_factor, 1])
                    import(
                        file=file_name,
                        center=true,
                        dpi=1000,
                        convexity=10,
                    );
}

small_class_card_divider(file_name, scale_factor, tab_offset);
