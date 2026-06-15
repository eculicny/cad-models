include <./gloomhaven_const.scad>
use <boxes/standard_box.scad>
use <boxes/box_lid.scad>

token_stack_count = 5;
stack_height = token_stack_count * TOKEN_THICKNESS;
x = 140;
y = 70;

angle = .95;
slot_height = 2;
slot_offset = 1;
inset = 3;
$fn = 150;

translate([0, -y - 10, 0])
    boxLid([x, y, stack_height], MATERIAL_THICKNESS, angle);
standardBox([x, y, stack_height], [slot_height, slot_offset], inset, RADIUS_EXT, MATERIAL_THICKNESS, angle, "");
