use <hook.scad>;

module bucket(
    height=30, width=60, thickness=2, depth=80, ditch=10, split=0.66,
    hook_width=60, hook_height=40, hook_thickness=5
) {
    translate([-depth/2+hook_thickness+thickness,hook_height,width])
    rotate([-90,0,0])
    bucket_hook(hook_width, hook_thickness, hook_height);
    module bucket2d() {
        h1 = depth*split/cos(ditch);
        o = sin(ditch)*h1;
        t = atan2(o,depth*(1-split));
        h2 = depth*(1-split)/cos(t);

        color("red")
        square([thickness,height]);

        rotate([0,0,-ditch])
        square([h1, thickness]);

        translate([depth*split,-o,0])
        rotate([0,0,t])
        square([h2,thickness]);

        translate([0,height,0])
        square([depth, thickness]);
        translate([depth-thickness,0,0])
        square([thickness,height]);
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

//bucket();

module bucket_flat_bottom(
    height=30, width=60, thickness=2, depth=80, ditch=40,split=0.75,
    hook_width=15, hook_height=40, hook_thickness=5
) {
    translate([-depth/2+hook_thickness+thickness,hook_height,width])
    rotate([-90,0,0])
    bucket_hook(hook_width, hook_thickness, hook_height);
    translate([-depth/2+hook_thickness+thickness,hook_height,hook_width])
    rotate([-90,0,0])
    bucket_hook(hook_width, hook_thickness, hook_height);
    module bucket2d() {
        h = depth*(1-split)/cos(ditch);
        o = tan(ditch)*depth*(1-split);
        square([thickness,height]);

        square([depth*split, thickness]);

        translate([depth*split,0,0])
        rotate([0,0,ditch])
        square([h,thickness]);

        translate([0,height,0])
        square([depth, thickness]);

        translate([depth-thickness,o,0])
        square([thickness,height-o]);
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

bucket_flat_bottom();
