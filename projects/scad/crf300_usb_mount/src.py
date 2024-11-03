from dataclasses import dataclass

from solid import cylinder, scad_render_to_file, hole, cube, rotate, translate, hull, sphere, mirror, square, intersection
from solid.utils import left, right, forward, back, up, down, BACK_VEC, FORWARD_VEC, fillet_2d


@dataclass
class Ring:
    innerd: int = 29
    thick: int = 5
    height: int = 10

    @property
    def outerd(self):
        return self.innerd + self.thick

    def obj(self):
        outer = cylinder(r=self.outerd/2, h=self.height)
        inner = cylinder(r=self.innerd/2, h=self.height)
        return outer - hole()(inner)


@dataclass
class UpperBody:
    clearance: int = 2
    thick: int = 10
    width: int = 34

    @property
    def length(self):
        return self.width/2 + self.clearance

    def pos(self, obj):
        return left(self.width/2)(obj)

    def obj(self):
        return self.pos(cube([self.width, self.length, self.thick]))


@dataclass
class Spine:
    height: int = 70
    width: int = 34
    thick: int = 10
    um_length: int = 50
    um_thick: int = 10

    def _obj(self):
        return cube([self.width, self.thick, self.height])

    def pos(self, obj):
        return down(self.height - self.um_thick)(forward(self.um_length)(left(self.width/2)(obj)))

    def obj(self):
        return self.pos(self._obj())


@dataclass
class SpineConnector:
    width: int = 34
    thick: int = 10
    um_length: int = 50
    um_thick: int = 10

    @property
    def height(self):
        return self.um_thick

    def _obj(self):
        return cube([self.width, self.thick, self.um_thick])

    def pos(self, obj):
        return down(self.height - self.um_thick)(forward(self.um_length)(left(self.width/2)(obj)))

    def obj(self):
        return self.pos(self._obj())


@dataclass
class LowerBody:
    length: int = 38
    width: int = 34
    thick: int = 10
    spine_height: int = 70
    spine_thick: int = 10
    um_length: int = 10
    hole_offset: int = 10

    def _obj(self):
        return (
            cube([self.width, self.length + self.spine_thick, self.thick]) -
            forward(self.hole_offset)(right(self.width/2)(cylinder(r=3, h=self.thick)))
        )

    def pos(self, obj):
        # fucked up here, eyeball it
        return back(18)(left(self.width/2)(down(self.spine_height)(obj)))

    def obj(self):
        return self.pos(self._obj())


ring = Ring(thick=7)
um = UpperBody(thick=ring.height, width=ring.outerd)
spine = Spine(width=ring.outerd/2, um_length=um.length, um_thick=um.thick)
spine_connector = SpineConnector(width=ring.outerd/2, um_length=um.length, um_thick=um.thick)
lb = LowerBody(width=ring.outerd/2, spine_height=spine.height, spine_thick=spine.thick)

main = sum([
    ring.obj(),
    hull()(
        um.obj(),
        hull()(
            spine_connector.obj(),
        )
    ),
    spine.obj(),
    lb.obj()
])

# beef up the spine connector with a chamfer underneath
beef = hull()(
    intersection()(left(ring.outerd/2)(forward(um.length)((cube([ring.outerd, spine_connector.thick, um.thick])))), main),
    down(spine_connector.height)(spine_connector.obj())
)

# add chamfers to the bottom joint
# annnnd here is where I give up on trying to be neat
chamfer_box = forward(20)(left(9)(down(70)(rotate(45, [1,0,0])(cube([18,10,10])))))
chamfer_box2 = forward(30)(left(9)(down(77.1)(rotate(45, [1,0,0])(cube([30,10,10])))))


scad_render_to_file((main + beef + chamfer_box) - chamfer_box2, 'test.scad', file_header='$fn = 128;')
