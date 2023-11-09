$fn = 64;
$fs = 0.15;

//config
height = 7;
southpaw = false;

module roundedcube(width, depth, height, radius = 0.5, center = false, apply_to = "all") {
	translate_min = radius;
	translate_xmax = width - radius;
	translate_ymax = depth - radius;
	translate_zmax = height - radius;

	diameter = radius * 2;

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(width / 2),
			-(depth / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							sphere(r = radius);
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							rotate(a = rotate)
							cylinder(h = diameter, r = radius, center = true);
						}
					}
				}
			}
		}
	}
}

module rcube(width, depth, height, radius, center){
    points = [
        for (p = [
            [radius, radius],
            [radius, depth - radius],
            [width - radius, radius],
            [width - radius, depth - radius]
        ])
        if (center) [p[0] - width / 2, p[1] - depth / 2]
        else p
    ];
    hull(){
        for (p = points) translate(p) cylinder(r=radius, h=height);
    }
}

module case() {
    3_buttons = [
        [0,  0],
        [20.5, 20.5],
        [48,  28],
    ];
    4_buttons = [ each 3_buttons, [77,  28] ];

    right_buttons = [
        each 4_buttons,
        each [ for (b = 4_buttons) b + [6, -28] ],
        [0,  -67.5],
    ];
    left_buttons = [
        each [ for (b = 3_buttons) [-b[0], b[1]] ],
        [0,  -55.5],
    ];  
    
//    solder cutouts
    difference() {
    //    base
        translate([0, 29.6, 0])
        roundedcube(247, 137, height+7, 3, center=true);
        
    //    pcb
        pcb_height = 1.6;
        translate([0, 29.60, height-pcb_height])
        rcube(241, 131, 10, 4, center=true);

        buttons = [
            each [ for (b = left_buttons) b + [-35, 35] ],
            each [ for (b = right_buttons) b + [20, 47] ],
        ];
        
        for (b = buttons)
        translate([b[0], b[1], height-pcb_height-2])
        cylinder(3, r=9);
        
//        opt buttons
        translate([-63, 85.5, height-pcb_height-2]) rcube(66, 12, 3, 6, center=true);
        
//        oled
        translate([-6.8, 17, height-pcb_height-2]) rcube(13, 6, 3, 3, center=true);
        
        mount_holes = [
    //        pcb
            [0, -29.5],
            [-114, -29.5],
            [114, -29.5],
            [114, 89],
            [-114, 89],
            [21.5, 80.5],
        
    //        case
            [165, 85],
            [165, -85],
            [-165, -85],
            [-165, 85],
        ];
        
        for (m = mount_holes)
        translate([m[0], m[1], -1])
        cylinder(height+2, r=2);
    }
}
//                                           scale hack because of cnc
if (southpaw) mirror(v=[1,0,0]) case(); else scale([1.004, 1.004, 1]) case();