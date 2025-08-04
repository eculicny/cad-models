use <shapes/roundcube.scad>
use <shapes/roundcube_2d.scad>
use <box_text.scad>

module standardBox(size, slot, inset, r, mt, angle, box_text) {
    x = size[0];
    y = size[1];
    z = size[2];

    slot_height = slot[0];
    slot_offset = slot[1];

    inx = x - 2 * mt;
    iny = y - 2 * mt;

    difference() {
        roundcube([x, y, z], r);

        // slot
        translate([inset, inset / 2, z - slot_height - slot_offset])
            union() {
                translate([x / 2, (y - inset) / 2, .5])
                    linear_extrude(3, scale=[1, angle])
                        square([x, y - inset], center=true);
                linear_extrude(.5)
                    square([x, y - inset]);
            }

        // straighten the overhang
        translate([mt, mt, z - slot_height - slot_offset])
            roundcube_2d([x, iny, z], r);

        // text engraving
        translate([mt, mt / 4, (z + mt) / 4])
            rotate([90, 0, 0])
                box_text(z, mt, box_text);

        translate([mt, mt, mt])
            roundcube([inx, iny, 2 * z], r);

        translate([mt, mt, z - slot_height - slot_offset])
            cube([x, iny, z]);
    }
}
