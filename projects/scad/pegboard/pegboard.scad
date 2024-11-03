$fn=100;

module peg(r=5, off=-0.1, length=10, chamfer=true) {
    radius = r + off;
    if (chamfer) {
        hull() {
            translate([0,0,1])
            cylinder(r=radius, h=1);
            linear_extrude(height=1)
            offset(r=-1)
            circle(radius);
        }
        translate([0,0,2])
        cylinder(r=radius, h=length-2);
    } else {
        cylinder(r=radius, h=length);
    }

}

module kinked_peg(r=5, off=-0.1, length=10) {
    radius = r + off;
    module p(){
        hull() {
            translate([0,0,1])
            cylinder(r=radius, h=1);
            linear_extrude(height=1)
            offset(r=-1)
            circle(radius);
        }
        translate([0,0,2])
        cylinder(r=radius, h=length-2);
        translate([0,0,length])
        rotate([20,0,0])
        cylinder(r=radius, h=length-2);
    }
  
    hull()
    intersection() {
        p();
        translate([-length/2,0,length/2])
        cube([length,r*2,length]);
    }
    p();
}

//kinked_peg(r=9.5/2, off=0);

module pegtest() {
    rs=[2-.1,2.5-.1,3-.1,3.5-.1,5-.1];
    for (i = [0 : len(rs) - 1]) {
        rotate([90,0,0])
        union() {
            translate([i*20, 0, 0])
            cylinder(r=rs[i], h=20);
            translate([i*20,0,20-2.5])
            linear_extrude(height=2.5, scale=5 / rs[i])
            circle(rs[i]);
            translate([i*20 - 5, -5, 20])
            cube([10,10,10]);
        }
    }
}

module jig() {
    r = 5;
    l = 160;
    h = 160;
    x = 20;
    y = 20;

    difference() {
        translate([0, -3, 0])
        cube([l, h, 6]);  
        cube([l, h, 6]);
    }

    difference() {
        cube([l, h, 3]);  
        for (row = [0 : l/x - 2]) {
            for (col = [0: h/y - 2]) {
                translate([x * col + x, y * row + y, -5])
                //rotate([-90,0,0])
                cylinder(r=r+.1, h=15);
            }
        }
    }
}

module spool_holder_holder() {
    difference() {
        union() {
            translate([10,-10,0])
            rotate([-90,0,0])
            peg(r=9.5/2, length=10, off=0.095);
            translate([30,-10,0])
            rotate([-90,0,0])
            peg(r=9.5/2, length=10, off=0.095);
            //translate([10,0,20])
            //peg(r=9.5/2, length=10, peg_taper=0.95, off=0.25);
            //translate([30,0,20])
            //peg(r=9.5/2, length=10, peg_taper=0.95, off=0.25);
            translate([0,0,-10])
            cube([40,10,20]);
            translate([0,10,-10])
            cube([40, 20, 10]);
        }

        union() {
            translate([10,20,-10])
            cylinder(r=2.45, h=20);
            translate([30,20,-10])
            cylinder(r=2.45, h=20);
        }
    }
}

module clip(d) {
    clip_height=1;
    width = d + d * 0.25;
    depth = d * 0.75;
    thickness = 8;
    peg_length = 10;
    peg_r = 9.5/2;
    connector_size = d * 0.33;

    translate([0,-depth - peg_length - connector_size,5])

    rotate([-90,0,0])
    peg(r=9.5/2, off=0.095, length=peg_length);

    hull() {
      translate([0,-depth - connector_size,5])
      rotate([-90,0,0])
      peg(r=9.5/2, length=1, chamfer=false, off=0.095);

      translate([-width*0.5,-depth-1,clip_height])
      cube([width,1,thickness]);
    }
   
    translate([0,0,clip_height])
    linear_extrude(height=thickness)
    difference() { 

        translate([-width*0.5, -depth, 0])
        square([width,depth]);
        translate([0,-2,0])
        circle(d*0.5);
    }
}

// iron
clip(d=13.8);

// pen
//clip(d=15);

// pump
//clip(d=20);
