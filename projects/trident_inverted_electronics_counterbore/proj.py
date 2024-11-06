from build123d import *

importer = Mesher()
og = importer.read("Inverted_DIN_Mount_x2.stl")[0]

with BuildPart() as obj:
    add(og)
    with BuildSketch(obj.faces().sort_by(Axis.Z)[0]) as face:
        with Locations([(29.43, 33.4), (29.43, -14.6)]):
            Circle(radius=4.25)
    extrude(amount=-5.2, mode=Mode.SUBTRACT)

log(obj.part.show_topology(limit_class="Solid", show_center=False))

show_object(obj.part)

exporter = Mesher()
exporter.add_shape(obj.part)
exporter.write("output.stl")
