---
title: CV
---

# Introduction{.unnumbered}

8 years of experience in R&D drone development. Co-founded successful drone startup, The Staaker Company, during last year of university as CTO. Understands and can lead engineering projects that include mechanical, software, electrical, and cybernetics. Skilled C++ software developer, with specialization in control systems, mathematical modeling, simulation, and optimization. Please check my webpage <http://mortenlysgaard.com> for videos and more in-depth information about my work.

# Education{.unnumbered}

**Norwegian University of Science and Technology, NTNU**                           \hfill   Trondheim, Norway

*Master of Science (M.Sc.) in Applied Physics and Mathematics*                     \hfill       2010 - 2015

\vspace{1em}

**Queensland University of Technology, QUT**                                       \hfill Brisbane, Australia

*Master of Science (M.Sc.) in Applied Physics and Mathematics, exchange semester*  \hfill       2013 - 2013

\vspace{1em}

**Eidgenössische Technische Hochschule, ETH**                                      \hfill Zürich, Switzerland

*Master of Science (M.Sc.) in Applied Physics and Mathematics, exchange semester*  \hfill       2014 - 2014

# Work experience{.unnumbered}

\vspace{1em}

## **[Nordic Unmanned](https://nordicunmanned.com/)** \hfill Oslo, Norway{.unnumbered}
*VP Software & Systems Engineering* \hfill Sept 2019 - currently employed
\vspace{1em}

Nordic Unmanned is the leading drone service company in Europe flying third-party, and proprietary custom drone systems, helicopters, fixed-wing, and multicopter platforms, all unmanned. Nordic Unmanned was the first company in the world awarded the new EASA LUC certification.

I am leading the Software Development team of the R&D Department at Nordic Unmanned. This team has been built under my management and I have recruited everyone personally. To motivate my team I always explain how their contributions help the business reach its objectives, encourage autonomy, recognize when they do great work, and strive to create a team community where all team members get the chance to connect both socially and professionally.

In addition to doing specification, architecture, and project management for the team, I have made significant contributions to our codebase. I am exceptionally good at developing complex scientific code that is maintainable, has no unneeded complexity, is performant, and correct. I excel at problems that are oriented around physics, simulation, mathematical modeling, rigid body dynamics, and similar. With this skill set, it has been crucial for our projects that I have participated as a developer to our codebase.

*One example project which I have led is our [hardware/software-in-the-loop simulator](http://mortenlysgaard.com/pages/robotics-simulator.html), with physically based 3D rendering, simulation of onboard cameras, depth vision, etc. This simulator is used in all our projects to accelerate development, removing costly hardware setups, experiments, and failures. Another recent project is the RailRobot where we developed the world's first drone that lands ([LINK](http://mortenlysgaard.com/pages/autonomous-rail-landing.html)) and drives ([TODO LINK]()) on railway tracks. For this project, I did the full architecture, design, specification, and management. Designed an extended Kalman filter estimator for real-time estimation of the full drone state. Developed a 3D visual estimation and navigation algorithm using 3D stereo-depth cameras and a landing controller for autonomously landing the drone on the rails using the visual estimates.*
\vspace{1em}

## **The Staaker Company** \hfill Oslo, Norway{.unnumbered}
*CTO* \hfill Sept 2014 - Sept 2019
\vspace{1em}

[The Staaker Company](http://staaker.com) developed an auto-follow drone that automatically follows and films its subject. For a video describing the product, see <https://www.youtube.com/c/Staaker>.

During the last year of my master's degree, I co-founded The Staaker Company together with fellow students. We had a common goal of a self-flying drone that could follow and film extreme sports athletes autonomously.

As CTO I focused on understanding our product, both technically and commercially, to find a technically feasible product that would satisfy our business and customer constraints.

I believe that one can not lead what one does not understand the underlying dynamics of. Therefore I spent a lot of time with each engineer to learn about their specific fields. This made me capable of telling where the different fields were in conflict and needed guidance to not end up in a pinch, while they could stay focused on their specializations.

I did a lot of the design and specification for the product, examples include:

- Specification of all electrical submodules, how they interact, and what main components they should consist of.
- Specification of all physical parameters of the drone, weight, range, speed, and their interaction with each sub-field.
- Specification of all software components: What they do, and how they interact with each other to form a hard-real-time autonomous control system.

We were a small company and everyone took on several roles. In addition to the CTO role, I also did software development. I am a skilled C++/Rust/Haskell/Python programmer and I was responsible for the implementation of signals processing, estimation, tracking, navigation, and control, and implementing all of this hard-real-time in C++ on FreeRTOS on an STM32F4.
\vspace{1em}

## **Kongsberg Defence and Aerospace: LocalHawk - Summer intership** \hfill Kongsberg{.unnumbered}
*Embedded Software Engineer* \hfill Jun 2014 - Aug 2014
\vspace{1em}

During the summer of 2014, I worked for Kongsberg Defence and Aerospace on the LocalHawk summer project. We developed an unmanned vertical takeoff autonomous airplane. The project was divided into mechanical, electrical, software, and control theory. We started from scratch. Design and construction of aircraft, estimation and control system, custom FPGA IO drivers, Linux driver code for all peripherals, software architecture, and implementation were done in a matter of 7 weeks.

My main responsibility was software architecture. My first task was designing and implementing the architecture for message passing between all components. The second task was designing and implementing a ground control system and telemetry link. For this MAVLINK and QGroundControl was chosen and integrated into our systems. Other smaller tasks were consulting on quadcopter design for the mechanical group and implementing a custom, static, deterministic time memory allocator for our system. All code was written in modern C++ and followed Kongsberg's coding standards.
\vspace{1em}

# Hobbies{.unnumbered}
\vspace{1em}

## **Trajectory optimization toolbox and nonlinear optimization** \hfill 2018 -- present{.unnumbered}

[Click here for a more detailed explanation and live demos!](http://mortenlysgaard.com/pages/trajectory-optimization-toolbox.html)

Handling complex constraints like saturation are fundamentally hard when designing control systems for robotics. Since 2018, I have done personal research on what the state of the art in real-time trajectory optimization is. My research has been focused on optimization of smooth nonlinear nonconvex systems. I have developed several algorithms, which together form a trajectory optimization compiler. It takes as input a symbolic description of the equations of the system to control, and outputs a shared library, with a nonlinear optimizer specially compiled to optimize for the given system. The components are:

**Transcription-compiler:** A Python library using SymPy to generate trajectory optimization problems from symbolic descriptions of a robot. These NLP-problems are fed into the NLP-compiler

**NLP-compiler:** A Rust program that takes a symbolic description of a NLP-problem, and generates optimized rust code for evaluating the problem, its Lagrangian, Hessian of lagrangian, etc. The output of the NLP-compiler is used together with the IP-solver to generate a real-time trajectory optimization system.

**IP-solver:** Written in pure Rust. This is an interior point NLP-solver inspired by [IPOPT](https://doi.org/10.1007/s10107-004-0559-y) and similar works in the literature. For the interior point method, most of the computational time is spent solving sparse indefinite linear systems. For this, my LINDEF-solver is used.

**LINDEF-solver:** Written in pure Rust. This is a sparse, multifrontal, indefinite, direct, linear systems solver. It uses 1x1 and 2x2 numerical pivoting and includes matrix ordering methods to reduce factorization fill-in. It is able to compute the inertia of the factorized matrix, which is crucial for interior point algorithms. It is inspired by the works of [Duff and Reid](https://dl.acm.org/doi/10.1145/356044.356047) and [Liu](https://epubs.siam.org/doi/10.1137/1034004).

## **Kontrol language compiler** \hfill 2016 -- 2019{.unnumbered}

This is a compiler for a functional [synchronous programming language](https://en.wikipedia.org/wiki/Synchronous_programming_language) I have designed. The synchronous semantics are inspired by [Lustre](https://en.wikipedia.org/wiki/Lustre_(programming_language)), [Lucid Synchrone](https://www.di.ens.fr/~pouzet/lucid-synchrone/index.html), the syntax from [Lisp](https://en.wikipedia.org/wiki/Lisp), and the datatypes, type-system, and functional purity from [Haskell](https://en.wikipedia.org/wiki/Haskell). It is a language specifically designed for writing reactive systems with hard-real-time constraints. The language is a purely functional programming language. One unusual feature of the language is that it forbids recursive data structures and recursive functions. Together with purity, this makes the language not Turing complete. But since it is running in a reactive loop, most useful programs are still possible to express. This trivially makes all programs finite both in memory and time, which is a good property for hard-real-time systems. The compiler is implemented in Haskell and generates machine code, with a C-api interface to the underlying synchronous state machine. This project is currently dormant, as I am focusing more on the model predictive control compiler and nonlinear optimization.

# Publications{.unnumbered}

**[A multiscale method for simulating fluid interfaces covered with large molecules such as asphaltenes](https://doi.org/10.1016/j.jcp.2016.09.039)**

A paper describing results from simulations using algorithms and code I developed for simulating water droplets in crude oil. The results are used to gain a fundamental understanding of oil-water separation leading to more energy efficient separations processes. Part of a research project led by SINTEF having multiple big oil companies invested. It was published in the Journal of Computational Physics, on 15th Dec 2016 https://doi.org/10.1016/j.jcp.2016.09.039>