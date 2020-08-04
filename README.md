# TclMixer
TclMixer extension brings SDL_mixer power into Tcl evirnoment.
It allows to play multiple sounds at the same time using built-in
software mixer. It supports following sound formats: WAV/RIFF,
MP3, OGG, MID (midi), MOD (including standart MOD modules,
but also S3M, IT, XM). There are basic effects implemented,
which would be very useful, such as 3D sound positioning,
stereo balance, fading in/out and sound source distance.
There is also pretty low latency for playback.
All these goodies closed in well known, simple Tcl syntax.

To make this extension compile and work, you has to got installed
SDL (in version 1.2.x) and SDL_mixer (in version 1.2.x) libraries.
You can download them from http://www.libsdl.org

NOTE for Windows compilation:
You have to distribute SDL.dll and SDL_mixer.dll with tclmixer.dll
to make it work (in tclmixer extension directory).
