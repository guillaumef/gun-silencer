
#  The ultimate parametric silencer / moderator for airgun / bbgun / airsoft

## Project description

This design allows to generate a unique baffle
silencer exactly fitting your gun/rifle:

- with external tube or not (like carbon fiber tube)
- with an "over the barrel" tube or not
- fully tunable: number/size/progressiveness of sound traps
- easy cleaning - two parts
- all caliber compatible
- all metric ou unf threads
- 2 printing modes (depending on your printer efficiency)

<img src="https://github.com/guillaumef/gun-silencer/blob/main/examples/example1.jpg" width="300" alt="silencer moderator airgun bbgun airsoft" align="center" /> <img src="https://github.com/guillaumef/gun-silencer/blob/main/examples/example2.jpg" width="300" alt="silencer moderator airgun bbgun airsoft" align="center" />

<img src="https://github.com/guillaumef/gun-silencer/blob/main/examples/example3.jpg" width="300" alt="silencer moderator airgun bbgun airsoft" align="center" />


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

silencer_len                    = 180;  /* printed part length */
silencer_tube_int_dia           =  28;  /* tube (provided) internal diameter */
silencer_tube_ext_dia           =  30;  /* tube (provided) external diameter. Can be equal to int_dia */
silencer_tube_barrel_dia	=  28;	/* inferior to silencer_tube_int_dia if needed, in contact with
					   the barrel */
silencer_foam_thickness		=   0;	/* foam or air chamber between the tube (provided) and this part
					   0  : for straight tube.
					   >0 : activates the lips part.

silencer_struct_thickness       = 1.5;  /* Global structure thickness */

silencer_thread_len             =  12;  /* threaded part of the rifle */
silencer_thread_type            = "20-UN-1/2";  /* Listed in libs/threadlib/THREAD_TABLE.scad */
silencer_thread_scale2fit       = 1.0;  /* x/y scale ratio to fit >=1.0, 1.003 for 3% tolerance */

silencer_caliber                = 8;    /* Add a margin here, ~ 1.5mm */

silencer_lips_thickness         = 5.0;  /* External lips in contact with the tube (provided).
                                           0 for no lips at all (no external lip flush with tube_ext_dia) */
silencer_lips_number            = 5;    /* Number of lips */
silencer_lips_rounded           = 1;    /* Are they rounded, and how much.. */
silencer_lips_fn                = 20;   /* Number of faces for the lip cylinder. Can be = $fn */

silencer_soundtrap_decal        = silencer_struct_thickness * 3.5;      /* attack angle */
silencer_soundtrap_start        = 20;   /* Start of the soundtraps, must be > silencer_thread_len */
silencer_soundtrap_size         = 1.0;  /* Ratio on caliber */
silencer_soundtrap_concentric   = 4;    /* concentric reduction:
                                           (3 means soundtraps: 3*size,2*size,1*size,1*size,...) */
silencer_pins_dia               = 1.0;  /* Pins diameter: 0 to disable */

silencer_brim_close             = 0.4;  /* Integrate structure closing to allow the printing option:
                                           "Brim > Only on Outside".
                                           It saves you from the painful process of removing the brim
                                           from the soundtraps.
                                         */
/* / End of Configuration */
```


## Happy? [tip me ;)](https://www.paypal.com/paypalme/GuillaumePlayground)

