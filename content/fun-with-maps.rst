Fun with maps
#############

:date: 2013-08-13 13:23
:tags: javascript, openlayers, maps, image
:category: programming
:author: Łukasz Bołdys

While working on my geo enabled appliction I wondered if one could
use data from Blitzortung.org_ to display map of lightings.

I'm using OpenLayers_ to display map using data from OpenStreetMap.
So to display data from Blitzortung.org_ I needed to create new layer.
But instead of using :code:`OpenLayers.Layer.OSM` I'm using :code:`OpenLayers.Layer.XYZ`.

.. raw:: html

    <!-- summary -->

.. code-block:: javascript

    var lightings_15 = new OpenLayers.Layer.XYZ(
        "0-15 minutes", [
            "http://images.lightningmaps.org/blitzortung/europe/index.php?tile&zoom=${z}&x=${x}&y=${y}&type=0"
        ], {
            attribution: "Lightning data from <a href='http://blitzortung.org'>Blitzortung.org</a>",
            tileSize: new OpenLayers.Size(1024, 1024),
            transitionEffect: "resize",
            isBaseLayer: false,
            visibility: true,
            sphericalMercator: true
        }
    );

To "refresh" lightings map I created small function that replace url in
:code:`lightings_15` layer and force redraw on that layer.

.. code-block:: javascript

    var url = "http://images.lightningmaps.org/blitzortung/europe/index.php?tile&zoom=${z}&x=${x}&y=${y}&type={type}&bo_t={date_str}";

    function updateLayer() {
        var date = new Date();
        date_str = date.getUTCDate() + "_" + date.getUTCHours() + "_" + date.getUTCMinutes();
        new_url = url.replace("{type}", i);
        new_url = new_url.replace("{date_str}", date_str);
        lightings_15.url[0] = new_url; // As we have only one url in layer XYZ
        if (lightings_15.visibility){
            lightings_15.redraw({
                force: true
             });
        }
    };


Finally after page load I'm setting interval using :code:`setInverval` and defined
`updateLayer` function

.. code-block:: javascript

    setInterval(updateLayer, 5*60000);


Check example_

Todo:

- Some sort of cache of Blitzortung.org_ layer
- Improve visibility

.. _Blitzortung.org: http://blitzortung.org/
.. _OpenLayers: http://openlayers.org/
.. _example: http://utek.pl/examples/fun-with-maps/