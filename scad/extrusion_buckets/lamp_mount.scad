use <hook.scad>;
use <../libs/catchnhole/catchnhole.scad>;

hook_width=50;
hook_thickness=5;
hook_height=0;
xoffset=53;




difference() {
    union() {
        bucket_hook(hook_width, hook_thickness, hook_height);
        linear_extrude(height=(25.8+hook_thickness))
        offset(r=5, $fn=100)
        projection()
        translate([21.43+xoffset,hook_width/2,0])
        cylinder($fn=3, r=23.1, h=1);
        translate([hook_thickness,0,0])
        cube([xoffset+5,hook_width,25.8+hook_thickness]);
    }

    color("red")
    translate([43.6+xoffset-6,hook_width/2,(25.8+hook_thickness)-21])
    cylinder($fn=100, r=8/2, h=21);
    translate([43.6+xoffset,hook_width/2,(25.8+hook_thickness)-21+11])

    color("yellow")
    rotate([0,90,0])
    bolt("M4", 6, $fn=100);

    translate([-3,0,0])
    color("red")
    linear_extrude(25.8+hook_thickness)
    offset(r=-12)
    projection()
    union() {
        linear_extrude(height=(25.8+hook_thickness))
        offset(r=5, $fn=100)
        projection()
        translate([21.43+xoffset,hook_width/2,0])
        cylinder($fn=3, r=23.1, h=1);
        translate([hook_thickness,0,0])
        cube([xoffset+5,hook_width,25.8+hook_thickness]);
    }
}
////}
//
//    offset = 1.5;
//    color("red")
//    translate([15+offset,hook_width/2,0])
//    rotate([0,0,0])
//    cylinder($fn=3, r=8, h=25.8+hook_thickness);
//
//    color("red")
//    translate([27.5+offset,hook_width/4,0])
//    rotate([0,0,180])
//    cylinder($fn=3, r=8, h=25.8+hook_thickness);
//
//    color("red")
//    translate([27.5+offset,hook_width/4*3,0])
//    rotate([0,0,180])
//    cylinder($fn=3, r=8, h=25.8+hook_thickness);
//
//    color("red")
//    translate([47.5-offset,hook_width/4,0])
//    cylinder($fn=3, r=8, h=25.8+hook_thickness);
//
//    color("red")
//    translate([47.5-offset,hook_width/4*3,0])
//    cylinder($fn=3, r=8, h=25.8+hook_thickness);
//
//    color("red")
//    translate([60-offset,hook_width/2,0])
//    rotate([0,0,180])
//    cylinder($fn=3, r=8, h=25.8+hook_thickness);
//
//}
