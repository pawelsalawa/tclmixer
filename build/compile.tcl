#!/usr/bin/env tclsh

# Libraries for static linking:
set SDL_mixer [file join usr lib libSDL_mixer.a]
set SDL [file join usr lib libSDL.a]
set vorbisfile [file join usr lib libvorbisfile.a]
set vorbis [file join usr lib libvorbis.a]
set ogg [file join usr lib libogg.a]
#########################################

if {$tcl_platform(platform) == "unix"} {
	foreach v "SDL_mixer SDL vorbisfile vorbis ogg" {
		set $v [file separator][set $v]
	}
}

set DIR [file join [lindex [file split [pwd]] end]]
set PKGDIR [file join $tcl_pkgPath $DIR]

set install 0
set static 0

if {$argv != ""} {
	foreach opt $argv {
		switch -- $opt {
			"--install" {
		set install 1
			}
			"--compile-static" {
		set static 1
			}
		}
	}
} else {
	puts -nonewline "Shell I install package into $PKGDIR? \[Y/n]: "
	flush stdout
	gets stdin yn
	if {$yn == "" || [string tolower $yn] == "y"} {
		set install 1
	}
	puts -nonewline "Shell I compile static library additionaly? \[y/N]: "
	flush stdout
	gets stdin yn
	if {[string tolower $yn] == "y"} {
		set static 1
	}
}

set sudoing 0
catch {exec whoami} isroot
if {$install && $isroot != "root"} {
	puts "You're not root. Getting Super-User privileges..."
	set sudoing 1
	if {[catch {exec su -c "$argv0 --install [expr {$static?"--compile-static":""}]"} result]} {
		puts "Error while installing or compiling:\n$result"
		if {[file exists errors.log]} {
			set fd [open errors.log r]
			puts [read $fd]
			close $fd
			file delete -force errors.log
		} else {
			puts "Wrong password."
		}
		exit 1
	}
	puts "Compilation and installation finished!"
	puts "Package installed in $PKGDIR"
	exit 0
}

file delete -force [file join src tclmixer.so]
if {[catch {
	exec sh -c "gcc -c -o [file join src tclmixer.o] -DUSE_TCL_STUBS `sdl-config --cflags` [file join src tclmixer.c]"
	exec sh -c "gcc -shared -o [file join src tclmixer.so] `sdl-config --libs` -lSDL_mixer [file join src tclmixer.o]"
	if {$static} {
		file mkdir [file join src static]
		exec bash -c "gcc -shared -o [file join src static tclmixer.so] [file join src tclmixer.o] $SDL_mixer $SDL $vorbisfile $vorbis $ogg -lpthread -lm -ldl -L/usr/X11R6/lib -lX11 -lXext -ltclstub"
	}
} result]} {
	set fd [open errors.log w+]
	puts $fd $result
	close $fd
	if {!$sudoing} {
		puts "Error while installing or compiling:\n$result"
		if {[file exists errors.log]} {
			set fd [open errors.log r]
			puts [read $fd]
			close $fd
			file delete -force errors.log
		} else {
			puts "Wrong password."
		}
	}
	exit 1
}

if {$install} {
	file mkdir $PKGDIR
	file copy -force [file join src tclmixer.so] [file join $PKGDIR tclmixer.so]
	file copy -force [file join src pkgIndex.tcl] [file join $PKGDIR pkgIndex.tcl]
}
