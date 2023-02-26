use <../libs/catchnhole/catchnhole.scad>;
$fn=100;
//hdd params
t=25.6;
w=101.8;
l=146.2;

//hole spacing starting from IO side
top_holes = [41, 85.5];
t_e=2.7; // distance from closest edge

side_holes = [28.5, 69.5, 129.1];
s_e=6;

//cage params
lh=0.48;
ct=lh*7;
gap=5;

//color("green")
//cube([w,l,t]);

module _plate() {
    translate([-ct,0,0])
    difference() {
        cube([w+ct*2, l, ct]);
        for (i=[0:len(top_holes)-1]) {
            translate([ct+t_e,top_holes[i],0])
            cylinder(r=1.75, h=ct);
        }
        for (i=[0:len(top_holes)-1]) {
            translate([w-ct+t_e,top_holes[i],0])
            cylinder(r=1.75, h=ct);
        }
    }
}

module plate() {
    difference() {
        _plate();
        linear_extrude(height=ct)
        offset(delta=-20)
        projection()
        _plate();
    }
}

module side(h) {
    translate([-ct,0,0])
    difference() {
        cube([ct, l, h]);
        for (i=[0:len(side_holes)-1]) {
            translate([0,side_holes[i],ct+s_e])
            rotate([0,90,0])
            cylinder(r=1.75, h=ct);
        }
    }
}

module cage() {
    //bottom
    translate([0,0,-ct])
    plate();
    //top
    translate([0,0,t+gap])
    plate();

    //bottom
    side(h=t+gap);
    translate([w+ct,0,0])
    side(h=t+gap);
    //top
    translate([0,0,t+gap])
    side(h=ct+s_e+1.75*3);
    translate([w+ct,0,t+gap])
    side(h=ct+s_e+1.75*3);
}

//fit test
translate([0,0,-ct])
plate();
translate([0,0,0])
side(h=ct+s_e+1.75*3);
translate([w+ct,0,0])
side(h=ct+s_e+1.75*3);
