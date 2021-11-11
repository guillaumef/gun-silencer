/*

   20-UN-1/2
   160 x 28/30  no lips

   */

silencer_len 			= 160;	/* printed part length */
silencer_tube_int_dia		=51.2;	/* tube (provided) internal diameter */
silencer_tube_ext_dia		=52.2;	/* tube (provided) external diameter. Can be equal to int_dia */
silencer_tube_barrel_dia	=  28;
silencer_foam_thickness		=   0;	/* foam or air chamber between the tube (provided) and this part
					   0  : for straight tube.
					   >0 : activates the lips part.
					 */
silencer_struct_thickness 	= 1.0;	/* Global structure thickness */

silencer_thread_len		=  12;	/* threaded part of the rifle */
silencer_thread_type		= "20-UN-1/2";	/* Listed in libs/threadlib/THREAD_TABLE.scad */
silencer_thread_scale2fit	= 1.0;	/* x/y scale ratio to fit >=1.0, 1.003 for 3% tolerance */

silencer_caliber		= 7.8;	/* Add a margin here, ~ 1.5mm */

silencer_lips_thickness		= 5.0;  /* External lips in contact with the tube (provided).
					   0 for no lips at all (no external lip flush with tube_ext_dia) */
silencer_lips_number		= 2;	/* Number of lips */
silencer_lips_rounded		= 1;	/* Are they rounded, and how much.. */
silencer_lips_fn		= 20;	/* Number of faces for the lip cylinder. Can be = $fn */

silencer_soundtrap_decal 	= silencer_struct_thickness * 15.0;	/* attack angle */
silencer_soundtrap_start	= 35.0;	/* Start of the soundtraps, must be > silencer_thread_len */
silencer_soundtrap_size 	= 1.56;	/* Ratio on caliber */
silencer_soundtrap_concentric	= 4;	/* concentric reduction:
					   (3 means soundtraps: 3*size,2*size,1*size,1*size,...) */
silencer_pins_dia		= 1.5;	/* Pins diameter: 0 to disable */

silencer_brim_close		= 0.4;	/* Integrate structure closing to allow the printing option:
					   "Brim > Only on Outside".
					   It saves you from the painful process of removing the brim
					   from the soundtraps.
					 */

