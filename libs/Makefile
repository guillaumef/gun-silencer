
all:
	@cd .. && git submodule update --init --recursive
	@curl -s -o thread_profile.scad https://raw.githubusercontent.com/MisterHW/IoP-satellite/master/OpenSCAD%20bottle%20threads/thread_profile.scad

allmanual:
	@git clone https://github.com/adrianschlatter/threadlib.git
	@git clone https://github.com/openscad/scad-utils.git
	@git clone https://github.com/openscad/list-comprehension-demos.git

clean:
	@rm -Rf threadlib scad-utils list-comprehension-demos thread_profile.scad

