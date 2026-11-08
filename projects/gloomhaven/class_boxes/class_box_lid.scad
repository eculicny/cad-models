include <../gloomhaven_const.scad>

file_name = "../img/spellweaver.svg";
scale_factor = 10; //3.5; //normally 10

module class_box_lid(file_name, scale_factor) {
    lid_thickness = CLASS_BOX_LID_THICKNESS;
    angle_width = CLASS_BOX_LID_ANGLE_WIDTH;
    lid_x = CLASS_BOX_LID_BASE_LENGTH;
    lid_y = CLASS_BOX_LID_BASE_HEIGHT;
    icon_height = GENERAL_TEXT_THICKNESS;

    union() {
        translate(v=[-lid_x / 2, -lid_y / 2, 0])
            hull() {
                translate(v=[angle_width, lid_y, 0])
                    rotate(a=[0, 0, 90])
                        rotate(a=[90, 0, 0])
                            linear_extrude(height=lid_x)
                                polygon(points=[[0, 0], [0, lid_thickness], [angle_width, 0]], paths=[[0, 1, 2]]);
                translate(v=[angle_width, 0, 0])
                    rotate(a=[0, 0, 180])
                        rotate(a=[90, 0, 0])
                            linear_extrude(height=lid_y)
                                polygon(points=[[0, 0], [0, lid_thickness], [angle_width, 0]], paths=[[0, 1, 2]]);

                translate(v=[lid_x + angle_width, lid_y, 0])
                    rotate(a=[90, 0, 0])
                        linear_extrude(height=lid_y)
                            polygon(points=[[0, 0], [0, lid_thickness], [angle_width, 0]], paths=[[0, 1, 2]]);
            }

        color("aqua")
            translate(v=[0, 0, lid_thickness])
                linear_extrude(height=icon_height)
                    scale(v=[scale_factor, scale_factor, 1])
                        import(
                            file=file_name,
                            center=true,
                            dpi=1000,
                            convexity=10,
                        );
    }
}

class_box_lid(file_name=file_name, scale_factor=scale_factor);
