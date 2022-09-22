# Cover letter

I am a pragmatic R&D engineer as well as a team leader.
My education has given me a solid background in applied mathematics and physics, with a focus on simulation, modeling, and implementation of this in C++/Rust.

I co-founded a successful auto-follow drone startup, [The Staaker Company](https://www.youtube.com/c/staaker), in 2014, as CTO, and led it through its first product, mass production, and eventually acquisition.

I have led teams of mechanical, electrical, embedded, and software engineers, researchers, and scientists, in complex drone-related projects since 2014.

In both The Staaker Company and Nordic Unmanned I have made significant contributions to our codebase.
My specialty is code which requires an understanding of geometry, physics, modeling, rigid body dynamics,
numerical analysis, 3D projections, orientation, and so forth.
Because I have been the only one with this competence on the teams I have worked with, my
contributions to our C++ codebase have been essential for our success.

On the Staaker Drone, one of my responsibilities was setting the rules for how we could develop our code so that
it would be safe to fly. After all, a rouge drone is dangerous.
Our design for safety was comprehensive:

* CI tests testing every commit in a fully simulated environment for correctness.
* CI unit tests for testing small-grained correctness.
* Absolutely no dynamic memory in our binaries. Custom linker script for erroring if linking `malloc`/`free`/`new`/`delete`
* No pointers outside the lowest level of driver code.
* `-Werrror` + enable all warnings, on most modern clang distribution. We are currently on C++20 with clang14.
* _Very_ safety-oriented culture around API design, PR-reviews, and similar.
* Lots, lots lots of other considerations to create safe dependable code.
* The past year, I have moved our team to do greenfield development in Rust. This has been a great success. We have seen around a 2x improvement in time to do PR reviews, and a lot less time spent debugging runtime bugs.

I am a builder of both technology and teams, and I would like to be able to look back on my career and say that I built some incredible things.

What convinced me of applying to Nuro, and differentiated Nuro from the rest,
is watching Albert Meixner explain your Autonomy Stack.
The systematic engineering approach to the tough problem of creating a self-driving car,
speaks straight to my heart. 

I think I could be an ideal candidate for your controls, simulation, planning, or perception team, and would love to get to know Nuro more.

Please read my attached CV.
I can also suggest my homepage <http://mortenlysgaard.com> as it gives a more interactive overview of my work.

\vspace{2em}


Regards Morten Lysgaard

VP Software & Systems Engineering

Nordic Unmanned