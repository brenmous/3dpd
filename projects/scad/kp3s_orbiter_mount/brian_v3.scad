use <../libs/catchnhole/catchnhole.scad>;

$fn=64;
module master_front() {
    difference() { 
        import ("/home/bren/3dpd_old/kp3s_mods/orbiter_mount_brian/ez_prnt_print_head_front.stl");

        union() {
            color("red")
            translate([-48.9, 77.05, 19.5])
            rotate([90,0,0])
            cylinder(r=8.1, h=6, $fn=100);

            color("red")
            translate([-48.9, 65.55, 19.5])
            rotate([90,0,0])
            cylinder(r=8.1, h=3.5, $fn=100);

            color("red")
            translate([-48.9, 71.3, 19.5])
            rotate([90,0,0])
            cylinder(r=6.1, h=6, $fn=100);
        }
    }
}

module master() {
    difference() { 
        import ("/home/bren/3dpd_old/kp3s_mods/orbiter_mount_brian/ez_prnt_print_head_back_with_blt.stl");
    
        union() {
            color("red")
            translate([-48.9, 77.05, 19.5])
            rotate([90,0,0])
            cylinder(r=8.1, h=6, $fn=100);
    
            color("red")
            translate([-48.9, 65.55, 19.5])
            rotate([90,0,0])
            cylinder(r=8.1, h=3.5, $fn=100);
    
            color("red")
            translate([-48.9, 71.3, 19.5])
            rotate([90,0,0])
            cylinder(r=6.1, h=6, $fn=100);
        }
    }
}

// extend the back to support the offset mount
module mount_extension() {
    $fn=16;
    difference() {
        // flat part of the extension
        translate([-93,31,-3.588])
        linear_extrude(height=3.5-0.022)
        union() {
            offset(r=1)
            square(size=[20,42]);
            //square(size=[20,23]);
        }

  
        color("blue")
        translate([-95.1,64,-3.588])
        rotate([0,0,-45])
        linear_extrude(height=3.5-0.022)
        union() {
            offset(r=1)
            square(size=[20,42], center=true);
            //square(size=[20,23]);
        }
    }
    // chamfered attachment to "main" body
    //difference() {
    //    translate([-93,55.2,-3.588])
    //    linear_extrude(height=3.5-0.022)
    //    union() {
    //        offset(r=1)
    //        square(size=[20,18]);
    //    }
    //    for (i=[0:100]) {
    //        color("red")
    //        translate([-113.8+i/5,55.2+i/5,-3.588])
    //        linear_extrude(height=3.5-0.022)
    //        union() {
    //            offset(r=1)
    //            square(size=[20,18]);
    //        }
    //    }
    //    color("red")
    //    translate([-113.8+40,55.2+18,-3.588])
    //    cube([5,5,5]);
    //}


    // raised bottom part
    translate([-93,25,-3.588])
    linear_extrude(height=6-0.022)
    union() {
        offset(r=1)
        square(size=[20,7.8]);
    }
}

mount_yoffset = 20;
// mark where the new mounts should go
module mount_markers() {
    translate([-63.9 - mount_yoffset,47.725,0])
    color("red")
    rotate([0,0,90])
    cylinder(r=1.5, h=1, $fn=100);

    translate([-48.9 - mount_yoffset,47.725,0])
    color("red")
    rotate([0,0,90])
    cylinder(r=1.5, h=10, $fn=100);

    translate([-48.9 - mount_yoffset,27.725,0])
    color("red")
    rotate([0,0,90])
    cylinder(r=1.5, h=10, $fn=100);

    translate([-63.9 - mount_yoffset,27.725,0])
    color("red")
    rotate([0,0,90])
    cylinder(r=1.5, h=10, $fn=100);
}

// fill the old mounting holes
module fill_old_mounts() {
    hull()
    intersection() {
        translate([-63.9,47.725,-5])
        color("red")
        rotate([0,0,90])
        cylinder(r=4.2, h=15, $fn=100);
        master();
    }

    hull()
    intersection() {
        translate([-48.9,47.725,-5])
        color("red")
        rotate([0,0,90])
        cylinder(r=4.2, h=15, $fn=100);
        master();
    }

    hull()
    intersection() {
        translate([-48.9,27.725,-5])
        color("red")
        rotate([0,0,90])
        cylinder(r=4.2, h=15, $fn=100);
        master();
    }

    hull()
    intersection() {
        translate([-63.9,27.725,-5])
        color("red")
        rotate([0,0,90])
        cylinder(r=4.2, h=15, $fn=100);
        master();
    }
}

module new_master() {
    master();
    fill_old_mounts();
    mount_extension();
}

// offset mounting holes
// change countersunk to false if you would prefer buttonhead
module new_mounts(countersunk=true) {
    difference() {
        difference() {
            new_master();
            translate([-63.9 - mount_yoffset,47.725,-5])
            bolt("M3", 5, kind=countersunk ? "countersunk" : "headless", $fn=100);
            translate([-48.9 - mount_yoffset,47.725,-5])
            bolt("M3", 5, kind=countersunk ? "countersunk" : "headless", $fn=100);
            translate([-48.9 - mount_yoffset,27.725,-4.5])
            bolt("M3", 7, kind=countersunk ? "countersunk" : "headless", $fn=100);
            translate([-63.9 - mount_yoffset,27.725,-4.5])
            bolt("M3", 7, kind=countersunk ? "countersunk" : "headless", $fn=100);
        }
        translate([-48.9 - mount_yoffset,47.725,0])
        rotate([0,0,90])
        cylinder(r=3.2, h=5, $fn=100);
        if (!countersunk) {
            translate([-63.9 - mount_yoffset,47.725,-1.9])
            rotate([0,0,90])
            cylinder(r=3.2, h=5, $fn=100);
            translate([-63.9 - mount_yoffset,27.725,0.7])
            rotate([0,0,90])
            cylinder(r=3.2, h=5, $fn=100);
            translate([-48.9 - mount_yoffset,27.725,0.7])
            rotate([0,0,90])
            cylinder(r=3.2, h=5, $fn=100);
        }
    }
}

// increase diameter of the bolt holes in back
module new_bolts() {
    difference() {
        new_mounts();

        // hotend collar
        translate([-59, 68.2, -5])
        bolt("M3", 25, $fn=100);
        translate([-39.8, 68.2, -5])
        bolt("M3", 25, $fn=100);

        // endstop
        translate([-57, 20, -5])
        bolt("M3", 25, $fn=100);

        // extruder
        rotate([90,0,0])
        translate([-34.6, 9.4, -92])
        bolt("M3", 25, $fn=100);

        // fan
        translate([-90, 69.6, 3.4])
        rotate([0,90,0])
        bolt("M3", 25, $fn=100);
        translate([-90, 37.8, 3.4])
        rotate([0,90,0])
        bolt("M3", 25, $fn=100);
    }
}

module new_back() {
    new_bolts();
}

// increase diameter of the bolt holes in front
module new_bolts_front() {
    difference() {
        master_front();

        // fan
        translate([-90, 69.6, 35.3])
        rotate([0,90,0])
        bolt("M3", 25, $fn=100);
        translate([-90, 37.8, 35.3])
        rotate([0,90,0])
        bolt("M3", 25, $fn=100);

        // hotend collar
        translate([-59, 68.2, 15])
        bolt("M3", 25, $fn=100);
        translate([-39.8, 68.2, 15])
        bolt("M3", 25, $fn=100);

        // blower
        translate([-25.6, 64.3, 33])
        bolt("M3", 25, $fn=100);
        translate([-25.6, 49.3, 33])
        bolt("M3", 25, $fn=100);

        // extruder
        rotate([90,0,0])
        translate([-65, 30.6, -92])
        bolt("M3", 25, $fn=100);


    }
}

module new_front() {
    new_bolts_front();
}

//new_back();
new_front();

//todo
// cutout so bltouch can be reversed
// 2.5mm hole for hex drive in front
