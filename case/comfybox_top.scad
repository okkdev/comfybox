$fa = 1;
$fs = 0.5;

//there are 2 layers of the top part
top = false;
//aliexpress wristrests
ali_wrist_rests = false;
//fellowes wristrests
fellowes_wrist_rests = false;

module rsquare(size, radius, center) {
  x = size.x - radius * 2;
  y = size.y - radius * 2;
  offset(r = radius) square([ x, y ], center = center);
}

module fellowes_wrist_rests() {
    translate([114, -40]) rotate(a=24, v=[0,0,1]) import("fellowes_wristrest.svg", center=true);      
    translate([-114, -40]) rotate(a=-24, v=[0,0,1]) import("fellowes_wristrest.svg", center=true);     
}

module ali_wrist_rests() {
    left = [-118, -49];
    right = [118, -49];
    
    if (top) {
        translate(right) rotate(a=24, v=[0,0,1]) import("ali_wristrest_top.svg", center=true);
        translate(left) rotate(a=-24, v=[0,0,1]) import("ali_wristrest_top.svg", center=true);
    }
    else {
        translate(right) rotate(a=24, v=[0,0,1]) import("ali_wristrest_bottom.svg", center=true);
        translate(left) rotate(a=-24, v=[0,0,1]) import("ali_wristrest_bottom.svg", center=true);
    }
}

3_buttons = [
    [0,  0],
    [19.5, 20],
    [46.5,  27.5],
];

4_buttons = [
    each 3_buttons, 
    [75.5,  23],    
];

right_buttons = [
    each 4_buttons,
    each [ for (b = 4_buttons) b + [10, -26] ],
    [0,  -65.5],
    [22, -50],
];
left_buttons = [
    each [ for (b = 3_buttons) [-b[0], b[1]] ],
    [0,  -53.5],
];

difference() {
//    base
    rsquare([330, 190], 15, center=true);
    
    buttons = [
        each [ for (b = left_buttons) b + [-35, 35] ],
        each [ for (b = right_buttons) b + [20, 47] ],
    ];
    
    for (b = buttons) translate(b) circle(d=24);
        
    mount_holes = [
//        pcb
        [0, -29.5],
        [114, 89],
        [-114, 89],
        [21.5, 80.5],
//        bottom corners of pcb
//        [-114, -29.5],
//        [114, -29.5],
    
//        case
        [155, 85],
        [155, -85],
        [-155, -85],
        [-155, 85],
    ];
    
    for (m = mount_holes) translate(m) circle(2);
   
    if (fellowes_wrist_rests) {
        fellowes_wrist_rests();
    }
    
    if (ali_wrist_rests) {
        ali_wrist_rests();
    }
        
    if (top) {
        opt_buttons = [ for (i = [0:4]) [-34.5, 85.5] - [14*i, 0] ];
        for (o = opt_buttons) translate(o) circle(3.3);
    }
    else {
//        cutouts
//        opt buttons
        translate([-62.5, 85.5]) rsquare([65, 8], 2, center=true);
//        oled
        translate([-6.8, 6]) rsquare([28, 29], 2, center=true);
//        pico zero
        translate([-7, 83.1]) rsquare([22, 28], 2, center=true);
    }
}
