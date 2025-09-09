// Solid Bezier curve library.
// Written by Fredrik Hubinette, 2013.
// Documentation at end.

function patch_float(A, x, o) = floor((len(A) - 1) / o) * x;
function patch_base(A, x, o) = floor(patch_float(A, x, o)) * o;
function patch_frac(A, x, o) = patch_float(A, x, o) - floor(patch_float(A, x, o));

// Linear interpolation
function blend(A, B, x) = A * (1 - x) + B * x;

// Order=0, kind of pointless.
function bezier0(A, p, f) = A[p];

// Order=1, linear interpolation.
function bezier1(A, p, f) = blend(bezier0(A, p, f), bezier0(A, p + 1, f), f);

// Order=2, quadratic bezier splines.
function bezier2(A, p, f) = blend(bezier1(A, p, f), bezier1(A, p + 1, f), f);

// Order=3, Cubic bezier splines.
//function bezier3(A, p, f)=blend(bezier2(A, p, f), bezier2(A, p+1, f), f);

// Order=3, Cubic bezier splines are the best, let's optimize them.
function bezier3(A, p, f) =
    A[p] * pow((1 - f), 3) + A[p + 1] * (3 * f * (pow((1 - f), 2))) + A[p + 2] * (3 * (pow(f, 2)) * (1 - f)) + A[p + 3] * pow(f, 3);

// Order=4, tesseractic bezier splines?
function bezier4(A, p, f) = blend(bezier3(A, p, f), bezier3(A, p + 1, f), f);

// Order=5, whateverthe****ic bezier splines
function bezier5(A, p, f) = blend(bezier5(A, p, f), bezier5(A, p + 1, f), f);

// Recursive definition ( which doesn't work of course)
// function bezierN(A, p, f, o)=o==0 ? A[p] : blend(BZNX(A,p,f,o-1), BZNX(A,p+1,f,o-1), f);

// Bezier of any order up to 5.
// A = control points
// p = patch base
// f = fraction
// o = order
function bezierN(A, p, f, o) =
    f == 0.0 ? A[p]
    : o == 3 ? bezier3(A, p, f)
    : o == 2 ? bezier2(A, p, f)
    : o == 1 ? bezier1(A, p, f)
    : o == 4 ? bezier4(A, p, f)
    : o == 5 ? bezier5(A, p, f)
    : o == 0 ? bezier0(A, p, f) : 0;

// A = Any number of concatenated bezier curves.
// o = order
// x = 0.0..1.0
// len(A) must be o * number_of_patches + 1
function bezierMN(A, x, o) = bezierN(A, patch_base(A, x, o), patch_frac(A, x, o), o);

// Bezier curves.
function F_1(DATA, x) = bezierMN(DATA[0], x, DATA[1]);

// Bezier surfaces.
function F_2(DATA, x, y) = bezierMN(bezierMN(DATA[0], y, DATA[2]), x, DATA[1]);

///////////////////////////////////////////////
include <bezier_solids_generated.scad>
///////////////////////////////////////////////

// Make a cylinder from pt1 to pt2 with given radius.
module display_control_line(pt1, pt2, radius) {
    d = pt2 - pt1;
    l1 = sqrt(d[0] * d[0] + d[1] * d[1]);
    l = sqrt(l1 * l1 + d[2] * d[2]);
    translate(pt1)
        rotate([atan2(l1, d[2]), 0, atan2(d[1], d[0]) + 90])
            cylinder(r=radius, h=l);
}

function up23(x) = len(x) == 2 ? [x[0], x[1], 0] : x;

module display_control_points1d(control_points, order, radius) {
    echo(control_points);
    if (radius > 0.0) {
        for (x = [0:len(control_points) - 1])
            translate(up23(control_points[x]))
                rotate([x == 0 ? 23 : 0, 0, 0])
                    color([control_color(x, order), 0.5, 0.5])
                        sphere(r=radius, center=true);

        for (x = [0:len(control_points) - 2])
            color((x % order == 0) ? [1.0, 0.5, 0.5] : [0.5, 0.5, 1.0])
                display_control_line(
                    up23(control_points[x]),
                    up23(control_points[x + 1]), radius / 2
                );
    }
}

function control_color(x, o) = (x % o == 0) ? ( (x == 0) ? 1.0 : 0.5) : 0.0;

module display_control_points2d(control_points, xorder, yorder, radius) {
    if (radius > 0.0) {
        for (y = [0:len(control_points) - 1])
            for (x = [0:len(control_points[y]) - 1])
                translate(control_points[y][x])
                    rotate([x == 0 ? 23 : 0, y == 0 ? 23 : 0, 0])
                        color(
                            [
                                control_color(x, xorder),
                                control_color(y, yorder),
                                0.5,
                            ]
                        )
                            sphere(r=radius, center=true);

        for (y = [0:len(control_points) - 1])
            for (x = [0:len(control_points[y]) - 2])
                color((y % yorder == 0) ? [1.0, 0.5, 0.5] : [0.5, 0.5, 1.0])
                    display_control_line(control_points[y][x], control_points[y][x + 1], radius / 2);

        for (y = [0:len(control_points) - 2])
            for (x = [0:len(control_points[y]) - 1])
                color((x % xorder == 0) ? [1.0, 0.5, 0.5] : [0.5, 0.5, 1.0])
                    display_control_line(control_points[y][x], control_points[y + 1][x], radius / 2);
    }
}

// Creates a polygon made out of BSP curves.
// If the order is 3, then the format is something like:
// [ endpont1, endpoint1 + direction, endpoint2 + direction,
//   endpoint2, endpoint2 + direction, endpoint1 + direction,
//   endpoint1 ]
// (Each direction can be different of course.)
// Note that the first point is repeated at the end to close the loop.
// Subdivisions is a power of two between 4 and 1024, the bigger, the more
// vertices the polygon will have, which makes it smoother, but takes more time to process.
// If control_point_size is greater than zero, all the control points will be drawn so that
// you can see them. Just make sure to set it back to zero before you export to stl. :)
// len(control_points) should be N * order + 1
// Currently, orders up to 5 are supported.
module bezier_polygon(
    control_points,
    order = 3,
    subdivisions = 128,
    control_point_size = 0.0
) {
    display_control_points1d(control_points, order, control_point_size);
    polygon(
        points=bezier_1d_mesh([control_points, order], subdivisions),
        paths=[bezier_1d_paths(subdivisions)], convexity=10
    );
}

// Similar to bezier polygon, but takes an array of array of control points.
// The top and bottom of the "cylinder" will be capped with a polygon.
// Cylinder is a topological term here, this function could be used to
// generate almost any shape that has two flat ends. This includes cups,
// plates, yoyos, coke bottles, you name it.
// len(control_points) should be N * yorder + 1
// len(control_points[*]) should be N * xorder + 1
// subdivisions is a power of two from 4 to 128, note that this function will
// generate roughly subdivisions * subdivisions number of polygons.
// Currently, orders up to 5 are supported.
module bezier_cylinder(
    control_points,
    xorder = 3,
    yorder = 3,
    subdivisions = 128,
    control_point_size = 0.0
) {
    display_control_points2d(control_points, xorder, yorder, control_point_size);
    polyhedron(
        points=bezier_2d_mesh(
            [control_points, xorder, yorder],
            subdivisions
        ),
        faces=bezier_2d_cylinder_triangles(subdivisions)
    );
}

// Similar to bezier cylinder, but instead of capping the top and bottom
// with polygons, the top and bottom are assumed to join together in a loop,
// which forms a donut shape. Almost any shape with a single hole can be
// generated with this function. This includes, but is not limited to:
// CDs, rings, nuts and the letter R.
// len(control_points) should be N * yorder + 1
// len(control_points[*]) should be N * xorder + 1
// subdivisions is a power of two from 4 to 128, note that this function will
// generate roughly subdivisions * subdivisions number of polygons.
// Currently, orders up to 5 are supported.
module bezier_torus(
    control_points,
    xorder = 3,
    yorder = 3,
    subdivisions = 128,
    control_point_size = 0.0
) {
    display_control_points2d(control_points, xorder, yorder, control_point_size);
    polyhedron(
        points=bezier_2d_mesh(
            [control_points, xorder, yorder],
            subdivisions
        ),
        faces=bezier_2d_torus_triangles(subdivisions)
    );
}
