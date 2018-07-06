---
title: OpenAviationMap technical crash cource
date: 2012-02-03 23:15:00
author: Morten Olsen Lysgaard
tags: OAM, OpenAviationMap, OpenStreetMap, OSM
slug: openaviationmap-technical-crash-cource
---

So how does this OpenAviationMap tick? I'll try to explain as condensed
as possible.\
The main part is a web application written in Ruby called [Rails
Port](http://wiki.openstreetmap.org/wiki/The_Rails_Port). It handles
users, and the map API. This is an XML API that lets users send in
changes to the map.\
To edit the map we have [JOSM](http://josm.openstreetmap.de/). It's a
Java application written for [OpenStreetMap](http://osm.org). It lets
you draw things on the screen and give it tags. Then you can press
upload, enter username and password, and
[JOSM](http://josm.openstreetmap.de/) posts your beautiful drawing to
the API.\
The [Rails Port](http://wiki.openstreetmap.org/wiki/The_Rails_Port)
application then receives this and stores it in a
[PostGIS](http://postgis.refractions.net/) enabled
[PostgreSQL](http://www.postgresql.org/) database.\
All changes to the map are incremental. That means that you can
individually revert changes, much like on Wikipedia or VCS's like GIT or
SVN. This gives us the power to let everyone with an account edit the
map by default, because no one can do irreplaceable damage.\
To view the map I'm using [OpenLayers](http://openlayers.org/), written
in JavaScript. I serve the
[OpenAviationMap](http://openaviationmap.org/) data from the database
via some custom code as WFS to [OpenLayers](http://openlayers.org/)
which displays it appropriately over (currently) a Google physical base
map.
