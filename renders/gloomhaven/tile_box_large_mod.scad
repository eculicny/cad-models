
wall = 1;

module corner_cutout() {
    linear_extrude(height=22)
        polygon(
            points=[
                [0, 0],
                [0, 40 - 2 * wall],
                [-15 - 2 * wall, 30 - 2 * wall],
                [-15 - 2 * wall, 10.1 - 2 * wall],
                [-22.5 - 2 * wall, 5.8 - 2 * wall],
                [-22.5 - 2 * wall, 0],
            ],
            paths=[[0, 1, 2, 3, 4, 5]]
        );
}

difference() {
    // 188.85x245
    import("./large_tile_tray.stl", convexity=3);

    // bottom right corner
    translate([245 / 2 - wall, -188.85 / 2 + wall, wall])
        corner_cutout();
    // bottom left corner
    translate([0, 0, 22 + 2 * wall])
        rotate([0, 180, 0])
            translate([245 / 2 - wall, -188.85 / 2 + wall, wall])
                corner_cutout();
    // "trapezoidal" block
    translate([-245 / 2 + wall, 26.6, wall])
        linear_extrude(height=22)
            polygon(
                points=[
                    [0, 0],
                    [0, 39.6 - 2 * wall],
                    [5 - 2 * wall, 39.6 - 2 * wall],
                    [21 - 2 * wall, 30.3 - 2 * wall],
                    [21 - 2 * wall, 11.3 - 2 * wall],
                    [5 - 2 * wall, 0],
                ],
                paths=[[0, 1, 2, 3, 4, 5]]
            );
}
