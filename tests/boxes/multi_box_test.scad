use <boxes/multi_box.scad>
use <boxes/box_lid.scad>
use <boxes/standard_box.scad>
//****************************** MultiBox ****************************//

full_int_x_ = 120;
full_int_y_ = full_int_x_;
small_x_ = 50;
small_y_ = 75;
angle_ = .95;
material_thickness = 3;
inset_thickness = 1.5;

tokens = 3;
token_height = 2.5;
slot_height_ = 2;
height_z = 2 * material_thickness + tokens * token_height + 1; //1 padding

multi_angle = .95;
r2 = 4;
slot_offset_ = 1;
inset_ = 3;

inneredge_height_ = material_thickness + tokens * token_height + 1 - inset_thickness;

full_x = 2 * material_thickness + full_int_x_;
full_y = 2 * material_thickness + full_int_y_;

full_lid_x = full_x - material_thickness - 1; //-1 padding
full_lid_y = full_y - inset_ - .5; //-.5 padding

r = 2;
text_val = "Test Box";

$fn = 150;

boxes = 8;

multi_full_int_x = 2.5 * (25 / 2); //x2.5 status tokens width (25/2)
multi_full_int_y = multi_full_int_x;

multi_full_x = 2 * material_thickness + multi_full_int_x;
multi_full_y = 2 * material_thickness + multi_full_int_y;

multi_full_length_x = floor(boxes / 2) * (multi_full_int_x + material_thickness) + material_thickness;
multi_full_length_y = (2) * (multi_full_int_y + material_thickness) + material_thickness;

multi_full_lid_x = multi_full_length_x - material_thickness - 1; //-1 padding
multi_full_lid_y = multi_full_length_y - inset_ - .5; //-.5 padding

translate([-5 / 4 * full_x, -5 / 4 * full_y, 0])
    union() {
        color("blue")
            standardBox([multi_full_length_x, multi_full_length_y, height_z], [slot_height_, slot_offset_], inset_, r, material_thickness, multi_angle, "");

        for (i = [0:boxes - 1]) {
            translate([floor(i / 2) * (multi_full_x - material_thickness), (i % 2) * (multi_full_y - material_thickness), 0])
                multiBoxPart([multi_full_x, multi_full_y, height_z], [slot_height_, slot_offset_], [r, r2], material_thickness);
        }
    }

//translate([-5/4*full_x,-5/4*full_y,0])
//multiBox([multi_full_x,multi_full_y,height_z], [slot_height_, slot_offset_], inset_, [r, r2], material_thickness, multi_angle);

translate([-5 / 4 * full_x, -9 / 4 * full_y, 0])
    color("purple")
        boxLid([multi_full_lid_x, multi_full_lid_y], material_thickness, multi_angle);
