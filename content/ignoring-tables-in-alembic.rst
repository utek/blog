Ignoring tables in Alembic
##########################

:date: 2013-08-12 21:25
:tags: python, alembic, sqlalchemy
:category: programming
:author: Łukasz Bołdys

While working on spatial enabled application I came up to a problem
with spatial table in my postgres database (`spatial_ref_sys`).
Alembic_ insisted on deleting this table as it wasn't declared in my `models.py`.

I didn't wanted to define it just to keep Alembic_ from removing it so
I've added following changes to `.ini` and `env.py` files:

.. raw:: html

    <!-- summary -->

development.ini
---------------
.. code-block:: ini

    [alembic:exclude]
    tables = spatial_ref_sys


env.py
-------

..  code-block:: python

    def exclude_tables_from_config(config_):
        tables_ = config_.get("tables", None)
        if tables_ is not None:
            tables = tables_.split(",")
        return tables

    exclude_tables = exclude_tables_from_config(config.get_section('alembic:exclude'))

    def include_object(object, name, type_, reflected, compare_to):
        if type_ == "table" and name in exclude_tables:
            return False
        else:
            return True

    def run_migrations_online():
        if isinstance(engine, Engine):
            connection = engine.connect()
        else:
            raise Exception('Expected engine instance got %s instead' % type(engine))

        context.configure(
            connection=connection,
            target_metadata=target_metadata,
            include_object=include_object
        )

        try:
            with context.begin_transaction():
                context.run_migrations()
        finally:
            connection.close()


.. _Alembic: http://alembic.readthedocs.org/en/latest/