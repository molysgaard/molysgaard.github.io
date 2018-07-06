---
title: Sirkel released!
date: 2011-09-17
author: Morten Olsen Lysgaard
tags: Chord, coding, DHT, haskell, Sirkel
slug: sirkel-released
---

The first release of Sirkel was released today! It contains an
implementation of the Chord DHT, and a simple storage layer with fault
tolerance and replication, much similar to DHash. The DHT uses the not
yet released Cloud Haskell framework with it's Erlang primitives for
concurrency. It's still in it's very early stages but I've done a lot of
testing and it should be reasonably stable.\
[Hackage](http://hackage.haskell.org/package/sirkel-0.1)\
[Github](https://github.com/molysgaard/Sirkel)\
[CloudHaskell](https://github.com/jepst/CloudHaskell)\
Right now, this is what the DHT can do: You can run it on a local
network, LAN, and in theory also on hosts directly connected to the
internet, no NAT. Each node gets responsebility for a part of the
key-space in the DHT. Then you can "put" and "get" all objects that are
instances of Binary in and out of it. If a node leaves or disconnects,
other nodes dynamically takes over the responsibility of the keys to the
left node and no data is lost.\
The protocol is not secure, and there is no authentication, that is, you
have to trust all nodes is your system. This is an area of research and
it would be really exiting to implement some sort of security into the
DHT.

Now that the DHT layer is complete a lot of new doors have opened. How
cool wouldn't it be to make  a distributed file-system with no single
point of failure, no master controller? That's one of the things a DHT
can achieve, it's structure is totally flat, and no-one is better, has
more knowledge or power than anyone else. If you think distributed
computing is fun, and would love a hobby project, join me in discovering
what can be done with a DHT in Haskell!
