---
title: Model Predictive Control compiler
---

# Intoduction:
Some of the hardest problems in control systems is handling non-linear dynamics well, taking into account actuator saturation or rate limits, taking into account large delays or inertia within a system. Conventional control theory is focused on linear systems, and is not equipped to handle such problems. State space methods, like LQR-methods, gives controllers that are locally optimal but only for a linearized model around the current state. This works well for problems where there is no delays, or long-term planning required to compute the best control input. 

Model Predictive Control, MPC, is a branch of control theory that combines mathematical models of a system with solvers from optimization to obtain controllers that can handle all of the above challenges.

## Linear model predictive control
For linear systems with linear constraints, the model predictive control approach gives convex, linear optimization problems.
These are easy to solve real-time on a robotics system. For linear systems, model predictive control is a solved problem.

However, not many robotics systems are linear.
One example of this is if the system uses rotation, angles or orientation. Eg. the joints of a robotic arm, or the pointing-direction of a simplified, top-down, 2D car-model.
The dynamics of the system will require some sort of trigonometric functions to be described, and thus become nonlinear.

Although there are special edge cases where, with careful analysis, one can find a linear description of a seemingly non-linear system, in general, the nonlinearities are fundamental, and can not be removed.

## Nonlinear non-convex model predictive control
In general, a nonlinear dynamics or constraints, lead to a nonlinear and usually non-convex optimization problem.
These are considerably harder to solve than linear ones. Where the solution to a linear optimization problem is unique, and globally optimal,
it is possible to create nonlinear non-convex optimization problems with arbitrarily many local optima.
This fact means that optimization solvers for nonlinear non-convex problems must focus on finding a local optima, rather than a global one.
Also, because of the large increase in computational power required, having an efficient algorithm together with a efficient implementation of
this algorithm is key to be able to do nonlinear non-convex MPC in real-time.

# Research
I have done personal research in what the state of the art in real-time model predictive control is.
My research has been focused on the smooth optimization problems that come from nonlinear non-convex collocation methods for trajectory optimization.
An excellent introduction to this topic is covered by [Kelly](https://doi.org/10.1137/16M1062569).

I have developed several algorithms, which together form a compiler for direct collocation trajectory optimization problems.
It takes as input a symbolic description of the equations of the system to
control, and outputs a shared library, with an nonlinear optimizer specially compiled to optimize for the given system.
The components are:

## TRAJ-compiler:
A Python library using [SymPy](https://www.sympy.org/) to generate trajectory optimization problems from symbolic descriptions of a robot. These NLP-problems are feed into the NLP-compiler

As an example, lets model a 2D multicopter:

$$
\begin{align}
\frac{\partial \mathbf{p}}{\partial t} &= \mathbf{v} \\
\frac{\partial \mathbf{v}}{\partial t} &= \mathbf{a} \\
\mathbf{a} &= \frac{\mathbf{f}_{\text{g}} + \mathbf{f}_{\text{m}}}{m} \\
\mathbf{f}_{\text{g}} &= m \begin{bmatrix} 0 \\ -g \\ \end{bmatrix} \\
\mathbf{f}_{\text{m}} &= (u_l + u_r) \begin{bmatrix} \cos(\theta+\frac{\pi}{2}) \\ \sin(\theta+\frac{\pi}{2}) \\ \end{bmatrix} \\
\frac{\partial \theta}{\partial t} &= \omega \\
\frac{\partial \omega}{\partial t} &= \frac{u_1 - u_0}{I} \\
u_0 &\in (0, u_{0,\max}) \\
u_1 &\in (0, u_{0,\max}) \\
\end{align}
$$
where $\mathbf{p}$ is the position vector $\mathrm{[m]}$,
$\mathbf{v}$ is the velocity vector $\mathrm{[m/s]}$,
$\mathbf{a}$ is the acceleration vector $\mathrm{[m/s^2]}$,
$\mathbf{f}_{\text{g}}$ is the force vector from gravity $\mathrm{[N]}$,
$\mathbf{f}_{\text{m}}$ is the force vector from the motors $\mathrm{[N]}$,
$\theta$ is the rotation angle of the multicopter, $\mathrm{[rad]}$,
$\omega$ is the rotation angle of the multicopter, $\mathrm{[rad/s]}$,
$u_0$ is the pulling force from the left motor and propeller, $\mathrm{[N]}$,
$u_1$ is the pulling force from the right motor and propeller, $\mathrm{[N]}$,
$I$ is the rotational inertia of the multicopter, $\mathrm{[N]}$.
Note here that the forces from the motors, $u_0$ and $u_1$, are constrained. And there is a nonlinearity in the equation for $\mathbf{f}_{\text{m}}$.

The python script takes a symbolic representation of these equations, together with a description of the collocation method, any other extra constraints, and an objective to minimize, and generates a NLP optimization problem of the form.
$$
\begin{aligned}
\min_{\forall \mathbf{x}} f(\mathbf{x}, \mathbf{p})& \\
\mathbf{c}_{\text{l}} \le \mathbf{c}(\mathbf{x},\mathbf{p}) &\le \mathbf{c}_{\text{h}} \\
\mathbf{b}_{\text{l}} \le \mathbf{x} &\le \mathbf{b}_{\text{h}} \\
\end{aligned}
$${#eq:nlp-problem}
here
$\mathbf{x}$ is our vector of optimization variables,
$\mathbf{p}$ is our parameter vector of constants,
$\mathbf{b}_{\text{l}}$ and $\mathbf{b}_{\text{h}}$ are box constraints for our optimization variables,
$f(\mathbf{x}, \mathbf{p})$ is a $C(2)$ objective function,
$c(\mathbf{x}, \mathbf{p})$ is the $C(2)$ constraints function,
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
one-sided constraints eg. by letting $\mathbf{c}_{\text{l}_i} = -\infty$.

The symbolic description of [@eq:nlp-problem] is then serialized to a `json` file as input for the next step, the NLP-compiler.

## NLP-compiler:
The NLP-compiler takes as input a symbolic representation of the NLP-problem output by TRAJ-compiler.
It then analyses, simplifies, and generates optimized Rust code for evaluating the problems objective function, gradient, Hessian, Lagrangian etc.
This generated code is compiled and linked together with the IP-solver to generate a specialized NLP-solver that is efficient for solving the specific problem.

## IP-solver:
This is an interior point NLP-solver inspired by IPOPT and similar works in the literature. The solver is implemented in pure Rust, and uses my LINDEF-solver solver to do most of the heavy lifting.

## LINDEF-solver:
This is a sparse, multifrontal, indefinite, direct, linear systems solver.
It uses 1x1 and 2x2 numerical pivoting, and supports matrix ordering methods to reduce factorization fill-in.
It is able to compute the inertia of the factorized matrix, which is crucial for interior point algorithms.
It is inspired by the works of [Duff and Reid](https://dl.acm.org/doi/10.1145/356044.356047) and [Liu](https://epubs.siam.org/doi/10.1137/1034004).

# How the system is used
From a users perspective, there are only two components. First, user code generates an NLP-problem of the type [@eq:nlp-problem]. This problem description is given as input to the NLP-compiler. The NLP-compiler outputs a shared library which contains an efficient solver for the given NLP problem.