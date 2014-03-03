Fun with maps II
################

:date: 2013-08-19 15:25
:tags: javascript, openlayers, maps, image
:category: programming
:author: Łukasz Bołdys

`Last time`_ I've created map with overlay that shows lightnings. Unfortunately
standard OpenStreetMaps style is too bright for lightnings to be visible enough.

My solution was to add overlay layer that darken map to enhance visibility of
Bliztordung.org layer. For this I've used `OpenLayers.Layer.Image`. This layer
display provided image on the map (using provided bounds and size).

.. raw:: html

    <!-- summary -->

First. I created `png` image filled black, size 100x100px. Then created ImageLayer:

.. code-block:: javascript

    var shade = new OpenLayers.Layer.Image(
        "Shade",
        "http://utek.pl/examples/fun-with-maps2/darken.png",
        new OpenLayers.Bounds(-20037508, -20037508, 20037508, 20037508.34),
        new OpenLayers.Size(100, 100), {
            isBaseLayer: false,
            visibility: true,
            opacity: 0.5
        }
    );

.. _`Last time`: {filename}fun-with-maps.rst