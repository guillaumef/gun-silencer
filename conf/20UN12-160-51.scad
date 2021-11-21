/*

   Silencer closed no lips

   */


silencer_len 			= 160;	/* printed part length */
silencer_struct_thickness 	= 1.0;	/* Global structure thickness */

/* The tube : provided or printed (part=3) */
silencer_tube_int_dia		=51.2;	/* tube internal diameter */
silencer_tube_ext_dia		=52.2;	/* tube external diameter. Can be equal to int_dia */
silencer_tube_barrel_dia	=  28;
silencer_tube_barrel_rounded	= 0;	/* Active for silencer_tube_barrel_dia < silencer_tube_int_dia
					   Defines the rounded part between barrel_dia and tube_int_dia.
					   0 = not rounded.
					   0.x ... elliptic
					   1 = circle
					 */

silencer_foam_thickness		=   0;	/* foam or air chamber between the tube and this part
					   0  : for straight tube.
					   >0 : activates the lips part.
					 */

/* Thread */
silencer_thread_len		=  12;	/* threaded part of the rifle */
silencer_thread_type		= "20-UN-1/2";	/* Listed in libs/threadlib/THREAD_TABLE.scad */
silencer_thread_scale2fit	= 1.0;	/* x/y scale ratio to fit >=1.0, 1.003 for 3% tolerance */

/* Caliber */
silencer_caliber		= 7.8;	/* Add a margin here, ~ 1.5mm */

/* Lips: support between tube_int and monocore baffles */
silencer_lips_number		= 2;	/* External lips in contact with the tube.
					   0 for no lips at all (no external lip flush with tube_ext_dia) */
silencer_lips_thickness         = 5.0;	/* Thickness */
silencer_lips_rounded		= 1;	/* Are they rounded, and how much.. */
silencer_lips_fn		= 20;	/* Number of faces for the lip cylinder. Can be = $fn */
silencer_lips_groove		= 0;	/* Add a groove for an o-ring on each lip: this is the thickness
					   of the o-ring.
                                           If you activate it (>0), the lips diameter are reduced by
                                           1mm to let the o-ring have a nice compression.
					 */

/* Baffles */
silencer_baffle_decal 		= silencer_struct_thickness * 15.0;	/* attack angle */
silencer_baffle_start		= 35.0;	/* Start of the baffles, must be > silencer_thread_len */
silencer_baffle_size 		= 1.56;	/* Ratio on caliber */
silencer_baffle_concentric	= 4;	/* concentric reduction:
					   (3 means baffles: 3*size,2*size,1*size,1*size,...) */

silencer_baffle_open		= 0;	/* Opening angle of the baffle (works with foam and lips)
					   0 for closed baffle
					 */

silencer_pins_dia		= 1.5;	/* Pins diameter: 0 to disable */


/* Printing helper */
silencer_brim_close		= 0.4;	/* Integrate structure closing to allow the printing option:
					   "Brim > Only on Outside".
					   It saves you from the painful process of removing the brim
					   from the baffles.
					 */

