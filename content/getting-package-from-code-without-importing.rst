Getting package version from code without importing
###################################################

:date: 2015-04-07 07:21:22
:tags: python, setuptools, ast, version
:category: programming
:author: Łukasz Bołdys

I use this code for getting version info from package code without importing it, as it has to be installed to be imported and it can't be installed without version number. Classic 'Chicken or the egg' dilema.

I'm using `ast` module from Python stdlib to parse file from package code. In example I'm using `__init__.py` but one can use any other file.

It's works with module level variables (only `string` or `number`) and it's alternative to using `eval()` or `exec()`.

`setup.py`

.. code-block:: python

    # coding=utf-8
    import os
    import ast
    from setuptools import setup, find_packages


    def get_info(filename):
        info = {}
        with open(filename) as _file:
            data = ast.parse(_file.read())
            for node in data.body:
                if type(node) != ast.Assign:
                    continue
                if type(node.value) not in [ast.Str, ast.Num]:
                    continue
                name = None
                for target in node.targets:
                    name = target.id
                if type(node.value) == ast.Str:
                    info[name] = node.value.s
                elif type(node.value) == ast.Num:
                    info[name] = node.value.n
        return info

    file_with_packageinfo = "packagename/__init__.py"
    info = get_info(file_with_packageinfo)

    here = os.path.abspath(os.path.dirname(__file__))
    # README = open(os.path.join(here, 'README.txt')).read()
    # CHANGES = open(os.path.join(here, 'CHANGES.txt')).read()


    requires = [
    ]

    setup(name='packagename',
          version=info.get('__version__', '0.0.0'),
          description='Package description',
          # long_description=README + '\n\n' + CHANGES,
          classifiers=[
              "Programming Language :: Python ",
          ],
          author=info.get('__author__', 'Łukasz Bołdys'),
          author_email='mail@utek.pl',
          url='http://dev.utek.pl',
          keywords='',
          packages=find_packages(),
          include_package_data=True,
          zip_safe=False,
          test_suite='packagename',
          install_requires=requires,
          entry_points="""\
          [console_scripts]
              ddd = packagename.scripts.analyze:main
          """,
          )


`packagename/__init__.py`

.. code-block:: python

    # coding=utf-8

    __version__ = "0.5.1"
    __author__ = "Łukasz Bołdys"


