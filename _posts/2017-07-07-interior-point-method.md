---
title: 'Trust-Region Interior-Point Method'
date: 2017-07-07
permalink: /posts/2017/07/interior-point-method/
tags:
  - GSoC 2017
  - Python
  - Scipy
  - Mathematical Programming
  - Optimization
  - Trust-Region method
  - Nonlinear Programming
---


In this post the interior point method described in \[1\]  will be discussed. This algorithm solve the 
nonlinearly constrained optimization problem:

\begin{eqnarray}
  \min_x && f(x), \\\\\\
   \text{subject to } && c_E(x) = 0,\\\\\\
   && c_I(x) \le 0,
\end{eqnarray}

where $x\in \mathbb{R}^n$ is a vector of unknowns, $f$ is called the objective function and
$c_E$ and $c_I$ are vectorial functions used to delimit the feasible region.

A first version of this trust-region interior-point method was implemented during this week
and the guinding principles behind the method will be explained in this post.
Applications and test results will be left for future blog posts.

Barrier Problem
---------------

Introducing slack variables $s$ the general nonlinear programing problem can be rewritten as:

\begin{eqnarray}
  \min_x && f(x), \\\\\\
   \text{subject to } && c_E(x) = 0,\\\\\\
   && c_I(x) + s =  0, \\\\\\
   && s \ge 0.
\end{eqnarray}

The basic idea of the implemented interior-point method  is to
solve, instead of the above problem, the equality-constrained barrier problem:
\begin{eqnarray}
  \min_{x, s} && f(x) - \mu \sum_{i} \ln (s_i), \\\\\\
   \text{subject to } && c_E(x) = 0,\\\\\\
   && c_I(x) + s =  0,
\end{eqnarray}
for progressively smaller values of the barrier parameter $\mu$.
The previously implemented Sequential Quadratic Programming (SQP)
solver (described [here](https://antonior92.github.io/posts/2017/06/Byrd-Omojokun/))
is used to successively solve those problems for $\mu \rightarrow 0$.
The way of doing this efficiently described in [1] is not 
trying to solve the equality problem exactly, but rather to solve it inexactly
with increasing accuracy as the problem gets closer to the solution.

The name "barrier problem" is due to the the fact the function $-\ln(s_i)$
increases to infinity as $s_i$ approach the value $0$, enforcing the
condition $s>0$. By letting
$\mu$ converge to zero, the sequence of solutions of the barrier problems
converge to a solution point of the original nonlinear programming problem.


Outline of the Algorithm
------------------------
The first order optimality conditions (KKT equations, explained in \[2\], p.321)
for the barrier problem, guarantee that at a solution point $(x^*,~s^*)$
the following equations are satisfied:
\begin{eqnarray}
  \nabla_x \mathcal{L}(x^*, s^*, \lamda_E, \lambda_I) &=& 0, \\\\\\
  \nabla_s \mathcal{L}(x^*, s^*, \lamda_E, \lambda_I) &=& 0, \\\\\\
  c_E(x) &=& 0,\\\\\\
  c_I(x) + s &=&  0,
\end{eqnarray}
where $\nabla_x$ and $\nabla_s$ represents the first derivatives regarding, respectively,
$x$ and $s$; and for which  $\mathcal{L}(x, s, \lamda_E, \lambda_I)$ represent the Lagrangian:
\begin{equation}
  \mathcal{L}(x, s, \lamda_E, \lambda_I) = f(x) - \mu \sum_{i} \ln (s_i) + \lamda_E^T c_E(x) + \lamda_I^T (c_I(x) + s),
\end{equation}
and $\lamda_E$ and $\lamda_I$, the Lagrange multipliers.

Rather than a exact solution to the barrier problem,
we will be contend with an approximation solution satisfying:
\begin{eqnarray}
  \|\nabla_x \mathcal{L}(x, s^*, \lamda_E, \lambda_I)\| &<& \epsilon, \\\\\\
  \|\nabla_s \mathcal{L}(x^*, s^*, \lamda_E, \lambda_I)\| &<& \epsilon, \\\\\\
  \|c_E(x)\| &<& \epsilon,\\\\\\
   && c_I(x) + s &<&  \epsilon
\end{eqnarray}

Starting from a point $(x, s)$, for a initial barrier
parameter $\mu$ and tolerance $\epsilon$
the algorithm repeats the following steps until a stop criteria:

- Apply SQP trust-region starting from $(x, s)$  to find approximation solution $(x^{+}, s^{+})$ 
of the barrier problem (for an barrier parameter $\mu$), satisfying the tolerance $\epsilon$
- Update solution  $(x, s) \leftarrow (x^+, s^+)$, update the barrier solution $\mu \leftarrow 0.2\mu$ and the tolerance $\epsilon \leftarrow 0.2\epsilon$


Final Comments
--------------
In this and in the two previous blog posts I tried to describe the main aspects of the algorithm I am implementing.
In the [first post](https://antonior92.github.io/posts/2017/05/projected-CG/) the projected conjugate
gradient method was described. This method solve the equality-constrained Quadratic Programing (QP) problem:
\begin{eqnarray}
  \min_x && \frac{1}{2} x^T H x + c^T x + f, \\\\\\
   \text{subject to } && A x = b.
\end{eqnarray}
The sequential solution of equality-constrained QP problem
is the guiding principle for the Sequential Quadratic Programming (SQP) solver I described in the
[second post](https://antonior92.github.io/posts/2017/06/Byrd-Omojokun/). This SQP solver is
for equality constrained problems of the form:
\begin{eqnarray}
  \min_x && f(x), \\\\\\
   \text{subject to } && c(x) = 0. \\\\\\
\end{eqnarray}
Which in turn is used to solve the barrier problems for the interior-point method described in this post.



References
----------

\[1\]&nbsp;&nbsp;&nbsp; [Richard H. Byrd, Mary E. Hribar, and Jorge Nocedal. "An interior point algorithm for large-scale nonlinear programming." SIAM Journal on Optimization 9.4 (1999): 877-900.][1]
\[2\]&nbsp;&nbsp;&nbsp;[Jorge Nocedal, and Stephen J. Wright. "Numerical optimization"
Second Edition (2006).][2]


[1]: http://ai2-s2-pdfs.s3.amazonaws.com/0c1c/4bbdd7467c5ba1818b2e7a360e768b067d2c.pdf
[2]: http://www.bioinfo.org.cn/~wangchao/maa/Numerical_Optimization.pdf

