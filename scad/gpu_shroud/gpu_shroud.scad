//minkowski() {
//    difference() {
//        cube([138, 53, 1.5]);
//        union() {
//            translate([6.25, 6.25, 0])
//            screw_hole();
//            translate([138 - 6.25, 6.25, 0])
//            screw_hole();
//        }
//    }
//    cylinder(r=1, h=0.01, $fn=24);
//}

$fn=100;
module screw_hole(height) {
    color("black")
    cylinder(r=5/2, h=height+1);

    color("red")
    translate([0, 0, 1])
    cylinder(r=8/2, h=height);
}
//screw_hole(10);

//difference() {
//    cube([138, 53, 1.5]);
//    union() {
//        translate([6.25, 6.25, 0])
//        screw_hole();
//        translate([138 - 6.25, 6.25, 0])
//        screw_hole();
//    }
//}
l = 45;
w = 138;
h = 37;
t = 1.5;

hyp = sqrt(pow(l,2) + pow(h,2));

module prism() {
    hull() {
        cube([w, l, t]);

        rotate([acos(l/hyp),0,0])
        cube([1,hyp,t]);

        rotate([acos(l/hyp),0,0])
        translate([w-1,0,0])
        cube([1,hyp,t]);
    }
}

module hollowed(left=false) {
    difference() {
        prism();
        if (left) {
            translate([t,1,-1])
            scale([1,1,1])
            prism();
        } else {
            translate([-t,1,-1])
            scale([1,1,1])
            prism();
        }
    }
}


module shroud(left=false) {
    difference() {
        union() {
            hollowed(left);
            hull() {
                intersection() {
                    hollowed(left);
                    cube([12,12,12]);
                }
                cube([12,12,1]);
            }
            hull() {
                intersection() {
                    hollowed(left);
                    translate([w - 12, 0, 0])
                    cube([12,12,12]);
                }
                translate([w - 12, 0, 0])
                cube([12,12,1]);
            }
        }
        translate([6.25, 6.25, 0])
        screw_hole(12);
        translate([w - 6.25, 6.25, 0])
        screw_hole(12);
    }
}

module left_shroud() {
    shroud(true);
    translate([0,l,0])
    cube([1.5, 9, h-4]);
}

_w = w - 80;
_ww = w - _w;
_h = h - 16;
_hh = h - _h;
_l = l - 20;
_ll = l - _l;
_hyp = sqrt(pow(_ll, 2) + pow(_hh, 2));


module _right_shroud() {
    difference() {
        union() {
            shroud(false);
            translate([w-t,l,0])
            cube([t, 9, h-4]);
        }

        color("red")
        translate([_ww,_l,_h])
        cube([_w, 30, 22]);
    }
}


module right_shroud() {
    translate([_ww,_l,_h])
    cube([_w,_ll, t]);


    hull() {
        intersection() {
            translate([_ww-t,_l,_h])
            cube([t,_l,_h]);
            _right_shroud();
        }
        translate([_ww-t,_l,_h])
        cube([t,_ll, t]);
    }
    _right_shroud();
}

//left_shroud();
//translate([w,0,0])
right_shroud();
