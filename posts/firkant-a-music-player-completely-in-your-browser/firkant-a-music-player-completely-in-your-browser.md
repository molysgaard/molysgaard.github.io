---
title: Firkant, a music player, completely in your browser!
date: 2012-08-25 14:56:00
author: Morten Lysgaard
tags: ampache, chrome, cloud music, coding, file api, firkant, html5, javascript, open source, web app
slug: firkant-a-music-player-completely-in-your-browser
thumbnail: firkant.jpg
summary: 'Firkant is a music player that runs solely in the browser. It streams music from a server using the new HTML5 apis.'
---

I'm found of music, it colors my day. This also applies to the rest
of my family. Because of that I've set up an
[Ampache](http://ampache.org) server where we add our music. This makes
it really easy to discover new music and listen to eachothers
suggestions. | The only problem with Ampache is that all the clients,
well, they suck. There are a lot of half finished plugins, small tests
etc. but no real client that just works. Works cross platform. Lets you
cache music so that you can listen to it while offline etc. All these
nicks and picks made me so frustrated that I started rolling my own. I
wanted this:

-   Browse artist/album/track
-   Cache things so they are available offline
-   Be truely cross platform

I started hacking at an already existing python player
[Quickplayer](http://quickplay.ampache.org/). It worked out ok untill I
needed to change the interface while keeping it cross platform. I
realized that this would never work. | After some thinking I started
wishing I could've done it as a webpage, that would be esay except for
the "offline" mode. I read around the net and discovered that Chrome
apps actually can be offline, as well as get permissions to
XMLHttpRequst to an arbitrary host. This combined with the new File Api
support was all I needed. I started coding and in about 3-4 days I had a
finished player.

![image](firkant.jpg)

It's written as a Chrome app, that is a tottally normal webpage only
that it's hosted from your harddrive. It also has relaxed access control
allow origin so that I can communicate with the webserver that runs the
Ampache instance.\
It lets you create your own subset library from that is cached locally,
enabeling you to listen to your music wherever you've got your laptop.\
To view it in the [Chrome Web
Store](https://chrome.google.com/webstore/detail/aneedkfapngamfeiohfinebehkekgkll).\
The code is available at
[GitHub](https://github.com/molysgaard/Firkant).\
Cheers!
