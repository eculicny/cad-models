include <../gloomhaven_const.scad>

file_name = "../img/triangles.svg";
scale_factor = .55; //normally 1.8
y_offset = -1.4; // -1.4 for triangles

$fn = 300;
module class_box_icon(file_name, scale_factor, y_offset) {
    icon_height = GENERAL_TEXT_THICKNESS;
    icon_thickness = CLASS_BOX_ICON_BASE_THICKNESS;
    class_icon_cutout_radius = CLASS_BOX_ICON_CUTOUT_RADIUS - 0.1;
    cylinder(h=icon_thickness, r1=class_icon_cutout_radius, r2=class_icon_cutout_radius);

    color("aqua")
        translate(v=[0, y_offset, icon_thickness])
            linear_extrude(height=icon_height)
                scale(v=[scale_factor, scale_factor, 1])
                    import(
                        file=file_name,
                        center=true,
                        dpi=1000,
                        convexity=10,
                    );
}

class_box_icon(file_name, scale_factor, y_offset);
