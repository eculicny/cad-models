include <../gloomhaven_const.scad>
use <shapes/roundcube_2d.scad>

module large_card_divider(label) {

    $fn = 100;
    divider_thickness = GENERAL_WALL_THICKNESS;
    divider_x = LARGE_CARD_LENGTH;
    // increase default overage to better center on the divider
    divider_y = LARGE_CARD_WIDTH + GENERAL_CARD_LABEL_OVERAGE + 2;
    font_size = GENERAL_CARD_DIVIDER_TEXT_HEIGHT - 1;
    text_vertical_align_adjust = 1;

    union() {
        // center for easier text alignment
        translate(v=[-divider_x / 2, -divider_y + GENERAL_CARD_LABEL_OVERAGE / 2 + text_vertical_align_adjust, -divider_thickness / 2])
            roundcube_2d(size=[divider_x, divider_y, divider_thickness], radius=5);
        color("black")
            translate([0, 0, divider_thickness / 2])
                linear_extrude(height=0.4)
                    text(
                        label,
                        size=font_size,
                        spacing=0.9,
                        font="pirataone",
                        halign="center",
                        valign="center"
                    );
    }
}

label = "Locked Road Events"; // see if long words work
//label = "Road Events";
large_card_divider(label);
