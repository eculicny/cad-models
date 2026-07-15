module monster_box_name_plate_v1(monster_name, name_plate_width) {

    name_plate_length = 50.8; // initiative_slot_inner_length - 0.7
    name_plate_thickness = 1.6;

    cube(
        size=[
            name_plate_length,
            name_plate_width,
            name_plate_thickness,
        ], center=true
    );
    color("BLACK")
        translate([0, 0, name_plate_thickness / 2])
            linear_extrude(height=0.4)
                text(
                    monster_name,
                    size=5,
                    spacing=0.9,
                    font="pirataone",
                    halign="center",
                    valign="center"
                );
}

monster_name = "Stone Golem";
// full z - 1.2(5) (from initiative_slot_lip_height)
name_plate_width = 7.2; // for 2x standees
monster_box_name_plate_v1(monster_name, name_plate_width);
