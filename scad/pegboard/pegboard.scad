$fn=100;

module peg(r=5, off=-0.1, length=10, peg_taper=0.90, cap_height=2.5, cap_scale=6) {
    radius = r + off;
    rotate([90,0,0])
    union() {
        //cylinder(r=radius, h=length);
        linear_extrude(height=length, scale=peg_taper)
        circle(radius);
        translate([0,0,length-cap_height])
        linear_extrude(height=cap_height, scale=cap_scale / radius)
        circle(radius);
    }
}

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

jig();
