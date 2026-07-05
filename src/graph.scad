use <util/degrees.scad>
use <polyline3d.scad>
use <polyline_join.scad>
use <stereographic_extrude.scad>

$fn = 15;

module graph(adj_mat) {
    n = len(adj_mat);
    r = 10;
    coords = [for(i = 0;i < n;i = i + 1)[r * cos(2 * degrees(PI) * i / n), r * sin(2 * degrees(PI) * i / n)]];
    echo(coords);
    for (i = [0:1:len(coords) - 1]) {
        echo(coords[i][0], coords[i][1]);
        translate([coords[i][0], coords[i][1], 0])
            circle(3);
        for (j = [i:1:len(adj_mat[i]) - 1]) {
            if (adj_mat[i][j] == 1) {
                //polyline3d([coords[i], coords[j]], 1);
                polyline_join([coords[i], coords[j]])
                    circle(1);
            }
        }
    }
}

// C5
adj_mat = [
    [0, 1, 0, 0, 1],
    [1, 0, 1, 0, 0],
    [0, 1, 0, 1, 0],
    [0, 0, 1, 0, 1],
    [1, 0, 0, 1, 0],
];
stereographic_extrude(shadow_side_leng=40, convexity=10, $fn=$fn * 2)
    graph(adj_mat);
