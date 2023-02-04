extrusion_p=25.8;

module bucket_hook(width, thickness, tail) {
    cube([thickness,width,extrusion_p]);
    translate([0,0,extrusion_p])
    cube([extrusion_p+thickness*2,width, thickness]);
    translate([extrusion_p+thickness,0,-tail])
    cube([thickness,width,extrusion_p+tail]);
}
