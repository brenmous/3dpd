$fn=100;

or=27.71;
ir=21.5;

module soap_dish() {
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

    linear_extrude(height=5)
    hanger();

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

    module halo() {
        difference() {
            translate([0,110,0])
            cylinder(r=or*1.87,h=5);
            color("red")
            translate([-or*2,112,0])
            cube([or*2*2, or*2, 7]);
        }
    }

    halo();
}

soap_dish();

