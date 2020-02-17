include <./boxes/SplitBox.scad>


r = .1;
z = .5;
x = 6.25;
y = 4.25;
mt = .125;
interlock = 1.0;
x_pct = .3;
y_pct = .6;

$fn=50;

splitBox([x,y,z],[mt,interlock],[x_pct,y_pct],r,mt);

translate([mt,mt,4*z])
	splitBoxLid([x,y,mt],[mt,interlock],r);