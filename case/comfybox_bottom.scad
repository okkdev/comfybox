$fn = 64;

module rcube(width, depth, height, radius, center){
    points = [
        for (p = [
            [0 + radius, 0 + radius],
            [0 + radius, depth - radius],
            [width - radius, 0 + radius],
            [width - radius, depth - radius]
        ])
        if (center) [p[0] - width / 2, p[1] - depth / 2]
        else p
    ];
    hull(){
        for (p = points){
            translate(p) cylinder(r=radius, h=height);
        }
    }
}

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
    
height = 8;

difference() {
//    base
    rcube(350, 190, height, 15, center=true);
    
//    pcb
    pcb_height = 1.6;
    translate([0, 29.80, height-pcb_height]) rcube(240.5, 130.5, 2, 4, center=true);

    buttons = [
        each [ for (b = left_buttons) b + [-35, 35] ],
        each [ for (b = right_buttons) b + [20, 47] ],
    ];
    
    for (b = buttons) translate([b[0], b[1], height-pcb_height-2]) cylinder(3, r=10);
    
    translate([-63, 85.5, height-pcb_height-2]) rcube(66, 8, 3, 4, center=true);
    
    translate([-7.8, 17, height-pcb_height-2]) rcube(13, 6, 3, 3, center=true);
    
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
    
    for (m = mount_holes) translate([m[0], m[1], -1]) cylinder(height+2, r=2);
}