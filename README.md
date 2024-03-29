python-appveyor-demo
====================

[![AppVeyor](https://img.shields.io/appveyor/ci/ogrisel/python-appveyor-demo.svg)](https://ci.appveyor.com/project/ogrisel/python-appveyor-demo/history)

Demo project for building Windows [Python wheels](http://pythonwheels.com/)
using https://appveyor.com. It supports both Python 2 and 3 on 32 and 64 bit
architectures.

AppVeyor is a continuous integration platform similar to travis-ci.org but for
the Windows platform. AppVeyor is free for Open Source projects and runs on the
Microsoft Azure cloud infrastructure.

This sample Python project has a simple C compiled extension (statically
generated from a Cython source file in this case). The build itself is
configured by in the `setup.py` file.

This project is meant to document a minimalistic yet working example to help
other Python project maintainers.


Continuous integration setup with AppVeyor
-----------------------------------------

The `appveyor.yml` file in this repo configures a Windows build environment for
both for 32 bit and 64 bit Python compiled extensions. This demo project is
configured to trigger build jobs at:

  https://ci.appveyor.com/project/ogrisel/python-appveyor-demo

In particular:

  - the `appveyor/install.ps1` powershell script downloads and
    installs Python and and pip to grab all the development dependencies of the
    project as registered in the `dev-requirements.txt` file.

  - the `appveyor/run_in_env.cmd` batch script configures environment variables
    to activate the MSVC++ compiler from the Windows SDK matching the Python
    version and architecture.

The content of the `dist/` folder (typically hosting the generated `.whl`
packages) is archived in the build report (see previous link).

**Note**: it is possible to activate the "Rolling builds" option to
automatically cancel build on intermediate push events to avoid clogging
the build queue with useless jobs. However it can be problematic as it can
cancel builds triggered by direct push to master outside of any PR. Instead
the `appveyor.yml` file of this repo uses a specific powershell snippet
to quickly fail if a newer build is queued for the same PR.


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

  https://github.com/cython/cython/wiki/CythonExtensionsOnWindows


Credits
-------

Thanks to Feodor Fitsner (@FeodorFitsner) from AppVeyor for the fast support
and for installing the old versions of the Windows SDK required to build
Python projects.

Thanks to Thomas Conté (@tomconte) from Microsoft for your help in scripting
Windows SDKs and MSVC build environments usage.


License
-------

The source code in this repo is either licensed under CC0 (see `LICENSE`) or
the following MIT license at your choice:

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
