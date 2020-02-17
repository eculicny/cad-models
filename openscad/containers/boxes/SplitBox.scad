use <./../shapes/roundedshapes.scad>

r = .05;
z = .5;
x = 6.25; //6.375;
y = 4.25; //4.375;
mt = .125;
interlock = 1;
x_pct = .25;
y_pct = .6;

$fn=50;
$eps=.0001;


module splitBoxLid(size, tab, r){
	x = size[0];
	y = size[1];
	z = size[2];

	tab_x = tab[0];
	tab_y = tab[1];

	union(){
		roundcube_2d([x-2*mt,y-2*mt,z],r);
		translate([-tab_x,(y-tab_y)/2,0])
			roundcube_2d([x, tab_y, z],r);
	}
}

module splitBox(size, tab, pcts, r, mt, box_text, $eps=.0001){
	x = size[0];
	y = size[1];
	z = size[2];

	x_pct = pcts[0];
	y_pct = pcts[1];

	inx = x-2*mt;
	iny = y-2*mt;

	difference(){
		roundcube([x,y,z],r);
		translate([mt,mt,mt])
			roundcube([inx*(1-x_pct),iny,z],r);
		translate([mt,mt,mt])
			roundcube([inx,iny*(1-y_pct),z],r);
		translate([3/2*mt+inx*(1-x_pct),3/2*mt+iny*(1-y_pct),mt])
			roundcube([inx*x_pct-mt/2,iny*y_pct-mt/2,z],r);
		// might need to switch x to tab_x
		translate([mt,mt,z-mt])
			splitBoxLid(size, tab, r);
		//color("green")
		translate([inx*(1-x_pct)+mt*3/8,iny*(1-y_pct)+(iny*y_pct)/2+mt,z-mt+$eps])
			rotate([0,90,0])
			linear_extrude(2*mt)
			resize([z,iny/3])
			circle(1);
		// text engraving
		translate([mt,mt/4,(z+mt)/4])
			rotate([90,0,0])
			linear_extrude(mt/4)
			text(box_text,size=z/2, valign="baseline", halign="left");
	}
	
//	color("green")
//		translate([inx*(1-x_pct)+mt*3/8,iny*(1-y_pct)+(iny*y_pct)/2+mt,z-mt])
//			rotate([0,90,0])
//			linear_extrude(2*mt)
//			resize([z,iny/3])
//			circle(1);
}



	color("green")
	splitBox([x,y,z],[mt,interlock],[x_pct,y_pct],r,mt,"Box Tag");

color("yellow")
translate([mt,mt,5*z])
splitBoxLid([x,y,mt],[mt,interlock],r);