---
title: 'New tools for OAM: Import data from OSM to OAM in a batch process.'
date: 2012-02-18 19:10:00
author: Morten Olsen Lysgaard
tags: OpenAviationMap
slug: new-tools-for-oam-import-data-from-osm-to-oam-in-a-batch-process
---

I've done some work on migrating data from the master OSM database over
to our OAM database. The tricky thing here is that when you download
something from OSM, it expects any modifications etc. to be uploaded to
OSM, not another database. To work around this problem I've written an
tool called [OsmXmlTool](https://github.com/molysgaard/OsmXmlTool) in
Haskell. Put simply it does this. Parse an OSM xml file. Create an
internal representation of the data in it using haskells Algebraic
Datatypes. Then it modifies this representation following several rules;
all entities has to get new unique id's etc. Afther that, the datatype
is converted back to XML. This data can be loaded into JOSM, fine tuned
and uploaded.\
To give a idea of how much work this tool saves us. Today i downloaded a
bounding box of Norway with all aviation related features. I put it
trough my tool, and after that into JOSM. Some minor tweaks to some tags
and uploaded. Took me around 10 minutes. In those 10 minutes i had
populated the database of 3000 new entities, runways, hangars, helipads,
taxiways you name it. Haskell is awesome, OSM too!\
To take look at the result, go to
[OpenAviationMap](http://openaviationmap.org/?lat=57.5&lon=20&zoom=5).\
If you wonder how anything is done or have any questions, pop a comment!
I'm maybe thinking of making the tool generic, so that it can be used in
any project that want to migrate OSM data into their own database, tell
me if you're interested.
