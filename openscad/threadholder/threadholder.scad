



$fn = 60;

height = 4;
length = 100;
width = 40;
holes = 6;
padding = 9;
radius = 7;
number_offset = 48;

difference() {
  //	hull(){
  //		cylinder(height,1);
  //		translate([length,0,0])
  //			cylinder(height,1);
  //		translate([0,width,0])
  //			cylinder(height,1);
  //		translate([length,width,0])
  //			cylinder(height,1);
  //	}

  hull() {
    for (i = [0:holes - 1]) {
      translate([0, width * 1 / 5, 0])
        color("red")
          translate([i * (length - 2 * padding) / (holes - 1) + padding, 0, 0])
            cylinder(height, r=radius + 2);

      //			translate([-4,width*1/5 + 8,0])
      //			translate([i*(length-2*padding)/(holes-1)+padding,0,0])
      //			number(i+1);

      translate([0, width * 4 / 5, 0])
        color("red")
          translate([i * (length - 2 * padding) / (holes - 1) + padding, 0, 0])
            cylinder(height, r=radius + 2);

      //			translate([4,width*4/5 - 5 - 7,0])
      //			translate([i*(length-2*padding)/(holes-1)+padding,0,0])
      //			number(2*holes - i);
    }
  }

  for (i = [0:holes - 1]) {
    translate([0, width * 1 / 5, 0])
      color("red")
        translate([i * (length - 2 * padding) / (holes - 1) + padding, 0, 0])
          cylinder(height + 1, r=radius);

    translate([-4, width * 1 / 5 + 8, 0])
      translate([i * (length - 2 * padding) / (holes - 1) + padding, 0, 0])
        number(number_offset + i + 1);

    translate([0, width * 4 / 5, 0])
      color("red")
        translate([i * (length - 2 * padding) / (holes - 1) + padding, 0, 0])
          cylinder(height + 1, r=radius);

    translate([4, width * 4 / 5 - 5 - 7, 0])
      translate([i * (length - 2 * padding) / (holes - 1) + padding, 0, 0])
        number(number_offset + 2 * holes - i);
  }
}

module number(i) {
  color("yellow")
    translate([0, 0, height - 2])
      linear_extrude(2)
        text(str(i), size=5, halign="center");
}
