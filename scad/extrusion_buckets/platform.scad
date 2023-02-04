use <hook.scad>;

pb_length = 73;
pb_width = 50;
hook_width = 20;
hook_thickness = 5;
hook_tail = 55;
base_thickness = 5;

difference() {
    union() {
        translate([-pb_length/2+hook_thickness+1,pb_width/2-hook_width/2,hook_tail])
        bucket_hook(hook_width, hook_thickness, hook_tail);
        cube([pb_length+hook_thickness, pb_width, base_thickness]);
    }

    hex_radius=5;
    color("red")
    for (i=[0.3:3:3*18]) {
        for (j=[0.5:3:3*6]) {
            translate([hook_thickness+hex_radius+(hex_radius/1.3*j),hex_radius+(hex_radius/1.2*i),0])
            cylinder(r=hex_radius,h=5,$fn=6);
        }
    }
}
