use <../libs/catchnhole/catchnhole.scad>;

$fn=100;
base_length=80;
base_width=150;
base_height=12;
base_thickness=3;
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
        scale([0.9,0.94,1.1])
        solid_tray();
        translate([0,0,20])
        rotate([0,180,0])
        bolt("M4", 20, kind="countersunk");
    }
}

hollowed_tray();

neck_height=160;
neck_r=7;
module neck() {
    difference() {
        cylinder(h=neck_height, r=neck_r);
        translate([0,0,20])
        rotate([0,180,0])
        bolt("M4", 20, kind="countersunk");
    }
}

neck();

module neck_holder() {
    difference() {
        cylinder(h=neck_height/6, r=neck_r*1.2);
        cylinder(h=neck_height, r=neck_r*1.02);
    }
}

neck_holder();

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
