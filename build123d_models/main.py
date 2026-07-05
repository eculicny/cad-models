from build123d import * #Rectangle, Align, export_stl, extrude, CM, MM, fillet
from ocp_vscode import *


def main():
    print("Hello from build123d-models!")


if __name__ == "__main__":
    main()
    # Algebra mode
    # profile = Rectangle(3 * CM, 4 * MM, align=Align.MIN)
    # profile += Rectangle(4 * MM, 3 * CM, align=Align.MIN)
    # angle_iron = extrude(profile, 10 * CM)
    # angle_iron = fillet(angle_iron.edges().filter_by(lambda e: e.is_interior), 5 * MM)
    # export_stl(angle_iron, "angle_iron.stl")

    ex2 = Cylinder(2.5*IN / 2, height=5*IN)
    ex2 -= Cylinder(2.25*IN / 2, height=5*IN)
    export_stl(ex2, "cylinder.stl")
    print("Done")
