Extending setup.py install commands
#####################################################

:date: 2015-03-11 07:15:06
:tags: python, setuptools, package, commands, hacks
:category: programming
:author: Łukasz Bołdys

Lately one of my associates asked if there is a way to use different
*install_requires* lists in *setup.py* depending on way of installing.

If you are doing :code:`python setup.py install` you would get one set of requires and doing :code:`python setup.pl develop` would give you another set of requires (either extended or totally different).

Here's my solution:

.. code-block:: python

    #!/usr/bin/env python
    # coding=utf-8

    from setuptools import setup, find_packages
    from setuptools.command.develop import develop

    requires = [
        'fabric',
        'pelican'
    ]


    class ExtendedDevel(develop):
        ''' Adding ipython to requirements '''
        def run(self):
            requires.append('ipython')
            develop.run(self)


    setup(name='lalala',
          version='0.0.1',
          description='That\'s stupid',
          long_description='DESCRIPTION',
          classifiers=[
          ],
          author='Łukasz Bołdys',
          author_email='mail@utek.pl',
          url='',
          keywords='',
          license='LICENSE',
          packages=find_packages(),
          include_package_data=True,
          zip_safe=False,
          test_suite='test',
          install_requires=requires,
          cmdclass={'develop': ExtendedDevel}
          )


Using this code in *setup.py* will install *fabric*, *pelican* and *ipython* when doing :code:`python setup.py develop` but will only install fabric and pelican if installing via :code:`python setup.py install`.

If you don't want to change default behavior of *develop* you can add new command with changing :code:`cmdclass={'develop': ExtendedDevel}` to :code:`cmdclass={'newcommand': ExtendedDevel}`.
