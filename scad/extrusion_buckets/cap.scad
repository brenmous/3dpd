use <../libs/catchnhole/catchnhole.scad>;

bolt_l = 20;
extrusion_ip = 22.8;
cap_p = extrusion_ip - 0.05;
cap_eh = 2;
cap_ih = bolt_l - cap_eh;
extrusion_t = 1.4;
lip_w = extrusion_t + extrusion_ip - cap_p;

difference() {
    union() {
        translate([2,2,0])
        linear_extrude(height=cap_ih)
        offset(delta=2, chamfer=true)
        projection()
        cube([cap_p-4,cap_p-4,1]);
        translate([-lip_w/2,-lip_w/2,cap_ih])
        cube([cap_p+lip_w,cap_p+lip_w,cap_eh]);
    }
    translate([cap_p/2, cap_p/2,0])
    bolt("M5", 20, $fn=100, kind="headless");
}
