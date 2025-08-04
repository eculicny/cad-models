use <shapes/roundcube.scad>
use <shapes/roundcube_2d.scad>

module multiBox(size, slot, inset, r, mt, angle) {
    x = size[0];
    y = size[1];
    z = size[2];

    slot_height = slot[0];
    slot_offset = slot[1];

    inx = x - 2 * mt;
    iny = y - 2 * mt;

    r1 = r[0];
    r2 = r[1];

    slot_straight_height = .4;

    difference() {
        roundcube([x, y, z], r1);

        // slot
        translate([inset, inset / 2, z - slot_height - slot_offset])
            union() {
                translate([x / 2, (y - inset) / 2, slot_straight_height])
                    linear_extrude(3, scale=[1, angle])
                        square([x, y - inset], center=true);
                linear_extrude(slot_straight_height)
                    square([x, y - inset]);
            }

        // straighten the overhang
        translate([mt, mt, z - slot_height - slot_offset])
            roundcube_2d([x, iny, z], r1);

        //        // text engraving
        //        translate([mt,mt/4,(z+mt)/4])
        //            rotate([90,0,0])
        //            box_text(z, mt, box_text);

        translate([mt, mt, mt])
            roundcube([inx, iny, 2 * z], r2);
    }
}

module multiBoxPart(size, slot, r, mt) {
    x = size[0];
    y = size[1];
    z = size[2];

    slot_height = slot[0];
    slot_offset = slot[1];

    inx = x - 2 * mt;
    iny = y - 2 * mt;

    r1 = r[0];
    r2 = r[1];

    difference() {
        roundcube([x, y, z], r1);

        translate([0, 0, z - slot_height - slot_offset])
            roundcube_2d([x, y, z], r1);

        translate([mt, mt, mt])
            roundcube([inx, iny, 2 * z], r2);
    }
}
