$fn=128;
difference() {
    cylinder(r=5, h=4);
    union() {
        cylinder(r=3, h=4);
        translate([0,1,0])
        cube([5, 5, 4]);
    }
}

color("blue")
translate([3.8,-5,-5 + 2])
cube([2, 10, 10]);
