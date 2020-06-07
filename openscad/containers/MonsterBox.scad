use <./boxes/SplitBox.scad>

full_int_x = 103; //102+1padding
full_int_y = full_int_x;
s_x = 46; // 44+2padding
s_y = 70; // 68+2padding
angle_ = .95; //.95 for fullsize
material_thickness = 3;
inset_thickness = 1.5;

tokens = 3;
token_height = 2.5;
slot_height_ = 2;
height_z = 2 * material_thickness + tokens*token_height + 1; //1 padding

slot_offset_ = 1;
inset_ = 3;

inneredge_height = material_thickness + tokens*token_height + 1 - inset_thickness;

full_x = 2 * material_thickness + full_int_x;
full_y = 2 * material_thickness + full_int_y;

full_lid_x = full_x-material_thickness - 1; //-1 padding
full_lid_y = full_y-inset_-.5; //-.5 padding

r = 2;
text_val = "Harrower Infester & Lurker";

$fn=150;

color("blue")
translate([0,-15,0])
mirror([0,1,0]){
	splitBoxText(height_z, material_thickness, text_val);
}

translate([-5/4*full_x,0,0])
standardBox([full_x,full_y,height_z], [slot_height_, slot_offset_], inset_, r,material_thickness, angle_, text_val);

splitBox([full_x,full_y,height_z],[s_x, s_y], [slot_height_, slot_offset_], inset_, inneredge_height, r,material_thickness, angle_, text_val);

translate([0, full_y + 30,0])
color("purple")
	boxLid([full_lid_x, full_lid_y], material_thickness, angle_);

