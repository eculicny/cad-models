use <shapes/roundcube.scad>
use <shapes/roundcube_2d.scad>
use <box_text.scad>

module splitBox(size, small_size, slot, inset, inneredge_height, r, mt, angle, box_text) {
    x = size[0];
    y = size[1];
    z = size[2];

    small_x = small_size[0];
    small_y = small_size[1];

    slot_height = slot[0];
    slot_offset = slot[1];

    inx = x - 2 * mt;
    iny = y - 2 * mt;

    difference() {
        roundcube([x, y, z], r);

        translate([3 / 2 * mt + 1, mt, mt])
            roundcube([inx - 2 * mt - small_x - 1, iny, z], r);
        translate([3 / 2 * mt + 1, mt, mt])
            roundcube([inx - 1 / 2 * mt - 1, iny - mt - small_y - 1, z], r);
        translate([3 / 2 * mt + inx - mt - small_x, 3 / 2 * mt + iny - mt - small_y, mt])
            roundcube([small_x, small_y, z], r);
        translate([inx - 2 * mt - small_x, iny - mt - small_y + (small_y) / 2 + mt, z / 2 + mt])
            rotate([0, 90, 0])
                linear_extrude(4 * mt)
                    resize([z, iny / 3])
                        circle(1);

        translate([mt, mt, z - slot_height - slot_offset])
            cube([x, iny, z]);

        translate([inset, inset / 2, z - slot_height - slot_offset])
            union() {
                translate([x / 2, (y - inset) / 2, .5])
                    linear_extrude(3, scale=[1, angle])
                        square([x, y - inset], center=true);
                linear_extrude(.5)
                    square([x, y - inset]);
            }

        // text engraving
        translate([mt, mt / 4, (z + mt) / 4])
            rotate([90, 0, 0])
                box_text(z, mt, box_text);

        translate([mt, mt, inneredge_height])
            roundcube_2d([inx, iny, 2 * z], r);
    }
}
