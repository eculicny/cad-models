include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>

module envelope_box() {

    $fn = 100;
    base_box_wall = GENERAL_WALL_THICKNESS;
    base_box_floor = GENERAL_WALL_THICKNESS;
    base_box_x = TOKEN_BOX_X;
    base_box_y = TOKEN_BOX_Y;
    int_base_box_z = SECRET_ENVELOPE_STACK_HEIGHT;
    base_box_r = 2;
    int_base_box_x = base_box_x - 2 * base_box_wall;
    int_base_box_y = base_box_y - base_box_floor;
    base_box_z = int_base_box_z + 2 * base_box_wall;
    box_label_depth = base_box_wall / 4;
    box_label = ["Secret", "Envelopes"];

    /********************************************************/
    // TODO move writing functions to lib
    /**
 * Writes multiline text with proper spacing and alignment.
 *
 * @param lines       List of text strings (one per line).
 * @param font        Font name.
 * @param size        Font size.
 * @param spacing     Letter spacing.
 * @param lineheight  Line height.
 * @param halign      Horizontal alignment for each line ("left", "center", "right").
 * @param valign      Vertical alignment for the entire block ("top", "center", "bottom").
 */
    module write(lines, font, size, spacing = 1, lineheight = 1, halign = "right", valign = "center") {
        // Compute font metrics and interline spacing
        fm = fontmetrics(size=size, font=font);
        interline = fm.interline * lineheight;
        n = len(lines);

        // Calculate total bounding box dimensions
        bbox = calculate_bounding_box(lines, font, size, spacing, interline);
        total_height = bbox[1];

        // Determine vertical offset for block alignment
        y_offset =
            (valign == "top") ? 0
            : (valign == "center") ? -total_height / 2
            : -total_height;

        // Render text lines with appropriate alignment
        translate([0, -y_offset]) {
            for (i = [0:n - 1]) {
                translate([0, -(interline * i + interline / 2)])
                    text(
                        text=lines[i],
                        font=font,
                        size=size,
                        spacing=spacing,
                        halign=halign,
                        valign="center"
                    );
            }
        }
    }

    /**
 * Calculates the total bounding box for multiline text.
 *
 * @param lines       List of text strings (one per line).
 * @param font        Font name.
 * @param size        Font size.
 * @param spacing     Letter spacing.
 * @param interline   Interline spacing (height between lines).
 * @return A 2D vector containing the total width and height of the text block.
 */
    function calculate_bounding_box(lines, font, size, spacing, interline) =
        [
            // Calculate the widest line
            max([for (line = lines) textmetrics(text=line, font=font, size=size, spacing=spacing).size.x]),
            // Calculate total height
            interline * len(lines),
        ];
    /********************************************************/

    difference() {
        roundcube_2d(size=[base_box_x, base_box_y, base_box_z], radius=base_box_r);

        translate(v=[base_box_wall, base_box_floor, base_box_wall])
            roundcube_2d(size=[int_base_box_x, int_base_box_y, int_base_box_z], radius=base_box_r);

        translate(v=[base_box_x / 2, base_box_y / 2, base_box_z - box_label_depth])
            linear_extrude(height=box_label_depth)
                write(
                    lines=box_label,
                    size=20,
                    spacing=1,
                    font="pirataone",
                    halign="center",
                    valign="center"
                );
    }
}
envelope_box();
