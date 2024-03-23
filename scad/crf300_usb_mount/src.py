from dataclasses import dataclass

from solid import cylinder, scad_render_to_file, hole, cube, rotate, translate, hull, sphere, mirror, square
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
    clearance: int = 6
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

    def chamfer(self, obj):
        return (
            self._obj() - (
                # top short edge
                forward(self.thick/2)(rotate(45, [-1, 0, 0])(self._obj())) +
                # bottom short edge
                forward(self.thick)(up(self.height - self.thick/2)(
                    rotate(45, [1, 0, 0])(self._obj()))
                )
                # left (facing y+) long edge
            )
        )

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

    def chamfer(self, obj):
        return (
            self._obj() - (
                # top short edge
                forward(self.thick/2)(rotate(45, [-1, 0, 0])(self._obj())) +
                # bottom short edge
                forward(self.thick)(up(self.height - self.thick/2)(
                    rotate(45, [1, 0, 0])(self._obj()))
                )
                # left (facing y+) long edge
            )
        )

    def pos(self, obj):
        return down(self.height - self.um_thick)(forward(self.um_length)(left(self.width/2)(obj)))

    def obj(self):
        return self.pos(self._obj())


@dataclass
class LowerBody:
    length: int = 55
    width: int = 34
    thick: int = 10
    spine_height: int = 70
    spine_thick: int = 10
    um_length: int = 10
    hole_offset: int = 10

    def _obj(self):
        return (
            cube([self.width, self.length + self.spine_thick, self.thick]) -
            forward(self.hole_offset)(right(self.width/2)(cylinder(r=2.5, h=self.thick)))
        )

    def pos(self, obj):
        return back(31)(left(self.width/2)(down(self.spine_height)(obj)))

    def obj(self):
        return self.pos(self._obj())


ring = Ring(thick=7)
um = UpperBody(thick=ring.height, width=ring.outerd)
spine = Spine(width=ring.outerd/2, um_length=um.length, um_thick=um.thick)
spine_connector = SpineConnector(width=ring.outerd/2, um_length=um.length, um_thick=um.thick)
lb = LowerBody(width=ring.outerd/2, spine_height=spine.height, spine_thick=spine.thick)

render = [
    ring.obj(),
    hull()(
        um.obj(),
        spine_connector.obj(),
    ),
    spine.obj(),
    lb.obj()
]

scad_render_to_file(sum(render), 'test.scad', file_header='$fn = 128;')
