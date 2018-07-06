---
title: Barnes & Hut orbital simulator
date: 2011-06-30 22:18:00
author: Morten Olsen Lysgaard
tags: algorithms, Barnes amp; Hut, coding, haskell, orbit, simulator
slug: barnes-hut-orbital-simulator
---

After browsing Reddit one day I discovered a cool to me unknown
algorithm, Barnes & Hut. I found a explenation of it
[here](http://arborjs.org/docs/barnes-hut). I got some spare time now
because of a flu/fever attack so I thought why not try to make something
fun out of it. I setteled on a n-body orbital simulator with collisions.
The algorithms where quite easy to jot down in Haskell, but I really
struggeled on the visualization. In the end I did it the easy way. Each
step, an SVG is created. Then a little imagemagik and ffmpeg magic makes
a movie of it. I'm quite happy with the end result but I'd love to get
better visualization, maybe OpenGL. If someone has an idea mail me =)\
You can get the code from my
[github](https://github.com/molysgaard/BarnesHut).\
Here's a video:
[orbit](http://mortenlysgaard.com/wordpress/wp-content/uploads/2011/06/orbit.mp4)\
Update: I've managed to hack together an OpenGL visualizer. It's not
very quick but it works for the purpose of demonstrating. I've also done
some optimizations and profiling to get the code to run a bit faster,
the updates source is on github.\
 \
PS. This post, and the code is written during a fever, so no refunds for
eye-strain, errors etc. :P
