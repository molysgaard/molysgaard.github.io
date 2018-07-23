---
title: Example Smoothed-particle hydrodynamics with C and OpenMP
date: 2014-01-29
author: Morten Olsen Lysgaard
tags: algorithms, c, coding, openmp, sph
slug: example-smoothed-particle-hydrodynamics-with-c-and-openmp
thumbnail: '<div class="videoWrapper"><iframe width="580" height="320" src="https://www.youtube-nocookie.com/embed/Jbybort1F5Q?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe></div>'
thumbnailtype: video
---

I am interested in ways of approximating differential equations
numerically. Yeasterday I read up on the basics of Smoothed-Particle
Hydrodynamics, or SPH for short. It is a way of approximating a PDE
using a finite set of particles that represent a quantity, eg. a fluid.
To read more about the basics of the method take a look at this
[PDF](http://image.diku.dk/kenny/download/vriphys10_course/sph.pdf).\
The algorithm was first prototyped is Octave (Matlab) and found to slow.
Then I coded a native C version with SDL graphics and OpenMP to speed up
some of the calculations, it worked pretty well. The code is available
at my [GitHub](https://github.com/molysgaard/navierstokes). A video
showing the live rendering is embedded below.\
 

<div class="separator" style="clear: both; text-align: center;">
<div class="videoWrapper"><iframe width="580" height="320" src="https://www.youtube-nocookie.com/embed/Jbybort1F5Q?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div></div>

As the video shows the liquid is extremely pressure driven and thus
does not represent incompressible liquids, like water. The physical
correctness of this simulation as a whole has to be taken with a grain
of salt because of the extremely simple implementation. But it serves as
a very *visual* way of communicating how the method works and what
strengths/weaknesses it has. | One nice property is that the method
conserves mass.
