---
title: New data source for OpenAviationMap, OpenAir, and with it a new parser!
date: 2012-03-12
author: Morten Olsen Lysgaard
tags: coding, haskell, OpenAviationMap
slug: new-data-source-for-openaviationmap-openair-and-with-it-a-new-parser
---

I've been working on a parser for the
[OpenAir](http://www.winpilot.com/usersguide/userairspace.asp) format
this weekend. As usual I like to work in Haskell. The
[Parsec](http://www.haskell.org/haskellwiki/Parsec) library makes sense
when creating parsers. You build up a parser from simpler parser, and in
the end , you're sitting with a parser for a whole language, it's known
as the parser combinator approach.\
Parsing OpenAir gave me some special challenges. OpenAir is not what I
would call an data format, but more a program. It's a list of
instructions, and if you follow them, you will create an airspace. This
is very non declarative, very non haskell. Therefore it makes it a
challenge to parse it in haskell. Thanks to parsecs mutable state,
everything got together.\
I'm starting to think that OpenAir really needs a touchup though.
OpenAir has choosen a data is programs approach, it feels really
unatural. Maybe using YAML as a carrier format together with a schema
specification on what attributes an airspace has would be
more fruitful?\
The instant benefit with my new parser is: Germany! We've now got
complete and official coverage of Germany's airspaces. That's no small
feat for a hobby project! Hungary is coming along nicely to thanks to
Ákos' work on an eAIP parser. That will allow us to parse airspaces for
all countries that has an eAIP, and that's actually some =)\
The code is available in my
[github](https://github.com/molysgaard/OsmXmlTool)
