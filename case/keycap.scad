$fn = 64;

//config
choc_stem = false;

difference() {
    translate([0, 0, 2]) hull() {
        translate([0, 0, 1]) cylinder(1.75, d=22);
        rotate_extrude() translate([8.5, 0]) circle(r=2);
        translate([0, 0, -0.4]) rotate_extrude() translate([10, 0]) circle(r=1);
    }
    
    translate([0, 0, -0.4]) resize([0,0,2]) sphere(r=9);
    
    translate([0, 0, 2.5]) cylinder(4, d=18.5);
}

if (choc_stem) {
//    choc stem
    translate([0, 0, 3]) {
        stem_width = 1.2;
        stem_depth = 3;
        translate([-stem_width/2 + 2.85, -stem_depth/2]) cube([stem_width, stem_depth, 5]);
        translate([-stem_width/2 - 2.85, -stem_depth/2]) cube([stem_width, stem_depth, 5]);
        
        cube([20, 2, 2], center=true);
        cube([2, 20, 2], center=true);
    }
}
else {
//    mx stem
    translate([0, 0, 1]) difference() {
        cylinder(5.5, d=5.6);
        
//        default is 1.28 made a bit tighter for fit
        stem_width = 1.25;
        stem_depth = 4;
        translate([-stem_width/2, -stem_depth/2]) cube([stem_width, stem_depth, 6]);
        translate([-stem_depth/2, -stem_width/2]) cube([stem_depth, stem_width, 6]);
    }
}
