switch -- $tcl_platform(platform) {
	windows {
		package ifneeded TclMixer 1.2.3 {
			set tmp_cwd [pwd]
			cd $dir
			load tclmixer.dll
			cd $tmp_cwd
			unset $tmp_cwd
		}
	}
	unix {
		package ifneeded TclMixer 1.2.3 [list load [file join $dir tclmixer.so]]
	}
}
