
#  The ultimate parametric silencer / moderator for airgun / bbgun / airsoft

## Project description

This design allows to generate a unique baffle
silencer exactly fitting your gun/rifle:

- with external tube or not (like carbon fiber tube)
- with an "over the barrel" tube or not
- fully tunable: number/size/progressiveness of baffles
- easy cleaning - two parts
- all caliber compatible
- all metric ou unf threads
- 2 printing modes (depending on your printer efficiency)

<img src="https://github.com/guillaumef/gun-silencer/blob/main/examples/example1.jpg" width="300" alt="silencer moderator airgun bbgun airsoft" align="center" /> <img src="https://github.com/guillaumef/gun-silencer/blob/main/examples/example2.jpg" width="300" alt="silencer moderator airgun bbgun airsoft" align="center" />

<img src="https://github.com/guillaumef/gun-silencer/blob/main/examples/example3.jpg" width="300" alt="silencer moderator airgun bbgun airsoft" align="center" />

<img src="https://github.com/guillaumef/gun-silencer/blob/main/examples/open1.jpg" width="300" alt="silencer moderator airgun bbgun airsoft" align="center" /> <img src="https://github.com/guillaumef/gun-silencer/blob/main/examples/open6.jpg" width="300" alt="silencer moderator airgun bbgun airsoft" align="center" />


<img src="https://cdn.thingiverse.com/assets/30/95/fe/ea/1c/large_display_img2.jpg" width="300" alt="silencer moderator airgun bbgun airsoft" align="center" /><img src="https://cdn.thingiverse.com/assets/e1/37/1d/84/46/large_display_IMG_20211111_213247_2.jpg" width="300" alt="silencer moderator airgun bbgun airsoft" align="center" />


### Concept

Baffle design is up to you and you can tweak it: Angle, Volume, Number, Progressivity.


### Printing

If you are using a brim for adhesion, the internal curves will be painfull to clean, I
added a nice option (silencer\_brim\_close) which allows to use Cura "Brim > Only on the outside".

I use ABS filament, 100% infill, no support!, an Ultimaker 2.

The thread output from the printer (even in mode=1, printed flat) is pretty good if your printer is efficient.
Tapping the thread is of course the best way to produce a clean path after print.


## Usage

You need openscad and a text editor.


### Linux
Simply install your distribution packages: openscad, curl, make


Clone the repository:
```
# git clone --recursive https://github.com/guillaumef/gun-silencer

```

Retrieve dependancies - if you did not use git '--recurvive' previously:
```
# cd gun-silencer
#
# cd libs
# make
# cd ..
```

Run openscad with the local libs directory.
```
OPENSCADPATH=`pwd`/libs openscad ./silencer.scad
```

Edit scad file (see section "Files" below)

Generate your STLs and print !


### Windows

Should be simple but... I don't have Microsoft Windows.
OpenSCAD is available. It should work perfectly.
http://openscad.org/downloads.html

### MacOS

Same as Windows.
http://openscad.org/downloads.html


## Files:

### silencer.scad
defines the mode, the part to work on and include the configuration file.
```
/* Processing options */
silencer_mode                   = 1;    /*
                                           1 = two parts (if your 3d printer is efficient)
                                           2 = three parts to print (threaded part printed vertically)
                                         */

silencer_part                   = 0;    /*
                                           0 = demo parts
                                           1 = first part
                                           2 = second part

                                           in mode=2, the two sides are the same.
                                         */

/* Configuration of the silencer : Millimeters */
//include <conf/20UN12-180-28_30_WL.scad>;
//include <conf/20UN12-160-51.scad>;
include <conf/20UN12-160-28_30_NL.scad>;
```

### conf/xxx.scad   (the active include)
```
/* Configuration of the silencer : Millimeters */

silencer_len 			= 150;	/* printed part length */
silencer_struct_thickness 	= 1.2;	/* Global structure thickness */

/* The tube : provided or printed (part=3) */
silencer_tube_int_dia		=  48;	/* tube internal diameter */
silencer_tube_ext_dia		=  50;	/* tube external diameter. Can be equal to int_dia */
silencer_tube_barrel_dia	=  28;
silencer_tube_barrel_rounded	= 0.1;	/* Active for silencer_tube_barrel_dia < silencer_tube_int_dia
					   Defines the rounded part between barrel_dia and tube_int_dia.
					   0 = not rounded.
					   0.x ... elliptic
					   1 = circle
					 */

silencer_foam_thickness		=   6;	/* foam or air chamber between the tube and this part
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
silencer_lips_thickness		= 5.0;  /* Thickness */
silencer_lips_rounded		= 1;	/* Are they rounded, and how much.. */
silencer_lips_fn		= $fn;	/* Number of faces for the lip cylinder. Can be = $fn */
silencer_lips_groove		= 2.1;	/* Add a groove for an o-ring on each lip: this is the thickness
					   of the o-ring.
					   If you activate it (>0), the lips diameter are reduced by
					   1mm to let the o-ring have a nice compression.
					 */

/* Baffles */
silencer_baffle_decal 		= 20.0;	/* attack angle */
silencer_baffle_start		= 15.0;	/* Start of the baffles, must be > silencer_thread_len */
silencer_baffle_size 		= 1.80;	/* Ratio on caliber */
silencer_baffle_concentric	= 4;	/* concentric reduction:
					   (3 means baffles: 3*size,2*size,1*size,1*size,...) */

silencer_baffle_open		= 70;	/* Opening angle of the baffle (works with foam and lips)
					   0 for closed baffle
					 */

silencer_pins_dia		= 1.6;	/* Pins diameter: 0 to disable */


/* Printing helper */
silencer_brim_close		= 0.4;	/* Integrate structure closing to allow the printing option:
					   "Brim > Only on Outside".
					   It saves you from the painful process of removing the brim
					   from the baffles.
					 */

/* / End of Configuration */
```


## Happy? [tip me ;)](https://www.paypal.com/paypalme/GuillaumePlayground)

