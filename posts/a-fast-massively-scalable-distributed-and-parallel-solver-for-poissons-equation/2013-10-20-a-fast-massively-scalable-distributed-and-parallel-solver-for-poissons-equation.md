---
date: 2013-10-20 09:34:00
author: Morten Lysgaard
slug: a-fast-massively-scalable-distributed-and-parallel-solver-for-poissons-equation
title: A fast, massively scalable, distributed and parallel solver for Poisson's equation
archived: true
---


This semester I have been studying at Queensland in Australia, more
specificly at [Queensland University of
Technology](http://www.qut.edu.au/) in Brisbane. Even though most of a
semester abroad is about what happens outside school this post is
focused on school.\
I have taken a course in Parallel Computation at QUT. As a semester
project I created a direct distributed memory solver for Poisson's
equation. The solver is written in plain C taking use of technologies as
OpenMP, BLAS and OpenMPI.\
Compared to a naively written single core solver written in C my
solution had a speedup of 200 on a 50 core cluster. Compared to a
bleedingly optimized sequential implementation taking use of the Intel
MKL library for hand tuned matrix multiply code a speedup of 20 was
measured. The distributed nature of the solver can also cope with much
bigger problems than the sequential implementation. One run was done
over 64 nodes each using 8 cores, that is 512 cores. The problem was a
finite difference discretization with 32000x32000 grid points.
Calculating the solution took only 2 minutes. A sequential
implementation would use take several days to finish. All the code is as
usual available in my [GitHub](https://github.com/molysgaard/poisson)
together with the
[report.](https://github.com/molysgaard/poisson/raw/master/README.pdf)
