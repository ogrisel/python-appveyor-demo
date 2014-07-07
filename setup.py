from setuptools import setup, Extension


extension_module = Extension(
    'pyappveyordemo.extension',
     sources=['pyappveyordemo/extension.c']
)


setup(
    name = 'python-appveyor-demo',
    version = '1.0',
    description = 'This is a demo package with a compiled C extension.',
    ext_modules = [extension_module],
    packages=['pyappveyordemo', 'pyappveyordemo.tests'],
)
