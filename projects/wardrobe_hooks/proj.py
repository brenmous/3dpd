from build123d import *


# def locsym(location, l=1) -> Compound:
#    return Compound.make_triad(axes_scale=l).locate(location)


# b = Box(1, 2, 3)
# c = Cylinder(0.2, 5)

# thing = Plane.XY * Pos(10, 1, 0) * Box(1, 2, 3)
# show_object(location_symbol(), thing)
# print(type(thing))
# print(thing.__dict__)

# loc = Location((0.1, 0.2, 0.3), (10, 20, 30))
# face = loc * Rectangle(1, 2)
# show_object(face, name="face")
# show_object(locsym(loc), name="loc")

# show_object(Plane.XZ * Pos(1, 2, 3) * Box(1, 2, 3))

# ex2 = Plane.XY * Box(10, 10, 10)
# ex2 -= Plane.XZ * Cylinder(5, height=10)
# show_object(ex2)

# l, w, t = 80, 60, 10
#
# lines = Curve() + [
#    Line((0, 0), (l, 0)),
#    Line((l, 0), (l, w)),
#    ThreePointArc((l, w), (w, w * 1.5), (0, w)),
#    Line((0, w), (0, 0)),
# ]
#
# face = make_face(lines)
# obj = extrude(face, 10)
# show_object(obj)

# lines = Curve() + [Spline((0, 0), (5, 5), (10, 0), (15, 5))]
# face = make_face(lines)
# show_object(face)

# lines = Curve() + [Line((0, 0), (0, 10)), SagittaArc((0, 0), (0, 10), 5)]
# face = make_face(lines)
# lines2 = Curve() + [SagittaArc((1, 0), (1, 10), 5)]
# face2 = make_face(lines2)
# face -= face2
# show_object(face)
# obj = extrude(face, 10)
# show_object(obj)


# circle = Plane.XZ * Circle(1)
# show_object(circle)
# lines = [Line((0, 0), (0, 10)), SagittaArc((0, 0), (0, 10), 5)]
# sweep(circle, lines)

l = JernArc((0, 0), (1, 0), 50, -180) + JernArc((0, 0), (-1, 0), 30, 110)
s = Rectangle(10, 10)
s = fillet(s, 0.5)
p = sweep((l ^ 0) * s, l)
# show_object(p)

l2 = mirror(mirror(l, Plane.XZ.offset(100)), Plane.YZ)
s2 = Rectangle(10, 10)
p2 = sweep((l2 ^ 0) * s2, l2)
# show_object(p2)

circle = Pos(-56, -180, -5) * Circle(15)
circle -= Pos(-56, -180, -5) * Circle(7.5)
circle = extrude(circle, 10)
# show_object(circle)


obj = Compound([p, p2, circle])
# edges = obj.edges().filter_by(Axis.Y)
edges = obj.edges().filter_by(GeomType.)
show_object(obj)
# export_stl(obj, "test.stl"):wqa

