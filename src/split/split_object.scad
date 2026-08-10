// Based off of SplitCut (https://www.thingiverse.com/thing:6605158)

$fn = 100;

module sine_wave(tolerance) {
    // Number of steps and scaling factors
    steps = 3600;
    amplitude = 1;
    wavelength_scale = .01;

    // Generate points for the sine wave polyline
    pts = [for (x = [0:.1:inf]) [x, amplitude * sin(x / wavelength_scale)]];
    rotate(a=[-90, 0, 0])
        linear_extrude(height=inf) {
            for (i = [0:len(pts) - 2]) {
                hull() {
                    translate(pts[i]) circle(r=tolerance);
                    translate(pts[i + 1]) circle(r=tolerance);
                }
            }
        }
}

function sine(x, amplitude, length, periods) =
    amplitude * sin((x / length) * (periods * 360.0));

module wavey(width, height, length, amplitude, periods, dl) {
    top_coords = [for (l = [0:dl:length]) [l, height + sine(l, amplitude, length, periods)]];
    bottom_coords = [for (l = [length:-dl:0]) [l, sine(l, amplitude, length, periods)]];
    coords = concat(top_coords, bottom_coords);

    polygon(coords);
}

module interlock(size) {
    // TODO types
    translate([-size / 2, size / 4, 0])
        square([size, size / 2]);
    translate([-size / 4, 0, 0])
        square([size / 2, size / 4 ]);
}

// TODO add "type" to params: "linear", "sin", "zigzag", etc.
// tabs only supported in certain cases (not really important in sin/zigzag cases)
module split_surface(
    translation,
    rotation,
    tab_locations,
    tab_size,
    tolerance,
    type,
    inf,
) {
    translate(translation)
        rotate(rotation) {
            translate([0, 0, -inf / 2])
                linear_extrude(inf, convexity=5)
                    offset(r=tolerance)
                        offset(r=-2 * tolerance)
                            union() {
                                translate([-inf / 2, -inf, 0]) {
                                    if (type == "sine") {
                                        wavey(inf, inf, inf, 1, 25, 0.1);
                                    } else {
                                        square([inf, inf]);
                                    }
                                }

                                for (i = tab_locations) {
                                    translate([i, 0, 0])
                                        interlock(tab_size);
                                }
                            }
        }
}

// TODO add center arg (current method _does_ center it)
module split(
    // Part to render ("tab", "slot", "both") // TODO figure out better naming
    render_parts = "both",
    // Rotation of the dividing surface (applied before translation)
    rotation = [0, 0, 90],
    // Translation of the dividing surface
    translation = [0, 0, 0],
    // Tolerance for fit between parts
    tolerance = 0.1,
    // Split type ("planar", "sine")
    split_type = "planar",
    // Other parameters used by the used splitting method
    split_params = [],
    // Type of tab ("sqaure", "none")
    tab_type = "none",
    // TODO switch to tab params?
    // Width of the tab
    tab_size = 0,
    // Centers of tabs along x-axis of initial dividing surface
    tab_locations = [0],
    // "Infinity" for performance reasons, affects sine wave frequency // TODO move into split_params?
    inf = 250,
) {

    module split_surface_difference(translation, rotation, tab_locations, tab_size, tolerance, split_type, inf) {
        difference() {
            children(0);
            split_surface(translation, rotation, tab_locations, tab_size, -tolerance / 2, split_type, inf);
        }
    }

    module split_surface_intersection(translation, rotation, tab_locations, tab_size, tolerance, split_type, inf) {
        intersection() {
            children(0);
            split_surface(translation, rotation, tab_locations, tab_size, tolerance / 2, split_type, inf);
        }
    }

    // Arrange parts to not be interlocking if rendering both
    if (render_parts == "both") {
        translate([sin(rotation[2]) * tab_size / 2, -cos(rotation[2]) * tab_size / 2, 0])
            split_surface_intersection(translation, rotation, tab_locations, tab_size, tolerance, split_type, inf)
                children(0);

        translate([-sin(rotation[2]) * tab_size / 2, cos(rotation[2]) * tab_size / 2, 0])
            split_surface_difference(translation, rotation, tab_locations, tab_size, tolerance, split_type, inf)
                children(0);
    } else if (render_parts == "male") {
        split_surface_intersection(translation, rotation, tab_locations, tab_size, tolerance, split_type, inf)
            children(0);
    } else if (render_parts == "female") {
        split_surface_difference(translation, rotation, tab_locations, tab_size, tolerance, split_type, inf)
            children(0);
    }
}
