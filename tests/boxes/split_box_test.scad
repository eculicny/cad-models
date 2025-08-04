use <boxes/split_box.scad>
//****************************** Split Box ****************************//
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

splitBox([full_x, full_y, height_z], [small_x_, small_y_], [slot_height_, slot_offset_], inset_, inneredge_height_, r, material_thickness, angle_, text_val);
