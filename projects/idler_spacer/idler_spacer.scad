$fn=100;
translate([0,0,3])
difference() {
    cylinder(r=2.5, h=10);
    cylinder(r=2.3, h=10);
}
translate([-2.5,-2.5,0])
cube([5,5,3]);
