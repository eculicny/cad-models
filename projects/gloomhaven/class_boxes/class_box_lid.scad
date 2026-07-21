include <../gloomhaven_const.scad>

file_name = "../img/triangles.svg";

lid_thickness = 1;
angle_width = 2.35 - GENERAL_WALL_THICKNESS - 0.4;
lid_x = PAPER_CLASS_BOX_LENGTH - 2 * angle_width - 2;
lid_y = PAPER_CLASS_BOX_HEIGHT - angle_width - 1;
icon_height = 0.4;

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
                scale(v=[10, 10, 1])
                    import(
                        file=file_name,
                        center=true,
                        dpi=1000,
                        convexity=10,
                    );
}
