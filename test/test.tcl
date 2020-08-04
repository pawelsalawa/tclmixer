#!/usr/bin/tclsh

load ../src/tclmixer.so

# Loop finish handle
set sleep 0
proc a {} {
    global sleep
    set sleep 1
}
tclmixer::setCallback MUSIC a

# Music
set m [tclmixer::music test.mod]
tclmixer::play $m

# Reload sound
set snd [tclmixer::sound reload.ogg]
tclmixer::play $snd

# Entering loop
while {!$sleep} {after 1000}

