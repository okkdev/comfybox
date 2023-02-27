$fa = 1;
$fs = 0.5;

module rsquare(size, radius) {
  x = size.x - radius * 2;
  y = size.y - radius * 2;
  offset(r = radius) square([ x, y ], center = true);
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
//    base
    rsquare([350, 190], 10);
    
    buttons = [
        each [ for (b = left_buttons) b + [-35, 35] ],
        each [ for (b = right_buttons) b + [20, 47] ],
    ];
    
    for (b = buttons) translate(b) circle(12);
        
    opt_buttons = [ for (i = [1:5]) [-20.75, 85.5] - [14*i, 0] ];
    
    for (o = opt_buttons) translate(o) circle(3);
        
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
    
    for (m = mount_holes) translate(m) circle(2);
}