use <boxes/box_text.scad>

material_thickness = 3;
tokens = 3;
token_height = 2.5;
height_z = 2 * material_thickness + tokens * token_height + 1; //1 padding
text_val = "Test Box";

color("blue")
    translate([0, -15, 0])
        mirror([0, 1, 0]) {
            box_text(height_z, material_thickness, text_val);
        }
