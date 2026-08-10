use <../../src/split/split_object.scad>
$fn = 300;
// Puzzle pieces can have "tabs" and "slots", "loops" and "sockets", "knobs" and "holes", "keys" and "locks"

split(
    translation=[0, 0, 0], // Translation of the dividing plane
    rotation=[0, 0, 0], // Rotation of the dividing plane
    tab_locations=[], // position of the tabs along the dividing plane
    tab_size=0, // width of the tabs
    tolerance=0.3, // Distance between parts
    render_parts="both", // Output "both", "male" or "female" part
    split_type="sine"
)
    split(
        translation=[5, 5, 0], // Translation of the dividing plane
        rotation=[0, 0, 70], // Rotation of the dividing plane
        tab_locations=[-10, 7], // position of the tabs along the dividing plane
        tab_size=4, // width of the tabs
        tolerance=0.3, // Distance between parts
        render_parts="both", // Output "both", "male" or "female" part
        split_type="planar"
    )
        import("OctopusThickLegs.stl", convexity=5);
