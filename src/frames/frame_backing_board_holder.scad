
// fixed to 3mm currently
module frame_backing_board_holder(thickness = 1, $fn = 25) {
    // backing board holders
    difference() {
        union() {
            cylinder(r=2.5, h=thickness, $fn=$fn);
            translate(v=[0, -6, 0])
                linear_extrude(thickness)
                    intersection() {
                        translate(v=[4, 0, 0])
                            circle(r=8);
                        translate(v=[-4, 0, 0])
                            circle(r=8);
                    }
        }
        // 3mm hole + tolerance/slop
        cylinder(r=1.5 + .2, h=thickness + 1, $fn=$fn);
    }
}

frame_backing_board_holder();
