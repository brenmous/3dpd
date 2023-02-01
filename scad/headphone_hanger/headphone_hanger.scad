use <../libs/catchnhole/catchnhole.scad>;

$fn=100;
bodyOffset = 0.44;
shaftRadius = 1.30;

bolt="M4";
hookLength=40; hookWidth=18; hookHeight=30;
hookThickness=7; pointHeight=15;
hook(hookLength, hookWidth, hookHeight, hookThickness, pointHeight);

endcapThickness = 7;
body(hookLength, hookWidth, hookHeight, hookThickness, endcapThickness);

mountHeight=0; mountWidth=12; mountLength=12; mountThickness=7;
screwMount(
    hookHeight, hookThickness, hookWidth,
    endcapThickness,
    mountHeight, mountWidth, mountLength, mountThickness,
    bolt
);


//clampHeight=30; clampLength=20; clampThickness=7; clampWidth=hookWidth * 1.6;
//plateThickness=5;
//clamp(
//    hookLength, hookWidth, hookHeight, hookThickness,
//    endcapThickness,
//    clampHeight, clampThickness, clampLength, clampWidth,
//    bolt
//);
//plate(hookThickness, hookWidth, clampLength, clampWidth, clampThickness, plateThickness, clampWidth * 0.25, bolt);
//plate(hookThickness, hookWidth, clampLength, clampWidth, clampThickness, plateThickness, -clampWidth * 0.25, bolt);

module plate(ht, hw, cl, cw, ct, pt, yOffset, bolt="M4") {
    xyz = [
        ht + hw * bodyOffset + hw * 0.5 + ct * 1.5 + cl * 0.66,
        -cw * 0.2 + cw * 0.5 + yOffset,
        5,
    ];
    difference() {
        translate(xyz)
        rotate([0, 0, 30])
            cylinder($fn=6, h=pt, r=hw * 0.38);
        translate(xyz)
        rotate([0, 0, 30])
            nutcatch_parallel(bolt, height_clearance=0.5);
    }
}

module clamp(l, w, h, t, et, ch, ct, cl, cw, bolt="M4") {
    // creatively named "part" is two flat pieces that extend
    // from the shaft to make it thicker.
    // the clamping surfaces extend from their ends.
    module part(height) {
        xyz = [
            t + w * bodyOffset + w * 0.5,
            -cw * 0.2,
            height
        ];
        translate(xyz)
            cube([ct * 1.5, cw, ct]);
    }
    // the clamping surfaces
    module flat(height) {
        xyz = [
            t + w * bodyOffset + w * 0.5 + ct * 1.5,
            -cw * 0.2,
            height
        ];
        translate(xyz)
            cube([cl, cw, ct]);
    }
    module nutnbolt(yOffset) {
        xyz = [
            t + w * bodyOffset + w * 0.5 + ct * 1.5 + cl * 0.66,
            -cw * 0.2 + cw * 0.5 + yOffset,
            -ct - 0.25
        ];
        translate(xyz)
            bolt(bolt, ct);
        translate(xyz)
            nutcatch_parallel(bolt);
    }
    hull() { 
        part(ch);
        part(-ct - 0.25);
    }
    // top
    flat(ch);
    // bottom + hardware
    difference() {
        flat(-ct - 0.25);
        nutnbolt(yOffset=cw * 0.25);
        nutnbolt(yOffset=-cw * 0.25);
    }
}

module screwMount(hh, ht, hw, et, mh, mw, ml, mt, bolt="M4") {
    translate([ht + hw * bodyOffset + hw * 0.5, hw * 0.1, -et - 0.25])
        cube([ml, hw * 0.8, hh + et * 2 + 0.5]);

    translate([ht + hw * bodyOffset + hw * 0.5, hw * 0.1, hh + et + 0.25])
        cube([ml, hw * 0.8, mh]);

    difference() {
        translate([ht + hw * bodyOffset + hw * 0.5, hw * 0.1 - mw, hh - mt + et + 0.25 + mh])
            cube([ml, mw, mt]);
        translate([ht + hw * bodyOffset + hw * 0.5 + ml * 0.5, hw * 0.1 - mw * 0.5, hh - mt + et + 0.25 + mh + mt])
        rotate([180, 0, 0])
            bolt(bolt, mt, kind="countersunk");
    }
   
    difference() {
        translate([ht + hw * bodyOffset + hw * 0.5, hw * 0.9, hh - mt + et + 0.25 + mh])
            cube([ml, mw, mt]);
        translate([ht + hw * bodyOffset + hw * 0.5 + ml * 0.5, hw * 0.9 + mw * 0.5, hh - mt + et + 0.25 + mh + mt])
            rotate([180, 0, 0])
                bolt(bolt, mt, kind="countersunk");

    }
}

module body(l, w, h, t, et) {
    module endCap() {
        union() {
            translate([0, -w * 0.4, 0])
                // w / 2 is the clearance required to have 180 degree
                // rotation of the hook.
                // any jutty-outy bits need to be > w / 2
                cube([w * 0.5, w * 0.8, et]);
            cylinder(h=et, r=w * 0.4);
        }
    }
    difference() {
        hull() {
            translate([t + w * bodyOffset, w  * 0.5, h+0.25])
                endCap();
            translate([t + w * bodyOffset, w  * 0.5, -(et + 0.25)])
                endCap();
        }
        // cut out slightly fatter copy of the hook axle
        translate([t + w * bodyOffset, w * 0.5, -0.25])
            cylinder(h=h + 0.5, r=w * 0.45);
        // shaft hole - bottom is blind
        translate([t + w * bodyOffset , w * 0.5, -et + et * 0.25])
            cylinder(h=h + et * 2, r=shaftRadius);
    }
}

module hook(length, width, height, thickness, pHeight) {
    r = width * 0.5;
    // height starts from the upper surface of the bend
    h = height + thickness; 
    ph = pHeight + thickness;
    //shank
    difference() {
        // for small heights, need to cut any cylinder that protrudes
        // below z=0
        translate([0,r,h - r])
        rotate([0,90,0])
            cylinder(h=thickness, r=r);
        translate([-length, 0, -thickness])
            cube([length, width, thickness]);
    }
    cube([thickness, width, h -r ]);

    ////point
    difference() {
        translate([-length - thickness, r, ph - r])
        rotate([0,90,0])
            cylinder(h=thickness, r=r);
        translate([-length - thickness, 0, -thickness])
            cube([length, width, thickness]);
    }
    translate([-length - thickness, 0, 0])
        cube([thickness, width, ph - r]);

    //bend
    translate([-length,0,0])
        cube([length + thickness, width, thickness]);

    translate([thickness + width * bodyOffset, width * 0.5, 0])
    difference() {
        union() {
            translate([-(thickness + width * bodyOffset),-(width * 0.4  * 0.5),0])
                cube([thickness + width * 0.4, width * 0.4, height]);
                cylinder(h=height, r=width * 0.4);
            }
        cylinder(h=height, r=shaftRadius);
    }
}


