/*
 * Werkzeug Case [for V3 boards]
 * Copyright (c) 2023 Lone Dynamics Corporation. All rights reserved.
 *
 * required hardware:
 *  - 4 x M3 x 16mm countersunk bolts
 *  - 4 x M3 nuts
 *
 */

$fn = 100;

werkzeug_text = true;

board_width = 50;
board_thickness = 1.5;
board_length = 50;
board_spacing = 2;

//ldp_board();

translate([0,0,15])
	ldp_case_top();

//translate([0,0,-5])
//	ldp_case_bottom();

module ldp_board() {
	
	difference() {
		color([0,0.5,0])
			roundedcube(board_width,board_length,board_thickness,5);
		translate([5, 5, -1]) cylinder(d=3.2, h=10);
		translate([5, 45, -1]) cylinder(d=3.2, h=10);
		translate([45, 5, -1]) cylinder(d=3.2, h=10);
		translate([45, 45, -1]) cylinder(d=3.2, h=10);
	}	
	
}

module ldp_case_top() {

	union() {

		difference() {

			color([0.5,0.5,0.5])
				roundedcube(board_width,board_length,10,5);

			translate([10.5,8,-17.5])
				cube([board_width-17.5,board_length-15,25]);

			translate([2.5,9,-22])
				cube([20,32,25]);

			translate([2.5,9,-17.5])
				cube([20,24,25]);

			translate([30,5,-20.5])
				cube([10,20,25]);

			translate([26,9,-17.5])
				cube([20,32,25]);

			// GPIO
			translate([25-13.5,board_length-20,-2])
				cube([27,25,6+2]);
		
			// BOOT BUTTON
			translate([30,36.525-(7.6/2),-2]) cube([30,7.6,7+1.75]);

			// RESET BUTTON
			translate([30,13.525-(7.6/2),-2]) cube([30,7.6,7+1.75]);

			// USBC
			translate([30,25-(10.5/2),-2]) cube([30,10.5,3.5+1.75]);

			// USBA HOST
			translate([25-(14.5/2),-2,-2]) cube([14.5,30,7.5+2]);

			// USBA HOST switch
			translate([35.5-(6.8/2),-2,-2]) cube([9,30,1.6+2]);
		
			// PMODA
			translate([-2,25-(16/2),-2]) cube([25,16,5+2]);

			// bolt holes
			translate([5, 5, -21]) cylinder(d=3.5, h=40);
			translate([5, 45, -21]) cylinder(d=3.5, h=40);
			translate([45, 5, -20]) cylinder(d=3.5, h=40);
			translate([45, 45, -21]) cylinder(d=3.5, h=40);

			// flush mount bolt holes
			translate([5, 5, 9.5]) cylinder(d=6, h=4);
			translate([5, 45, 9.5]) cylinder(d=6, h=4);
			translate([45, 5, 9.5]) cylinder(d=6, h=4);
			translate([45, 45, 9.5]) cylinder(d=6, h=4);

			// werkzeug text
			if (werkzeug_text) {
				rotate(270)
					translate([-25,25-(3/2),9])
						linear_extrude(2)
							text("W E R K Z E U G", size=3, halign="center",
								font="Ubuntu:style=Bold");
			}

		}	
	
	}

}

module ldp_case_bottom() {
	
	difference() {
		color([0.5,0.5,0.5])
			roundedcube(board_width,board_length,4.4,5);
		
		translate([1,8.5,2])
			roundedcube(board_width-2,board_length-17,8,5);
				
		translate([9,1,2])
			roundedcube(board_width-18,board_length-2,8,5);

		// bolt holes
		translate([5, 5, -11]) cylinder(d=3.2, h=25);
		translate([5, 45, -11]) cylinder(d=3.2, h=25);
		translate([45, 5, -11]) cylinder(d=3.2, h=25);
		translate([45, 45, -11]) cylinder(d=3.2, h=25);

		// nut holes
		translate([5, 5, -1.5]) cylinder(d=7, h=4.5, $fn=6);
		translate([5, 45, -1.5]) cylinder(d=7, h=4.5, $fn=6);
		translate([45, 5, -1.5]) cylinder(d=7, h=4.5, $fn=6);
		translate([45, 45, -1.5]) cylinder(d=7, h=4.5, $fn=6);

	}	
}

// https://gist.github.com/tinkerology/ae257c5340a33ee2f149ff3ae97d9826
module roundedcube(xx, yy, height, radius)
{
    translate([0,0,height/2])
    hull()
    {
        translate([radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,yy-radius,0])
        cylinder(height,radius,radius,true);

        translate([radius,yy-radius,0])
        cylinder(height,radius,radius,true);
    }
}
