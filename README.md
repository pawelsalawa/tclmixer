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

### ChangeLog

#### 1.2.3
* pkgIndex.tcl upgraded to support Windows an Unix independently.
* Added win32compile.bat batch script to allow compile extension manually by all developers under Windows.
* Added different buffer sizes support for unixes and windows.
* Function definitions moved off deprecated style.

#### 1.2.2
* Added stubs support and static library compilation.

#### 1.2.1
* Compilation script upgraded. Added option to just compile and not to install. Then no root password is required.

#### 1.2.0
* "Wrong password" handle for compilation script.
* Deprecated commands: [setChannels] and [setCallback]. Now there is new, one command: [mixConfig] to do their job and more.
* Documentation update.

#### 1.1.0
* Added test.tcl (and needed audio files) for postcompilation tests.
* Added pkgIndex and installation procedure into compile.sh script.
* Compilation and installation script moved to Tcl (from Bash).
* Commands moved to Object model.
