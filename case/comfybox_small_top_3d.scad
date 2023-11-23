$fa = 1;
$fs = 0.5;

module rsquare(size, radius, center) {
  x = size.x - radius * 2;
  y = size.y - radius * 2;
  offset(r = radius) square([ x, y ], center = center);
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

difference() {
    linear_extrude(height = 7)
    difference() {
    //    base
        translate([0, 29.6, 0])
        rsquare([240.4, 130.4], 4, center=true);
        
        buttons = [
            each [ for (b = left_buttons) b + [-35, 35] ],
            each [ for (b = right_buttons) b + [20, 47] ],
        ];
        
        // buttons and button size
        for (b = buttons) translate(b) circle(12);
            
        mount_holes = [
    //        pcb
            [0, -29.5],
            [114, 89],
            [-114, 89],
            [21.5, 80.5],
    //        bottom corners of pcb
            [-114, -29.5],
            [114, -29.5],
        ];
        
        for (m = mount_holes) translate(m) circle(d=4);
            
        union() {
            opt_buttons = [ for (i = [0:4]) [-34.5, 85.5] - [14*i, 0] ];
            for (o = opt_buttons) translate(o) circle(3.4);
        }
    }
    translate([0,0,-1.2])
    linear_extrude(height = 7)
    union() {
//        cutouts
//        opt buttons
        translate([-63, 85.5]) rsquare([66, 8], 2, center=true);
//        oled
        translate([-6.8, 5]) rsquare([28, 31], 2, center=true);
//        pico zero
        translate([-7, 83.1]) rsquare([22, 28], 2, center=true);
    }
}