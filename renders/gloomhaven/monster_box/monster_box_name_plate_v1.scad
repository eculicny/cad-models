monster_name = "Stone Golem";

cube(size=[50.8, 7.2, 1.7], center=true);
color("BLACK")
    translate([0, 0, 1.7 / 2])
        linear_extrude(height=0.4)
            text(
                monster_name,
                size=5,
                spacing=0.9,
                font="pirataone",
                halign="center",
                valign="center"
            );
