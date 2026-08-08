include <../gloomhaven_const.scad>

file_name = "../img/triangles.svg";
scale_factor = .55; //normally 1.8
y_offset = -1.4; // -1.4 for triangles

$fn = 300;
icon_height = 0.4;
icon_thickness = 1;
class_icon_cutout_radius = 6.5;
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
