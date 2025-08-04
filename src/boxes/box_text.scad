module box_text(z, mt, box_text) {
    linear_extrude(mt / 4)
        text(box_text, size=z / 2.5, valign="baseline", halign="left");
}
