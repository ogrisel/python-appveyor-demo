python-appveyor-demo
====================

Demo project for building [Python wheels](http://pythonwheels.com/) for Windows
with appveyor.com.

Appveyor is a continuous integration platform similar to travis-ci.org but for
the Windows platform. Appveyor is free for Open Source projects and runs on the
Microsoft Azure cloud infrastructure.

This sample Python project has a simple C compiled extension (statically
generated from a Cython source file in this case). The build itself is
configured by in the `setup.py` file.

This project is meant to document a minimalistic yet working example to help
other Python project maintainers.


Continous integration setup with appveyor.com
---------------------------------------------

The `appveyor.yml` file in this repo configures a Windows build environment for
both for 32 bit and 64 bit Python 3 compiled extensions. This demo project is
configured to trigger build jobs at:

  http://ci.appveyor.com/project/ogrisel/python-appveyor-demo

In particular the `appveyor/install.ps1` powershell scripts download and
install Python and and pip to grab all the development dependencies of the
project as registered in the `dev-requirements.txt` file.

The `appveyor/setup_build_evn.cmd` batch script optionally configures
environment variables to activate the 64 bits MSVC++ compiler from the Windows
SDK.

Note: only the version 7.1 of the Windows SDK is installed on the appveyor
worker at the time of writing. This  means that it is currently not possible to
build extensions binary compatible with Python 2.7. This current setup only
works for Python 3 packages.

The content of the `dist/` folder (typically hosting the generated `.whl`
packages) is archived in the build report (see previous link).


Building and testing locally from source
----------------------------------------

Here are the instructions to replicate the build steps manually.

Install developer dependencies (only nose and wheel at this time):

    pip install -r dev-requirements.txt

You can then build with:

    python setup.py sdist bdist_wheel

The generated source tarball and platform specific `.whl` package can be found
in the `dist` subfolder.

Install the `.whl` package with with:

    pip install dist/python_appveyor_demo-1.0-*.whl

Finally run the tests (from any folder by the source tree):

    nosetests -v pyappveyordemo

Under Windows you might to install the Windows SDK to build the compiled
extension with the MSVC++ compilers. See the following for details:

  https://github.com/cython/cython/wiki/64BitCythonExtensionsOnWindows
