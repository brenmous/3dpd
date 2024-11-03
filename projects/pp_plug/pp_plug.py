import cadquery as cq

wp = cq.Workplane().circle(22.5/2).extrude(0.32*6)
wp = wp.faces(">Z").circle(18.9/2).extrude(16,taper=-3.8)
diameter = wp.faces(">Z").combine().objects[0].BoundingBox()
wp = wp.faces(">Z").circle((diameter.xmax - diameter.xmin) / 2).extrude(12.6, taper=6)
diameter = wp.faces(">Z").combine().objects[0].BoundingBox()
log(diameter.xmax - diameter.xmin)
