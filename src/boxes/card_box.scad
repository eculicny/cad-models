
function dimensionCalc(x, y, z, mt, lid_pct, lid_overlap_pct) =
    // height of lower box, interior x, interior y
    [z * (1 - lid_pct * lid_overlap_pct), (x - 2 * mt), (y - 2 * mt)];

module cardBoxLid(x, y, z, mt, lid_pct) {
    difference() {
        cube([x, y, z * lid_pct]);
        translate([(mt) / 2, (mt) / 2, mt])
            cube([x - mt, y - mt, z * lid_pct - mt]);
    }
}

module cardBoxSpacedLid(x, y, z, mt, lid_pct) {
    side_spacing = .2; // mm to allow for actually getting the lid off
    difference() {
        cardBoxLid(x, y, z, mt, lid_pct);
        translate([(mt - side_spacing) / 2, (mt - side_spacing) / 2, mt - side_spacing])
            cube([x - (mt - side_spacing), y - (mt - side_spacing), z * lid_pct - (mt - side_spacing)]);
    }
}

module cardBoxInsertSlot(ix, h, mt) {
    union() {
        translate([mt, 0, 0])
            union() {
                cube([mt / 2, mt / 2, h]);
                translate([0, mt, 0])
                    cube([mt / 2, mt / 2, h]);
            }

        translate([ix + mt / 2, 0, 0])
            union() {
                cube([mt / 2, mt / 2, h]);
                translate([0, mt, 0])
                    cube([mt / 2, mt / 2, h]);
            }
    }
}

module cardBox(x, y, z, mt, lid_pct, lid_overlap_pct, slot_list) {
    l = dimensionCalc(x, y, z, mt, lid_pct, lid_overlap_pct);
    h = l[0];
    ix = l[1];
    iy = l[2];
    difference() {
        cube([x, y, z]);
        translate([mt, mt, mt])
            cube([ix, iy, z]);
        rotate([180, 0, 0])
            translate([0, -y, -z - mt])
                cardBoxLid(x, y, z, mt, lid_pct);
        translate([0, 0, h + mt])
            cube([x, y, lid_pct * lid_overlap_pct * z - mt]);
    }

    for (i = slot_list)
        color("purple")
            // adjust to put the min-max slots at the very edges of the interior
            translate([0, mt + (iy - 5 / 2 * mt) * i, mt])
                cardBoxInsertSlot(ix, h, mt);
}

module cardBoxDivider(x, y, z, mt, lid_pct, lid_overlap_pct) {
    l = dimensionCalc(x, y, z, mt, lid_pct, lid_overlap_pct);
    h = l[0];
    ix = l[1];
    iy = l[2];
    difference() {
        union() {
            translate([ix / 6, mt / 2, h / 2])
                rotate([90, 0, 0])
                    linear_extrude(mt / 2)
                        resize([ix / 3, h])
                            circle(1);

            translate([ix * 5 / 6, mt / 2, h / 2])
                rotate([90, 0, 0])
                    linear_extrude(mt / 2)
                        resize([ix * 2 / 6, h])
                            circle(1);

            cube([ix * 1 / 6, mt / 2, h]);

            translate([ix * 1 / 3, 0, 0])
                cube([ix * 2 / 6, mt / 2, h / 2]);

            translate([ix * 5 / 6, 0, 0])
                cube([ix * 1 / 6, mt / 2, h]);

            cube([ix, mt / 2, h / 2]);
        }

        translate([ix * 3 / 6, mt / 2, h / 2])
            rotate([90, 0, 0])
                linear_extrude(mt / 2)
                    resize([ix * 2 / 6, ix * 2 / 6])
                        circle(1);
    }
}

l_x = 30;
w_y = 60;
h_z = 40;
mt = 3;
lid_pct = .4;
overlap = .5;
$fn = 100;
eps = .0001;
dividers = [0, .5, 1];

// box
cardBox(l_x, w_y, h_z, mt, lid_pct, overlap, []);

// lid
color("red")
    translate([40, 0, 0])
        cardBoxLid(l_x, w_y, h_z, mt, lid_pct);

color("green")
    translate([80, 0, 0])
        cardBoxSpacedLid(l_x, w_y, h_z, mt, lid_pct);

// dividers
//color("yellow")
//    translate([-l_x-mt,0,0])
//    cardBoxDivider(l_x,w_y,h_z,mt,lid_pct,overlap);

//color("green")
//    translate([mt,(w_y)*.5-mt/4,mt])
//    cardBoxDivider(l_x,w_y,h_z,mt,lid_pct,overlap);
