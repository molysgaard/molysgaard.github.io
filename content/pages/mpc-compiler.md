---
title: Trajectory Optimization compiler
---

# Intoduction:
Some of the hardest problems in control systems is handling non-linear dynamics well, taking into account actuator saturation or rate limits, taking into account large delays or inertia within a system. Conventional control theory is focused on linear systems, and is not equipped to handle such problems. State space methods, like LQR-methods, gives controllers that are locally optimal but only for a linearized model around the current state. This works well for problems where there is no delays, or long-term planning required to compute the best control input. 

Trajectory Optimization, is a branch of control theory that combines mathematical models of a system with solvers from optimization to obtain controllers that can handle all of the above challenges.

## Linear Trajectory Optimization
For linear systems with linear constraints, the trajectory optimization approach gives convex, linear optimization problems.
These are easy to solve real-time on a robotics system. And one can say that for linear systems, model predictive control is a solved problem.

However, not many robotics systems are linear.
One way to introduces nonlinearity is if there is a form of rotation, angles or orientation in the system. Eg. the joints of a robotic arm, or the pointing-direction of a simplified, top-down, 2D car-model.
The dynamics of the system will almost always require some sort of trigonometric functions to be described, and thus become nonlinear.

Although there are special edge cases where, with careful analysis, one can find a linear description of a seemingly non-linear system, in general, the nonlinearities are fundamental, and can not be removed.

## Nonlinear non-convex Trajectory Optimization
In general, a nonlinear dynamics or constraints, lead to a nonlinear and usually non-convex optimization problem.
These are considerably harder to solve than linear ones. Where the solution to a linear optimization problem is unique, and globally optimal,
it is possible to create nonlinear non-convex optimization problems with arbitrarily many local optima.
This fact means that optimization solvers for nonlinear non-convex problems must focus on finding a local optima, rather than a global one.
Also, because of the large increase in computational power required, having an efficient algorithm together with a efficient implementation of
this algorithm is key to be able to do nonlinear non-convex Trajectory Optimization in real-time.

# Research
I have done personal research in the state of the art in real-time Trajectory Optimization.
My research has been focused on the smooth optimization problems that come from nonlinear non-convex collocation methods.
An excellent introduction to the topic is covered by [Kelly](https://doi.org/10.1137/16M1062569).

I have developed software, which form a compiler for general non-convex, constrained, smooth, nonlinear, optimization problems.
On top of this software, the user can use his transcription tool of choice to generate a NLP problem.
I have also developed a rudamentary transcription tool using SymPy and Python.

The components are:

## Transcription-compiler:
A Python library using [SymPy](https://www.sympy.org/) to generate transcriptions of trajoctory optimization problems from symbolic SymPy description of a system. These NLP-problems are feed into the NLP-compiler
The symbolic description of [@eq:nlp-problem] is then serialized to a `.json` file as input for the next step, the NLP-compiler.

The python script takes a symbolic SymPy representation of these equations, together with a description of the collocation method, any other extra constraints, and an objective to minimize, and generates a NLP optimization problem of the form.
$$
\begin{aligned}
\min_{\text{for } \mathbf{p} \text{ constant, } \mathbf{x} \text{ variable}} f(\mathbf{x}, \mathbf{p})& \\
\mathbf{c}_{\text{l}} \le \mathbf{c}(\mathbf{x},\mathbf{p}) &\le \mathbf{c}_{\text{h}} \\
\mathbf{b}_{\text{l}} \le \mathbf{x} &\le \mathbf{b}_{\text{h}} \\
\end{aligned}
$${#eq:nlp-problem}
here
$\mathbf{x}$ is our vector of optimization variables,
$\mathbf{p}$ is our parameter vector of constants,
$\mathbf{b}_{\text{l}}$ and $\mathbf{b}_{\text{h}}$ are box constraints for our optimization variables,
$f(\mathbf{x}, \mathbf{p})$ is a $C^2$ objective function,
$\mathbf{c}(\mathbf{x}, \mathbf{p})$ is the $C^2$ constraints function,
$\mathbf{c}_{\text{l}}$ and $\mathbf{c}_{\text{h}}$ are bounds for our constraint variables.

The domain of the constraint bounds, and variable box constraints are as follows:
$$
\begin{aligned}
\mathbf{c}_{\text{l}_i} &\in [-\infty, \mathbf{c}_{\text{h}_i}] \\
\mathbf{c}_{\text{h}_i} &\in [\mathbf{c}_{\text{l}_i}, \infty] \\
\mathbf{b}_{\text{l}_i} &\in [-\infty, \mathbf{b}_{\text{h}_i}] \\
\mathbf{b}_{\text{h}_i} &\in [\mathbf{b}_{\text{l}_i}, \infty] \\
\end{aligned}
$$
This makes it possible to express equality constraints by letting $\mathbf{c}_{\text{l}_i} = \mathbf{c}_{\text{h}_i}$,
one-sided constraints eg. by letting $\mathbf{c}_{\text{l}_i} = -\infty, \mathbf{c}_{\text{h}_i} = k$ and so forth.

## NLP-compiler:
The NLP-compiler takes as input a symbolic representation of the NLP-problem output by TRAJ-compiler.
It then analyses, simplifies, and generates optimized Rust code for evaluating the problems objective function, gradient, Hessian, Lagrangian etc.
This generated code is compiled and linked together with the IP-solver to generate a specialized NLP-solver that is efficient for solving the specific problem.

## IP-solver:
This is an interior point NLP-solver inspired by [IPOPT](https://doi.org/10.1007/s10107-004-0559-y) and similar works in the literature. The solver is implemented in pure Rust, and uses my LINDEF-solver solver to do most of the heavy lifting.

## LINDEF-solver:
This is a sparse, multifrontal, indefinite, direct, linear systems solver.
It uses 1x1 and 2x2 numerical pivoting, and supports matrix ordering methods to reduce factorization fill-in.
It is able to compute the inertia of the factorized matrix, which is crucial for interior point algorithms.
It is inspired by the works of [Duff and Reid](https://dl.acm.org/doi/10.1145/356044.356047) and [Liu](https://epubs.siam.org/doi/10.1137/1034004).

# How the system is used
From a users perspective, there are only two components. First, the user writes a script that outputs an NLP-problem of the type [@eq:nlp-problem] in a `.json` file.
This problem description is given as input to the NLP-compiler.
The NLP-compiler outputs a shared library which contains an efficient solver for the given NLP problem and a C-header for linking to the shared library.
The user can then use this shared library from any programming language that is able to call standard C-api shared libraries, which is just about any programming language.

# Example problem: 2D multicopter, trajectory optimization
In the above video example, the following model is used:

$$
\begin{align}
\frac{\partial \mathbf{p}}{\partial t} &= \mathbf{v} \\
\frac{\partial \mathbf{v}}{\partial t} &= \mathbf{a} \\
\mathbf{a} &= \frac{\mathbf{f}_{\text{g}} + \mathbf{f}_{\text{m}}}{m} \\
\mathbf{f}_{\text{g}} &= m \begin{bmatrix} 0 \\ -g \\ \end{bmatrix} \\
\mathbf{f}_{\text{m}} &= (u_l + u_r) \begin{bmatrix} \cos(\theta+\frac{\pi}{2}) \\ \sin(\theta+\frac{\pi}{2}) \\ \end{bmatrix} \\
\frac{\partial \theta}{\partial t} &= \omega \\
\frac{\partial \omega}{\partial t} &= \frac{l}{I}(u_1 - u_0) \\
u_0 &\in (0, u_{0,\max}) \\
u_1 &\in (0, u_{0,\max}) \\
\end{align}
$$
where $\mathbf{p}$ is the position vector $\mathrm{[m]}$,
$\mathbf{v}$ is the velocity vector $\mathrm{[m/s]}$,
$\mathbf{a}$ is the acceleration vector $\mathrm{[m/s^2]}$,
$\mathbf{f}_{\text{g}}$ is the force vector from gravity $\mathrm{[N]}$,
$\mathbf{f}_{\text{m}}$ is the total force vector from the motors $\mathrm{[N]}$,
$\theta$ is the rotation angle of the multicopter, $\mathrm{[rad]}$,
$\omega$ is the rotation angle of the multicopter, $\mathrm{[rad/s]}$,
$u_0$ is the pulling force from the left motor and propeller, $\mathrm{[N]}$,
$u_1$ is the pulling force from the right motor and propeller, $\mathrm{[N]}$,
$l$ is the arm length of the multicopter, $\mathrm{[m]}$,
$I$ is the rotational inertia of the multicopter, $\mathrm{[N]}$.
Note here that the forces from the motors, $u_0$ and $u_1$, are constrained. And there is a nonlinearity in the equation for $\mathbf{f}_{\text{m}}$.

The following constants are used:
$$
\begin{aligned}
m_\text{motor} &= 0.2 \\
m_\text{body} &= 0.8 \\
m &= m_\text{motor} + m_\text{body} \\
l_\text{body} &= 0.1 \\
l &= 0.225 \\
I &= 2 \left( \frac{l}{2} \right)^2 m_\text{motor} + \frac{m_\text{body}}{12} 2 l_\text{body}^2 \\
g &= 9.81 \\
\end{aligned}
$$
Here we approximate the body as composed of 3 objects, 2 point-mass motors on each arm, and a body in the middle modelled as a square with uniform density.
We then use the [equations for inertia](https://en.wikipedia.org/wiki/List_of_second_moments_of_area) to derive the equation for $I$.

The Trajectory-compiler generates a NLP-solver for the trajectory optimization problems coming from these equations, and this solver is run each frame
and the drone is visualized in the above example.
*You can also download your own runnable example of as a sandboxed Linux executable by* **[downloading this AppImage Link](/files/demos/mpc-multico)**.

# Open-source
I have not made the code for this toolbox open source yet, but I would really like to distribute this so that others could play with it and create something usefull. Please contact me if you are interested [write me](mailto:morten@lysgaard.no).