include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <Round-Anything/polyround.scad>

tab_number = 3;
file_name = "../img/x.svg";
scale_factor = 0.8;
tab_offset = 1.5; // tab_number * 10.5;

module small_class_card_divider(file_name, scale_factor, tab_offset) {
    base_box_x = SMALL_CARD_WIDTH;
    base_box_y = SMALL_CARD_LENGTH;
    base_box_z = 0.4;
    base_box_r = 2;
    tab_size = 12;
    icon_height = 0.4;

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
