use <../libs/catchnhole/catchnhole.scad>;
$fn=100;

module leg_mount() {
    difference() {
        union() {
            translate([-5,0,0])
            cube([10,7,7]);
            cylinder(r=5,h=7);
        }
        bolt("M5", length=7);
    }
}


module case_with_tenting(){
    import("original.stl");
    translate([5.7,-141.8,-29])
    rotate([0,0,60])
    color("red")
    leg_mount();

    translate([5.9,-50,-29])
    rotate([0,0,90])
    color("red")
    leg_mount();

    translate([-151.2,-52,-29])
    rotate([0,0,-90])
    color("red")
    leg_mount();

    translate([-151.2,-112,-29])
    rotate([0,0,-90])
    color("red")
    leg_mount();
}

module leg(length=20) {
    difference() {
        union() {
            cylinder(r=5, h=length);
            cylinder(r=6.5, h=5, $fn=8);
        }
        cylinder(r=5, h=2.5);
        translate([0,0,5])
        bolt("M5", length=length-5);
    }
}

case_with_tenting();
//leg(length=20);
