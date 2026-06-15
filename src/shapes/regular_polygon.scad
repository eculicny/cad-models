module regular_polygon(n = 4, r = 1) {
    angles = [for (i = [0:n - 1]) i * (360 / n)];
    coords = [for (th = angles) [r * sin(th), r * cos(th)]];
    polygon(coords);
}
