---
title: 'GSoC 2017 - Scipy: Large-scale Constrained Optimization'
date: 2017-05-08
permalink: /posts/2017/05/GSoC-proposal/
tags:
  - GSoC 2017
  - Python
  - Scipy
  - Mathematical Programming
  - Optimization
  - Interior point method
---

This year I was chosen as the student for Google Summer of Code.
I’ll be working on one of the core Python scientific libraries called scipy.
My task is to implement a constrained optimization algorithm able to deal with
large (and possibly sparse) problems for which the constrained optimization
methods currently implemented in Scipy (namely `SLSQP` and `COBYLA`) are
largely inappropriate to deal with.

This project intends to deal with the problem of minimizing a function
subject to constraints on its variables, mathematically formulated as
the following nonlinear programming problem:

\begin{equation}
   \min_x  f(x)~\text{subject to } c_E(x) = 0,~c_I(x) \ge 0,
\end{equation}

where $x\in \mathbb{R}^n$ is a vector of unknowns and the objective function $f$,
the equality constraints $c_E$ and the inequality constraints $c_I$ are twice continuous
differentiable functions. In science, engineering and finance
many applications can be formulated as the above optimization problem.

My full proposal can be found in the following [link](https://github.com/antonior92/GSoC2017-Scipy).



