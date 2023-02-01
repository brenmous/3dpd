use <../libs/catchnhole/catchnhole.scad>;

//master original
module master() {
    import("fixed_back.stl");
}

module master_front() {
    import("fixed_front.stl");
}

module edge() {
    intersection() {
    import("fixed_back.stl");
    color("red")
    translate([-74,24,-5])
    cube([1,55,25]);
    }
}
module flat_edge() {
projection()
rotate([0,90,0])
edge();
}

module mount_extension() {
    translate([-93,31,-3.6])
    linear_extrude(height=3.5)
    union() {
        offset(r=1)
        square(size=[20,42]);
    }

    translate([-93,25,-3.6])
    linear_extrude(height=6)
    union() {
        offset(r=1)
        square(size=[20,6.3]);
    }
}

module mount_markers() {
    translate([-63.9 - 20,47.725,0])
    color("red")
    rotate([0,0,90])
    cylinder(r=1.5, h=1, $fn=100);

    translate([-48.9 - 20,47.725,0])
    color("red")
    rotate([0,0,90])
    cylinder(r=1.5, h=10, $fn=100);

    translate([-48.9 - 20,27.725,0])
    color("red")
    rotate([0,0,90])
    cylinder(r=1.5, h=10, $fn=100);

    translate([-63.9 - 20,27.725,0])
    color("red")
    rotate([0,0,90])
    cylinder(r=1.5, h=10, $fn=100);
}

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

module new_mounts() {
    difference() {
        difference() {
            new_master();
            translate([-63.9 - 20,47.725,-5])
            bolt("M3", 5, kind="countersunk", $fn=100);
            translate([-48.9 - 20,47.725,-4])
            bolt("M3", 5, kind="countersunk", $fn=100);
            translate([-48.9 - 20,27.725,-4.5])
            bolt("M3", 7, kind="countersunk", $fn=100);
            translate([-63.9 - 20,27.725,-4.5])
            bolt("M3", 7, kind="countersunk", $fn=100);
        }
        translate([-48.9 - 20,47.725,1])
        rotate([0,0,90])
        cylinder(r=4, h=5, $fn=100);
    }
}

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
        translate([-34.5, 9.2, -93.8])
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
        translate([-65, 30.6, -93.8])
        bolt("M3", 25, $fn=100);


    }
}

module new_front() {
    new_bolts_front();
}

new_back();
//new_front();

