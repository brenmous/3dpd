use <hook.scad>;

hook_thickness = 5;
module bucket(height=40, width=60, thickness=1, depth=80, ditch=7, split=0.66, wall_height=20) {
    translate([-depth/2+hook_thickness+thickness,height,width])
    rotate([-90,0,0])
    bucket_hook(width, hook_thickness, height);
    module bucket2d() {
        h1 = depth*split/cos(ditch);
        o = sin(ditch)*h1;
        t = atan2(o,depth*(1-split));
        h2 = depth*(1-split)/cos(t);

        square([thickness,height]);

        rotate([0,0,-ditch])
        square([h1, thickness]);

        translate([depth*split,-o,0])
        rotate([0,0,t])
        square([h2,thickness]);

        translate([0,wall_height,0])
        square([depth, thickness]);
        translate([depth-thickness,0,0])
        square([thickness,wall_height]);
    }
    difference() {
        linear_extrude(height=width)
        fill()
        bucket2d();
        translate([thickness,thickness,thickness])
        linear_extrude(height=width-thickness*2)
        offset(delta=-1)
        fill()
        bucket2d();
    }
}

bucket();
