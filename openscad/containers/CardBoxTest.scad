use <..\libraries\boxes\CardBox.scad>


l_x=5;
w_y=5;
h_z=5;
mt=1/8;
lid_pct = .4;
overlap = .5;
$fn = 100;
//eps=.0001;


// box
cardBox(l_x,w_y,h_z,lid_pct,overlap,[.2,.5,.8]);

// lid
color("red")
	rotate([180,0,0])
	translate([0,-w_y,-2*h_z])
	cardBoxLid(l_x,w_y,h_z,mt,lid_pct);

// dividers
color("yellow")
	translate([-l_x-mt,0,0])
	cardBoxDivider(l_x,w_y,h_z,lid_pct,overlap);

//color("green")
//	translate([mt,(w_y-2*mt)*.75 + mt,mt])
//	cardBoxDivider(l_x,w_y,h_z,lid_pct,overlap);