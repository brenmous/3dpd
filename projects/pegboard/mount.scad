thickness=3;
length=30;
width=20;
$fn=100;
module face() {
    difference() {
        linear_extrude(height=thickness)
        square([length, width]);
        translate([20, width/2])
        cylinder(r=2.5, h=thickness);
    }
}

translate([0,0,thickness])
rotate([0,-90,0])
face();
face();
translate([-thickness, 0, 0])
cube([thickness, width, thickness]);
