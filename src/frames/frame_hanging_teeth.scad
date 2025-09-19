include <BOSL2/std.scad>
include <BOSL2/gears.scad>

module frame_hanging_teeth() {
    // TODO parameterize at some point

    // hanger w/ back plate
    union() {
        linear_extrude(2, scale=[1, 1])
            rack2d(pitch=5, teeth=6, helical=60);

        translate(v=[0, -4.07, -3])
            linear_extrude(3, scale=[1, 3])
                square(size=[60, 1, 0], center=true);
        translate([-30, -5.57, 2])
            rotate(a=[0, 180, 0])
                linear_extrude(height=5, scale=2)
                    square(size=[1, 3.57]);
        translate([30, -5.57, 2])
            rotate(a=[0, 180, 0])
                mirror(v=[1, 0, 0])
                    linear_extrude(height=5, scale=2)
                        square(size=[1, 3.57]);
    }
}

//frame_hanging_teeth();
