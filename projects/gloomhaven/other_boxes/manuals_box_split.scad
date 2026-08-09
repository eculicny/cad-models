use <./manuals_box.scad>
use <src/split/split_object.scad>

for (j = ["male", "female"]) {
    split(
        translation=[0, 150, 0], // Translation of the dividing plane
        rotation=[0, 0, 0], // Rotation of the dividing plane
        tab_locations=[], // position of the tabs along the dividing plane
        tab_size=0, // width of the tabs
        tolerance=0.5, // Distance between parts
        render_parts=j, // Output "both", "male" or "female" part
        split_type="sine",
        inf=500,
    )
        manuals_box();
}

translate(v=[0, 0, -25])
    manuals_box();
