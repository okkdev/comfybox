$fn = 64;

//config
choc_stem = false;

difference() {
    translate([0, 0, 2]) hull() {
        translate([0, 0, 1]) cylinder(2, d=22);
        rotate_extrude() translate([8.5, 0]) circle(r=2);
        translate([0, 0, -0.5]) rotate_extrude() translate([10, 0]) circle(r=1);
    }
    
    translate([0, 0, -0.4]) resize([0,0,2]) sphere(r=9);
    
    translate([0, 0, 3]) cylinder(4, r=9);
}

if (choc_stem) {
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
    translate([0, 0, 3]) difference() {
        cylinder(4, d=5.6);
        
        stem_width = 1.28;
        stem_depth = 4;
        translate([-stem_width/2, -stem_depth/2]) cube([stem_width, stem_depth, 5]);
        translate([-stem_depth/2, -stem_width/2]) cube([stem_depth, stem_width, 5]);
    }
}
