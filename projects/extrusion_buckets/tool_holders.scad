use <hook.scad>;

extrusion_p=25.8;

module soldering() {
    hook_width=70;
    hook_thickness=5;
    hook_height=0;

    translate([-hook_thickness,0,0])
    bucket_hook(hook_width, hook_thickness, hook_height);

    spool_id=21;
    spool_od=49;
    spool_h=41;

    translate([-extrusion_p/2,hook_width/2,extrusion_p])
    cylinder(r=spool_id * 0.6 / 2, h=spool_h+5, $fn=100);

    iron_d=13.55;
    iron_t=3;
    difference() {
    //outer
        union() {
            translate([iron_d+iron_t,(iron_d+iron_t)/2,0])
            cylinder(r=(iron_d+iron_t)/2, h=10,$fn=100);
            translate([0,0,0])
            cube([iron_d+iron_t,iron_d+iron_t,10]);
        }

        translate([iron_d+iron_t,(iron_d+iron_t)/2,0])
        cylinder(r=iron_d/2, h=10,$fn=100);
    }

    pump_d=21;
    pump_t=3;

    translate([0,-1,0])
    difference() {
        union() {
            translate([pump_d+pump_t,hook_width/2,0])
            cylinder(r=(pump_d+pump_t)/2, h=10, $fn=100);

            translate([0,hook_width/2-(pump_d+pump_t)/2,0])
            cube([pump_d+pump_t,pump_d+pump_t,10]);
        }
        translate([pump_d+pump_t,hook_width/2,0])
        cylinder(r=pump_d/2, h=10, $fn=100);
    }

    pen_d=15.5;
    pen_t=3;

    difference() {
        union() {
            translate([pen_d+pen_t,hook_width-(pen_d+pen_t)/2,0])
            cylinder(r=(pen_d+pen_t)/2, h=10, $fn=100);

            translate([0,hook_width-(pen_d+pen_t),0])
            cube([pen_d+pen_t,pen_d+pen_t,10]);
        }
        translate([pen_d+pen_t,hook_width-(pen_d+pen_t)/2,0])
        cylinder(r=pen_d/2, h=10, $fn=100);
    }
}

module tool_holder(d=15, t=3, h=10) {
    hook_width=d+t;
    hook_thickness=5;
    hook_height=0;

    translate([-hook_thickness,0,0])
    bucket_hook(hook_width, hook_thickness, hook_height);

    difference() {
        union() {
            translate([d+t,(d+t)/2,0])
            cylinder(r=(d+t)/2, h=h,$fn=100);
            translate([0,0,0])
            cube([d+t,d+t,h]);
        }

        translate([d+t,(d+t)/2,0])
        cylinder(r=d/2, h=h,$fn=100);
    }
}

module tool_hook(l=22, t=3.5, h=5) {
    hook_width=t*3;
    hook_thickness=5;
    hook_height=0;

    translate([-hook_thickness,0,0])
    bucket_hook(hook_width, hook_thickness, hook_height);

    translate([0,t,0])
    cube([l,t,h]);

    translate([l-t,t,h])
    cube([t,t,h]);

}

tool_hook();
