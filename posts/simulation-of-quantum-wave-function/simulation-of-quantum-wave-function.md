---
title: Simulation of quantum wave function
date: 2012-02-16
author: Morten Lysgaard
tags: coding, physics, simulation
slug: simulation-of-quantum-wave-function
---

Had a lecture in quantum mechanics today, we've been starting to get
serious and are now working with arbitrary 1 dimentional potentials.
While doing the work I feelt desperatly in need of some visualization.
Therefore I packed together a little simulation in haskell this
afternoon. Now, Haskell is the right tool for this kind of job. The
whole program is just 63 lines of code, and they're ugly too. I bet that
it could be crammed down if one wanted. Anyways, Haskell is so great at
this stuff for many reasons. For example it lets me define Numerical
instances of functions, that mean that i can add two functions together,
*before* I give them the arguments. This is great for building up
complex mathematical functions. In the future I'd like to extend this
example to generate a wavefunction for an arbitrary potential. This
requires solving differential equations though, I don't think Haskell's
typesystem is up for that yet. Anyway I'd be interested in ways to
express maths, especially differential equations in Haskell, if you have
any ideas, tell me!\
The code, as always is available at
[github](https://github.com/molysgaard/kvante)

The video represent the wave function of a quantum particle in a box.
Unlike normal things in day to day life, quantum partilces doesn't have
a defined possition, they have a probability of being at given
possitions. The y axis of this animation represents the probability of
finding the particle at a given point. This specific example is the
superpossition of the 4 first exited states of a box particle. As you
see, the "possition" that is where you would expect to find the particle
changes with time. That mean we have a moving particle. That might not
sound strange, but if i say that each of the 4 exited states in
themselves are stationary, they don't move at all, then things start to
become interesting. The thing is that by superpositioning differnt
static states, you can create a new state, that is dynamic, and thus
move; exciting!\
The video is generated from a series of pictures output by my haskell
program. Since I don't know of any good way to create interactive plots
in haskell, and this was an 2-hour evening project i decided to go for:
Loads of images -&gt; ffmpeg -&gt; video -&gt; profit!
