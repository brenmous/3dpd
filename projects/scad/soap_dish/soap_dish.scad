$fn=100;

or=27.71;
ir=21.5;

module soap_dish(hanging=true) {
    module half_ring() {
        difference() {
            circle(r=or);
            circle(r=ir);
            square([or,or]);
            mirror([1,0])
            square([or,or]);
        }
    }

    module hanger() {
        half_ring();

        rotate([0,0,-16.3])
        translate([ir-0.9,5.9])
        square([or-ir,106.2]);

        mirror([1,0,0])
        rotate([0,0,-16.3])
        translate([ir-0.9,5.9])
        square([or-ir,106.2]);
    }

    dw=100;
    dd=60;
    module dish() {
        hull() {
            color("red")
            translate([-dw*1.1/2,100])
            square([dw*1.1,1]);

            translate([-dw/2,110])
            square([dw,1]);
        }
    }

    if (hanging) {
        linear_extrude(height=5)
        hanger();
    }

    module hollow_dish() {
        translate([0,0,5])
        difference() {
            translate([0,-11, -5])
            scale([1.04,1.11,1.12])
            linear_extrude(height=dd)
            dish();

            linear_extrude(height=dd)
            dish();

            n=5;
            for (i = [10,30,50]) {
                for (j = [0:n]) {
                    color("red")
                    translate([(dw-7.5)/2 - (dw-7.5)/n * j,120,i])
                    rotate([90,0,0])
                    cylinder(r=2.5, h=10);
                }
            }
        }
    }

    hollow_dish();

    module halo(scaling=1.87) {
        difference() {
            translate([0,110,0])
            cylinder(r=or*scaling,h=5);
            translate([-dw*1.3/2,100,0])
            cube([dw*1.3, 100, 7]);
        }
    }

    module loop() {
        ot = 25;
        ol = 15;
        it = 16.1;
        il = 3.6;
        module _loop() {
            linear_extrude(height=20)
            difference() {
                difference() {
                    offset(delta=1, chamfer=true)
                    square([ot,ol]);
                    translate([(ot-it)/2,(ol-il)/2])
                    offset(r=1)
                    square([it,il]);
                }
            translate([-1,-1])
            square([ot+2,ol/2.7]);
            }
        }
        translate([-ot/2,92.21,ol/2.7])
        rotate([-90,0,0])
        _loop();

    }

    if (hanging) {
        halo();
    } else {
        halo(scaling=2.097);
        loop();
    }
}

soap_dish(false);
