/*
 *
 * The ultimate parametric silencer
 *
 *
 * This design allows to generate a unique baffle
 * silencer exactly fitting your gun/rifle:
 *  - with external tube or not (like carbon fiber tube)
 *  - with an "over the barrel" tube or not
 *  - fully tunable: number/size/progressiveness of sound traps
 *  - easy cleaning - two parts
 *  - all caliber compatible
 *  - all metric ou unf threads
 *  - 2 printing modes (depending on your printer efficiency)
 *
 *
 *	Author: Guillaume F. ( g@w0.yt )
 *	License: GPL
 *	Date: 2021-XXXX
 *
 */



$fn = 100;				/* 50 for design, 100 for stl/3d print */

/* Processing options */

silencer_mode			= 1;	/*
					   1 = two parts (if your 3d printer is efficient)
					   2 = three parts to print (threaded part printed vertically)
					 */

silencer_part			= 0;	/*
					   in mode=2, the two sides are the same (part=2 is the thread)

					   0 = demo parts
					   1 = first part
					   2 = second part

					   3 = tube if needed

					 */


/* Configuration of the silencer : Millimeters */

//include <conf/20UN12-180-28_30_WL.scad>;
//include <conf/20UN12-160-51.scad>;
//include <conf/20UN12-160-28_30_NL.scad>;
include <conf/20UN12-open-150-50.scad>;

/* / End of Configuration */



/* Mode processing */
if (silencer_mode == 1) {
	if (! silencer_part) {
		/* Demo */
		rotate([0,90,0]) {
			s_silencer_half( 0 );
			/* color([0,0.5,0.5,0.2]) rotate([0,0,180]) s_silencer_half( 1 ); */
			color([0.1,0.1,1.0,0.4]) { s_tube(); }
		}
	}
	else if (silencer_part < 3) {
		rotate([0,-90,0])
			s_silencer_half( silencer_part-1 );
	}
	else if (silencer_part == 3) {
		s_tube();
	}
}
else if (silencer_mode == 2) {
	if (! silencer_part) {
		/* Demo */
		rotate([0,90,0]) {
			color([1.0,0.0,0.0])
				scale(1.001)
				s_silencer_down();
			s_silencer_up(0);
			color([0.1,0.1,1.0,0.4]) { s_tube(); }
		}
	}
	else if (silencer_part == 1) {
		rotate([0,-90,0]) s_silencer_up(0);
	}
	else if (silencer_part == 2) {
		s_silencer_down();
	}
	else if (silencer_part == 3) {
		s_tube();
	}
}

/* Computed */
silencer_caliber_r	= silencer_caliber/2;
silencer_struct_dia	= silencer_tube_int_dia - silencer_foam_thickness*2;
silencer_open_dia	= silencer_struct_dia - silencer_struct_thickness;
silencer_baffle_thick	= silencer_baffle_size * silencer_caliber_r;

module s_polymain() {
	polygon( points = [
			[ 0, 0 ],
			[ 0, silencer_caliber_r ],
			[ silencer_len, silencer_caliber_r ],
			[ silencer_len, 0 ]
	] );
}

module s_polytrap( multi=1 ) {
	decal_x = silencer_baffle_decal;
	decal_ywant = silencer_open_dia/2 - silencer_caliber_r;
	decal_y	= (decal_ywant>=0) ? decal_ywant : 0;
	pts = concat(
			[
			[ 0, 0 ],
			[ decal_x, decal_y]
			],
			[
			for (th = [0:10:180])
			[
			decal_x + (1-cos(th))*(multi*silencer_baffle_thick/2),
			decal_y + sin(th)*(silencer_caliber_r
				- ((multi-1)*0.15) ) /* add structure thickness in multimode */
			]
			]
			,[
			[ decal_x + multi*silencer_baffle_thick, decal_y],
			[ multi*silencer_baffle_thick, 0]]
		       );
	polygon( points = pts );
}

module s_polyhole( multi=1 ) {
	decal_x = silencer_baffle_decal;
	decal_ywant = silencer_open_dia/2 - silencer_caliber_r;
	decal_y	= (decal_ywant>=0) ? decal_ywant : 0;
	pts = concat(
			[
			[ decal_x, decal_y ],
			[ decal_x, decal_y+100 ],
			[ decal_x + multi*silencer_baffle_thick, decal_y+100 ],
			[ decal_x + multi*silencer_baffle_thick, decal_y ]
			]
		       );
	polygon( points = pts );
}


module s_polymask( isholes=0 ) {
	baffle_h = silencer_baffle_thick + silencer_struct_thickness;

	if (! isholes)
		s_polymain();

	decal_start = silencer_baffle_concentric;
	decal_series = (decal_start*(decal_start+1))/2 - 1;
	if (decal_start>1) {
		for(decalinv = [ 0 : decal_start-1 ]) {
			decal = decal_start - decalinv;
			translate([silencer_baffle_start +
					baffle_h*( decal_series - (decal*(decal+1))/2 ),0,0]) {
				if (isholes) {
					s_polyhole( decal );
				}
				else {
					s_polytrap( decal );
				}
			}
		}
	}

	for(sp = [silencer_baffle_start+baffle_h*decal_series:
			baffle_h:
			silencer_len
			-baffle_h
			-silencer_baffle_decal
			-silencer_struct_thickness
			-silencer_pins_dia])
	{
		translate([sp,0,0]) {
			if (isholes) {
				s_polyhole();
			} else {
				s_polytrap();
			}
		}
	}
}

module s_polyholemask() {
	s_polymask(1);
}
module s_polyholemaskprep() {
	rotate_extrude(angle=silencer_baffle_open, $fn=100)
		rotate([0,0,90])
		s_polyholemask();
}

module s_mask() {
	rotate_extrude($fn=200) rotate([0,0,90])
		s_polymask();

	if (silencer_baffle_open) {
		rotate([0,0,0-silencer_baffle_open/2])
			s_polyholemaskprep();
		rotate([0,0,180-silencer_baffle_open/2])
			s_polyholemaskprep();
	}
}

/* Splitted function to optimize the rendering - minkowski is a killer */
module s_lip( h=silencer_lips_thickness ) {
	d = silencer_tube_int_dia - (silencer_lips_groove?1:0);
	if (silencer_lips_rounded) {
		translate([0,0,silencer_lips_rounded])
			minkowski() {
				cylinder( d=(d-silencer_lips_rounded*2),h=(h-silencer_lips_rounded*2),$fn=silencer_lips_fn );
				sphere(r=silencer_lips_rounded);
			}
	}
	else {
		cylinder( d=(d-silencer_lips_rounded*2),h=(h-silencer_lips_rounded*2),$fn=silencer_lips_fn );
	}
}

module s_lipgroove( h=silencer_lips_thickness ) {
	d = silencer_tube_int_dia - (silencer_lips_groove?1:0);
	difference() {
		s_lip( h );
		if (silencer_lips_groove) {
			translate([0,0,h-silencer_lips_thickness/2])
				rotate_extrude(convexity = 10)
				translate([d/2-silencer_lips_rounded+silencer_lips_groove/2, 0, 0])
				circle(r = silencer_lips_groove/2, $fn = 100);
		}
	}
}

module s_solid() {
	union() {
		start = silencer_baffle_start + 5; /* margin for tube split overlap */
		difference() {
			union() {
				cylinder(d=silencer_struct_dia,h=silencer_len);
				/* first lip thread */
				s_lipgroove(start);
			}

			if (silencer_tube_barrel_dia < silencer_tube_int_dia) {
				r = (silencer_tube_ext_dia - silencer_tube_barrel_dia)/2;
				squeeze = silencer_tube_barrel_rounded;
				rr = r * squeeze;
				union() {
					difference(){
						cylinder(d=silencer_tube_ext_dia+1,h=silencer_baffle_start-rr);
						cylinder(d=silencer_tube_barrel_dia,h=silencer_baffle_start+1);
					}
					if (silencer_tube_barrel_rounded) {
						translate([0,0,silencer_baffle_start-rr]) {
							scale([1,1,squeeze])
								rotate_extrude(convexity = 10)
								translate([r+silencer_tube_barrel_dia/2, 0, 0])
								circle(r = r, $fn = 100);
						}
					}
				}
			}
		}
		/* lips : h-len left */
		h = silencer_len
			-start-silencer_lips_rounded*2	/* bottom */
			-silencer_lips_thickness				/* top */
			-silencer_lips_thickness + silencer_lips_rounded;	/* last lip */
			;
		seph = h/(silencer_lips_number-1);
		for(z = [seph:seph:h]) {
			translate([0,0,start+silencer_lips_rounded*2+z]) s_lipgroove();
		}
		/* last lip - external */
		translate([0,0,silencer_len-silencer_lips_thickness])
			cylinder(d=silencer_tube_ext_dia,h=silencer_lips_thickness);
	}
}

/* Mode=2 split mask */
module s_split_mask() {
	ztooth = silencer_lips_thickness+silencer_lips_rounded*2;
	z = silencer_baffle_start-ztooth;
	translate([0,0,-500+z]) cube([1000,1000,1000],center=true);
	translate([0,0,ztooth/2+z]) {
		translate([ silencer_tube_int_dia/2-ztooth/2,0,0])
			cube([ztooth,1000,ztooth],center=true);
		translate([-silencer_tube_int_dia/2+ztooth/2,0,0])
			cube([ztooth,1000,ztooth],center=true);
	}
}

use <threadlib/threadlib.scad>

nut_spec	= thread_specs(str(silencer_thread_type, "-int"));
nut_dia		= nut_spec[2];
nut_dia_scaled	= nut_dia * silencer_thread_scale2fit;
nut_zdecal	= nut_spec[0];

module s_nut() {
	difference() {
		scale([silencer_thread_scale2fit,silencer_thread_scale2fit,1.0]) {
			translate([0,0,nut_zdecal/2])
			union() {
				nut(silencer_thread_type, 100, nut_dia);
			};
		}
		translate([0,0,5000+silencer_thread_len]) cube(10000,center=true);
	};
}

module s_nut_mask() {
	cylinder( d=nut_dia_scaled, h=silencer_baffle_start+silencer_baffle_decal );
}

module s_pin_mask() {
	rotate([0,90,0]) cylinder(d=silencer_pins_dia, h=silencer_tube_int_dia, center=true, $fn=10);
}

module s_pins_mask() {
	if (silencer_pins_dia) {
		decal_y = silencer_open_dia/2 - silencer_struct_thickness - silencer_pins_dia;
		decal_z = silencer_len - silencer_pins_dia - silencer_struct_thickness*2;
		translate([0,  decal_y, decal_z]) s_pin_mask();
		translate([0, -decal_y, decal_z]) s_pin_mask();

		decal_zm = silencer_baffle_start - silencer_lips_thickness/2 - silencer_lips_rounded;
		translate([0,  nut_dia_scaled/2 + silencer_pins_dia, decal_zm]) s_pin_mask();
		translate([0, -nut_dia_scaled/2 - silencer_pins_dia, decal_zm]) s_pin_mask();
	}
}

module s_silencer( wbrim = 0 ) {
	union() {
		difference() {
			s_solid();
			s_mask();
			s_nut_mask();
			s_pins_mask();
		}
		s_nut();
		if (wbrim && silencer_brim_close && silencer_part) {
			ztooth = silencer_lips_thickness+silencer_lips_rounded*2;
			z = silencer_baffle_start-ztooth;

			translate([0,0,.25 + ((silencer_mode==2)?z:0)]) {
				cube([silencer_brim_close,
						silencer_tube_barrel_dia,
						.5],center=true);
			}
			translate([0,0,silencer_len-.25]) {
				cube([silencer_brim_close,
						silencer_tube_ext_dia,
						.5],center=true);
			}

		}
	}
}

module s_silencer_wbrim() {
	s_silencer( 1 );
}

/* Up / Down mode : 3 parts */
module s_silencer_up(even) {
	difference() {
		rotate([0,0,even?0:180])
			difference() {
				s_silencer_wbrim();
				s_split_mask();
			}
		translate([-5000,0,0]) cube(10000,center=true);
	}
}

module s_silencer_down() {
	intersection() {
		s_silencer();
		s_split_mask();
	}
}


/* Monoblock mode : 2 parts */
module s_silencer_half(even) {
	difference() {
		rotate([0,0,even?0:180])
			s_silencer_wbrim();
		translate([-5000,0,0]) cube(10000,center=true);
	}
}

/* External tube */
module s_tube() {
	decal = (silencer_tube_barrel_dia < silencer_tube_int_dia)?1:0;
	h = silencer_len - silencer_lips_thickness
		-( decal ? silencer_baffle_start : 0 );

	translate([0,0,h/2 + (decal ? silencer_baffle_start : 0)])
		difference([]) {
			cylinder(d=silencer_tube_ext_dia,h=h,center=true);
			cylinder(d=silencer_tube_int_dia,h=h+1,center=true);
		}
}

