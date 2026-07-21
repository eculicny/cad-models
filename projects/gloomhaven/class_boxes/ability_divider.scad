include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>
use <Round-Anything/polyround.scad>

base_box_x = LARGE_CARD_WIDTH;
base_box_y = LARGE_CARD_LENGTH;
base_box_z = 0.6;
base_box_r = 2;
tab_size = 12;
tab_offset = 12;
icon_height = 0.4;

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
                scale(v=[.3, .3, 1])
                    import(
                        file="../img/lock.svg",
                        center=true,
                        dpi=1000,
                        convexity=10,
                    );
