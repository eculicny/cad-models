include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <Round-Anything/polyround.scad>

base_box_x = CLASS_BOX_LARGE_DIVIDER_WIDTH;
base_box_y = CLASS_BOX_LARGE_DIVIDER_LENGTH;
base_box_z = CLASS_BOX_LARGE_DIVIDER_THICKNESS;
base_box_r = GENERAL_ROUNDING_RADIUS;
tab_size = CLASS_BOX_DIVIDER_TAB_SIZE;
tab_offset = CLASS_BOX_LARGE_TAB_OFFSET;
icon_height = GENERAL_TEXT_THICKNESS;
scale_factor = 0.28;

linear_extrude(height=base_box_z)
    round2d(base_box_r, base_box_r)
        union() {
            translate(v=[base_box_x / 2 - tab_offset / 2 - tab_offset, -base_box_y / 2 - tab_size / 2, 0])
                square(size=[base_box_x, base_box_y], center=true);

            square(size=[tab_size, tab_size], center=true);
        }

color("aqua")
    translate(v=[0, 0, base_box_z])
        rotate(a=[0, 0, -90])
            linear_extrude(height=icon_height)
                scale(v=[scale_factor, scale_factor, 1])
                    import(
                        file="../img/lock.svg",
                        center=true,
                        dpi=1000,
                        convexity=10,
                    );
