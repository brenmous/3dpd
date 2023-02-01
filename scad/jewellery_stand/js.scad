$fn=100;
base_length=80;
base_width=150;
base_height=12;
base_thickness=3;
//module base() {
//    translate([0, base_width/2, base_r])
//    rotate([90,0,0])
//    cylinder(h=base_width, r=base_r);
//    translate([-base_r,-base_width/2,0])
//    cube([base_r*2,base_width, base_r]);
//}
//base();

module base() {
    translate([-base_length/2, -base_width/2,0])
    cube([base_length, base_width, base_thickness]);
}

module lip() {
    difference() {
        offset(r=3)
        projection()
        base();
        projection()
        base();
    }
}

module solid_tray() {
    hull() {
        base();
        translate([0,0,base_height])
        linear_extrude(height=1)
        lip();
    }
}

module hollowed_tray() {
    difference() {
        solid_tray();
        translate([0,0,base_thickness])
        scale([0.92,0.95,1.1])
        solid_tray();
    }
}

hollowed_tray();

neck_height=160;
neck_r=7;
module neck() {
    cylinder(h=neck_height, r=neck_r);
}
neck();

tbar_width=140;
tbar_r=7;
module tbar() {
    translate([0, tbar_width/2, neck_height])
    rotate([90,0,0])
    cylinder(h=tbar_width, r=tbar_r);
    translate([-tbar_r,-tbar_width/2,neck_height])
    cube([tbar_r*2,tbar_width, tbar_r]);
}
tbar();
