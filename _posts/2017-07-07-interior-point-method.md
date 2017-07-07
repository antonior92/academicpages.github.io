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


In this post we will discuss the interior point method described in \[1\]  for solving the the 
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
  \min_{x, s} && g(x) = f(x) - \mu * \sum_{i} \ln (s_i), \\\\\\
   \text{subject to } && c_E(x) = 0,\\\\\\
   && c_I(x) + s =  0,
\end{eqnarray}
for progressively smaller values of the barrier parameter $\mu$.
The basic idea of the implemented method is to use the previously implemented
SQP solver (described [here](https://antonior92.github.io/posts/2017/06/Byrd-Omojokun/))
successively to those problems. The way of doing this efficiently described in [1] is not 
trying to solve the equality problem exactly, but rather to solve it inexactly
with increasing accuracy as the problem gets closer to the solution.

The name "barrier problem" is due to the the fact the function $-\ln(s_i)$
increases to infinity as $s_i$ approach the value $0$, enforcing the
condition $s>0$. By letting
$\mu$ converge to zero, the sequence of solutions of the barrier problems
converge to a solution point of the original nonlinear programming problem.





References
----------

\[1\]&nbsp;&nbsp;&nbsp; [Richard H. Byrd, Mary E. Hribar, and Jorge Nocedal. "An interior point algorithm for large-scale nonlinear programming." SIAM Journal on Optimization 9.4 (1999): 877-900.][1]

\[2\]&nbsp;&nbsp;&nbsp;[Jorge Nocedal, and Stephen J. Wright. "Numerical optimization"
Second Edition (2006).][2]


[1]: http://ai2-s2-pdfs.s3.amazonaws.com/0c1c/4bbdd7467c5ba1818b2e7a360e768b067d2c.pdf
[2]: http://www.bioinfo.org.cn/~wangchao/maa/Numerical_Optimization.pdf
