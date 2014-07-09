python-appveyor-demo
====================

Demo project for building Windows [Python wheels](http://pythonwheels.com/)
using http://appveyor.com.

AppVeyor is a continuous integration platform similar to travis-ci.org but for
the Windows platform. AppVeyor is free for Open Source projects and runs on the
Microsoft Azure cloud infrastructure.

This sample Python project has a simple C compiled extension (statically
generated from a Cython source file in this case). The build itself is
configured by in the `setup.py` file.

This project is meant to document a minimalistic yet working example to help
other Python project maintainers.


Continous integration setup with AppVeyor
-----------------------------------------

The `appveyor.yml` file in this repo configures a Windows build environment for
both for 32 bit and 64 bit Python compiled extensions. This demo project is
configured to trigger build jobs at:

  http://ci.appveyor.com/project/ogrisel/python-appveyor-demo

In particular:

  - the `appveyor/select_sdk.ps1` powershell script determines which Windows
    SDK should be used for a given combination of Python version and architecture.

  - the `appveyor/install.ps1` powershell script downloads and
    installs Python and and pip to grab all the development dependencies of the
    project as registered in the `dev-requirements.txt` file.

  - the `appveyor/setup_build_evn.cmd` batch script optionally configures
    environment variables to activate the 64 bit MSVC++ compiler from the
    Windows SDK matching the Python version.

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

Under Windows will need a Windows SDK to build the compiled
extension with the MSVC++ compilers. See the following for details:

  https://github.com/cython/cython/wiki/64BitCythonExtensionsOnWindows


Credits
-------

Thanks to Feodor Fitsner (@FeodorFitsner) from AppVeyor for the fast support
and for installing the old versions of the Windows SDK required to build
Python projects.

Thanks to Thomas Conté (@tomconte) from Microsoft for your help in scripting
Windows SDKs and MSVC build environments usage.
