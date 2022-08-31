---
date: 2023-01-01 08:00:00
author: Morten Lysgaard
tags: linear-systems, solvers, optimization
slug: numerical-solvers
title: Numerical solvers
---

# Multifrontal sparse symmetric linear solver

Key characteristics:

* Designed for: sparse, symmetric, indefinite systems.
* Efficient for sparse KKT-systems from constrained optimization, saddle point systems and similar from DAEs Differential Algebraic Equations and similar.
* Single-core implementation. Thread-based paralellization planned.

## C-API

* Download: [liblindefsol.so](/files/solvers/liblindefsol.so) [lindefsol.h](/files/solvers/lindefsol.h)
* Tested on Ubuntu 20.04, uses minimal system calls, should work on almost any modern Linux distribution.


# Nonlinear constrained optimization solver compiler

Based on a nonlinear interior-point penalty method with the multifrontal sparse symmetric linear solver as its main workhorse.

Key characteristics:
* Optimized for fast solutions to medium sized problems, eg. real-time optimal control.

Following workflow:

* Create nonlinear model description using a `.json` file.
* Compiler takes as input the `.json` file, and outputs an optimized nonlinear solver for the given problem.
* The optimized linear solver is output as a C-library, with a standard C-interface.

* Download: [liboptimizer.so](/files/solvers/liboptimizer.so) [optimizer.h](/files/solvers/optimizer.h)
* Tested on Ubuntu 20.04, uses minimal system calls, should work on almost any modern Linux distribution.
