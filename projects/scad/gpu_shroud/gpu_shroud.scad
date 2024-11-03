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
    cylinder(r=5/2, h=height+0.96);

    color("red")
    translate([0, 0, 0.96])
    cylinder(r=8/2, h=height);
}

l = 56;
w = 140;
//h = 32.5;
t = 2.24;


module base() {
    linear_extrude(height=t) {
        hull() {
            color("blue")
            translate([8, 8])
            circle(r=8);

            color("blue")
            translate([w-8, 8])
            circle(r=8);

            color("blue")
            translate([0,l-5])
            square([5,5]);

            color("blue")
            translate([w-5,l-5])
            square([5,5]);
        }
    }
}

difference() {
    base();
    union() {
        translate([7.25, 7.25, 0])
        screw_hole(12);
        translate([w - 7.25, 7.25, 0])
        screw_hole(12);
    }
}

// angled
//hyp = sqrt(pow(l,2) + pow(h,2));
//
//module prism() {
//    hull() {
//        cube([w, l, t]);
//
//        rotate([acos(l/hyp),0,0])
//        cube([1,hyp,t]);
//
//        rotate([acos(l/hyp),0,0])
//        translate([w-1,0,0])
//        cube([1,hyp,t]);
//    }
//}
//
//module hollowed() {
//    difference() {
//        prism();
//        translate([t,1,-1])
//        scale([0.98,1,1])
//        prism();
//    }
//}
//
//
//module shroud() {
//    difference() {
//        union() {
//            hollowed();
//            hull() {
//                intersection() {
//                    hollowed();
//                    cube([12,12,12]);
//                }
//                cube([12,12,1]);
//            }
//            hull() {
//                intersection() {
//                    hollowed();
//                    translate([w - 12, 0, 0])
//                    cube([12,12,12]);
//                }
//                translate([w - 12, 0, 0])
//                cube([12,12,1]);
//            }
//        }
//        translate([6.25, 6.25, 0])
//        screw_hole(12);
//        translate([w - 6.25, 6.25, 0])
//        screw_hole(12);
//    }
//}
//
//module left_shroud() {
//    shroud();
//    translate([0,l - 1,0])
//    cube([1.5, 9 + 1, h]);
//}
//
//
//module hergh() {
//    difference() {
//        left_shroud();
//        color("red")
//        translate([w-10, l-3, h-3])
//        cube([10-t+.3, 3, 10]);
//    }
//
//    color("red")
//    translate([w-10, l-3, h-3-1.5])
//    cube([10, 3, 1.5]);
//
//    color("red")
//    translate([w-10, l-4.5, h-3-1.5])
//    cube([10, 1.5, 3]);
//
//
//
//    hull() {
//        intersection() {
//            left_shroud();
//            color("red")
//            translate([w-10-1.5, l-4.5, h-3-1.5])
//            cube([1.5, 4.5, 5]);
//        }
//
//        color("blue")
//        translate([w-10-1.5, l-4.5, h-3-1.5])
//        cube([1.5, 4.5, 1.5]);
//    }
//}
//
//translate([-1,0,0])
//intersection() {
//    hergh();
//    color("blue")
//    translate([w-1.3, l-4.5, h-3-1.5])
//    cube([1.4, 6, 6]);
//}
//hergh();
//
//
////l = 45;
////h = 37;
//_w = w - 80;
//_ww = w - _w;
//_h = h - 16 + 4.5;
//_hh = h - _h;
//_l = l - 20 - 2.5;
//_ll = l - _l;
//_hyp = sqrt(pow(_ll, 2) + pow(_hh, 2));
//
//
//module _right_shroud() {
//    difference() {
//        union() {
//            shroud();
//            translate([w-t+.24,l - 1,0])
//            cube([t-.24, 9+1, h+1]);
//        }
//
//        translate([_ww,_l,_h])
//        cube([_w, 35, 22]);
//    }
//}
//
//
//module right_shroud() {
//    translate([_ww-1.5,_l+3,_h-1.5])
//    cube([_w+1.5,_ll-3, t]);
//
//    hull() {
//        intersection() {
//            translate([_ww-t,_l+3,_h-1.5])
//            cube([t,_l-3,_h]);
//            _right_shroud();
//        }
//        translate([_ww-t,_l+3,_h-1.5])
//        cube([t,_ll-3, t]);
//    }
//    _right_shroud();
//}
//
////left_shroud();
////translate([w,0,0])
////right_shroud();
