Wireless Charging Stand
=======================

This is a customizable model of a wireless charging stand for phones and
tablets.  You can tell it what kind of phone/tablet you have, and which
wireless charger you'd like to use, and it will generate a 3D-printable
stand model to suit your devices.

To use it::

  git clone https://github.com/jgilik/wireless-charging-stand
  cd wireless-charging-stand
  ./configure.sh

The output of `configure.sh` contains the `openscad` command to compile the
model to a 3D-printable STL file.

Using `configure.sh` on Windows requires a Windows build of Bash.  Cygwin or
gnuwin32 may be a good start on that.


Building OpenSCAD
-----------------

You need OpenSCAD to compile the model at the moment.  The following are
instructions to build the latest version of OpenSCAD on Ubuntu, as 14.04 LTS
does not have this version pre-packaged::

  # Install dependencies not captured by build scripts.
  sudo apt-get install libxmu-dev libqscintilla2-dev bison flex

  # Get latest OpenSCAD release.
  version=2015.03
  wget "https://github.com/openscad/openscad/archive/openscad-$version.tar.gz"
  tar -zxvf "openscad-$version.tar.gz"
  cd "openscad-openscad-$version/"

  # Build dependencies.
  source ./scripts/setenv-unibuild.sh
  ./scripts/uni-build-dependencies.sh

  # Build OpenSCAD.
  qmake openscad.pro
  make

  # "Install" ;)
  alias openscad="$PWD/openscad"
  # Or do:
  # sudo make install

I do not have build instructions for other operating systems.  Binaries are
available for Windows.
