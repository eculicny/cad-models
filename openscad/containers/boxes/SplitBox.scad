use <./../shapes/roundedshapes.scad>


module boxLid(size, mt, angle){
	x = size[0];
	y = size[1];

	divot_depth = 1;

	difference(){
		translate([x/2,y/2,0])
			linear_extrude(3,scale=[1,angle])
			square([x, y], center=true);
		
		translate([mt,y/2-(1/4*y)/2,mt-divot_depth])
			linear_extrude(divot_depth)
			square([mt,1/4*y]);
	}
}


module splitBox(size, small_size, slot, inset, inneredge_height, r, mt, angle, box_text){
	x = size[0];
	y = size[1];
	z = size[2];

	small_x = small_size[0];
	small_y = small_size[1];

	slot_height = slot[0];
	slot_offset = slot[1];

	inx = x-2*mt;
	iny = y-2*mt;

	difference(){
		roundcube([x,y,z],r);

		translate([3/2*mt + 1,mt,mt])
			roundcube([inx-2*mt-small_x - 1,iny,z],r);
		translate([3/2*mt + 1,mt,mt])
			roundcube([inx-1/2*mt - 1,iny-mt-small_y - 1,z],r);
		translate([3/2*mt+inx-mt-small_x,3/2*mt+iny-mt-small_y,mt])
			roundcube([small_x,small_y,z],r);
		translate([inx-2*mt-small_x,iny-mt-small_y+(small_y)/2+mt,z/2+mt])
			rotate([0,90,0])
			linear_extrude(4*mt)
			resize([z,iny/3])
			circle(1);

		translate([mt,mt,z - slot_height - slot_offset])
			cube([x,iny,z]);

		translate([inset,inset/2,z - slot_height - slot_offset])
		union(){
			translate([x/2,(y-inset)/2,.5])
				linear_extrude(3,scale=[1,angle])
				square([x, y-inset], center=true);
			linear_extrude(.5)
				square([x, y-inset]);
		}

		// text engraving
		translate([mt,mt/4,(z+mt)/4])
			rotate([90,0,0])
			splitBoxText(z, mt, box_text);

		translate([mt,mt,inneredge_height])
			roundcube_2d([inx, iny, 2*z],r);
	}
}

module standardBox(size, slot, inset, r, mt, angle, box_text){
	x = size[0];
	y = size[1];
	z = size[2];

	slot_height = slot[0];
	slot_offset = slot[1];

	inx = x-2*mt;
	iny = y-2*mt;

	difference(){
		roundcube([x,y,z],r);

		// slot
		translate([inset,inset/2,z - slot_height - slot_offset])
		union(){
			translate([x/2,(y-inset)/2,.5])
				linear_extrude(3,scale=[1,angle])
				square([x, y-inset], center=true);
			linear_extrude(.5)
				square([x, y-inset]);
		}

		// straighten the overhang
		translate([mt,mt,z - slot_height - slot_offset])
			roundcube_2d([x,iny,z],r);

		// text engraving
		translate([mt,mt/4,(z+mt)/4])
			rotate([90,0,0])
			splitBoxText(z, mt, box_text);

		translate([mt,mt,mt])
			roundcube([inx, iny, 2*z],r);

		translate([mt,mt,z - slot_height - slot_offset])
			cube([x,iny,z]);
	}
}


module splitBoxText(z, mt, box_text){
	linear_extrude(mt/4)
	text(box_text,size=z/2.5, valign="baseline", halign="left");
}

module multiBox(size, slot, inset, r, mt, angle){
	x = size[0];
	y = size[1];
	z = size[2];

	slot_height = slot[0];
	slot_offset = slot[1];

	inx = x-2*mt;
	iny = y-2*mt;

	r1 = r[0];
	r2 = r[1];

	slot_straight_height = .4;

	difference(){
		roundcube([x,y,z],r1);

		// slot
		translate([inset,inset/2,z - slot_height - slot_offset])
		union(){
			translate([x/2,(y-inset)/2,slot_straight_height])
				linear_extrude(3,scale=[1,angle])
				square([x, y-inset], center=true);
			linear_extrude(slot_straight_height)
				square([x, y-inset]);
		}

		// straighten the overhang
		translate([mt,mt,z - slot_height - slot_offset])
			roundcube_2d([x,iny,z],r1);

//		// text engraving
//		translate([mt,mt/4,(z+mt)/4])
//			rotate([90,0,0])
//			splitBoxText(z, mt, box_text);

		translate([mt,mt,mt])
			roundcube([inx, iny, 2*z],r2);
	}
}

module multiBoxPart(size, slot, r, mt){
	x = size[0];
	y = size[1];
	z = size[2];

	slot_height = slot[0];
	slot_offset = slot[1];

	inx = x-2*mt;
	iny = y-2*mt;

	r1 = r[0];
	r2 = r[1];

	difference(){
		roundcube([x,y,z],r1);

		translate([0,0,z - slot_height - slot_offset])
			roundcube_2d([x,y,z],r1);

		translate([mt,mt,mt])
			roundcube([inx, iny, 2*z],r2);
	}
}



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
height_z = 2 * material_thickness + tokens*token_height + 1; //1 padding

slot_offset_ = 1;
inset_ = 3;

inneredge_height_ = material_thickness + tokens*token_height + 1 - inset_thickness;

full_x = 2 * material_thickness + full_int_x_;
full_y = 2 * material_thickness + full_int_y_;

full_lid_x = full_x-material_thickness - 1; //-1 padding
full_lid_y = full_y-inset_-.5; //-.5 padding

r = 2;
text_val = "Test Box";

$fn=150;

color("blue")
translate([0,-15,0])
mirror([0,1,0]){
	splitBoxText(height_z, material_thickness, text_val);
}

translate([-5/4*full_x,0,0])
standardBox([full_x,full_y,height_z], [slot_height_, slot_offset_], inset_, r,material_thickness, angle_, text_val);

splitBox([full_x,full_y,height_z],[small_x_, small_y_], [slot_height_, slot_offset_], inset_, inneredge_height_, r,material_thickness, angle_, text_val);

translate([0, full_y + 30,0])
color("purple")
	boxLid([full_lid_x, full_lid_y], material_thickness, angle_);

//****************************** MultiBox ****************************//

multi_angle = .95;
r2 = 4;

boxes = 8;

multi_full_int_x = 2.5*(25/2); //x2.5 status tokens width (25/2)
multi_full_int_y = multi_full_int_x;

multi_full_x = 2 * material_thickness + multi_full_int_x;
multi_full_y = 2 * material_thickness + multi_full_int_y;

multi_full_length_x = floor(boxes/2) * (multi_full_int_x + material_thickness) + material_thickness;
multi_full_length_y = (2) * (multi_full_int_y + material_thickness) + material_thickness;

multi_full_lid_x = multi_full_length_x-material_thickness - 1; //-1 padding
multi_full_lid_y = multi_full_length_y-inset_-.5; //-.5 padding

translate([-5/4*full_x,-5/4*full_y,0])
union(){
	color("blue")
		standardBox([multi_full_length_x,multi_full_length_y,height_z], [slot_height_, slot_offset_], inset_, r,material_thickness, multi_angle, "");

	for(i = [0 : boxes-1]){
		translate([floor(i/2)*(multi_full_x-material_thickness),(i%2)*(multi_full_y - material_thickness),0])
			multiBoxPart([multi_full_x,multi_full_y,height_z], [slot_height_, slot_offset_], [r, r2], material_thickness);
	}
}

//translate([-5/4*full_x,-5/4*full_y,0])
//multiBox([multi_full_x,multi_full_y,height_z], [slot_height_, slot_offset_], inset_, [r, r2], material_thickness, multi_angle);

translate([-5/4*full_x,-9/4*full_y,0])
color("purple")
	boxLid([multi_full_lid_x, multi_full_lid_y], material_thickness, multi_angle);