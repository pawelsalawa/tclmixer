@echo off

REM If you want to compile TclMixer manually, you have to edit this file
REM and change values of variables below.

set TCL_INCLUDE=C:\Tcl\include
set TCL_LIBS=C:\Tcl\lib
set TCL_STUB_LIB=tclstub84

set SDL_INCLUDE=C:\projects\sdl\include
set SDL_MIXER_LIB=C:\projects\sdl\lib\SDL_mixer.dll
set SDL_LIB=C:\projects\sdl\lib\SDL.dll

set GCC_APP=gcc

REM ***************** End of configuration ***************

@echo on

%GCC_APP% -c -o src\tclmixer.o -DUSE_TCL_STUBS -DWINDOWS -I%TCL_INCLUDE% -I%SDL_INCLUDE% src\tclmixer.c
%GCC_APP% -shared -o src\tclmixer.dll src\tclmixer.o %SDL_MIXER_LIB% %SDL_LIB% -L%TCL_LIBS% -l%TCL_STUB_LIB%
