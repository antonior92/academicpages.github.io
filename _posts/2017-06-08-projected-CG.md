---
title: 'Projected Conjugate Gradient'
date: 2017-06-08
permalink: /posts/2017/05/projected-CG/
tags:
  - GSoC 2017
  - Python
  - Scipy
  - Mathematical Programming
  - Optimization
  - Projected Conjugate Gradient
  - Conjugate Gradient
  - Equality-constrained Quadratic Programming
---

The projected conjugate gradient (CG) method was implemented during my first
GSoC weeks. A variety of algorithms for linearly and nonlinearly constrained
optimization use this algorithm to solve problems of the form:

\begin{eqnarray}
  \min_x && \frac{1}{2} x^T H x + c^T x, \\\\\\
   \text{subject to } && A x - b = 0,\\\\\\
\end{eqnarray}

This algorithm is an important substep of the nonlinear programming solver
I am implementing and, therefore, deserve some discussion. I based
my implementation on the descriptions in \[1, Chapter 16 \] 
and in \[2\].

Conjugate Gradient
------------------

Before explaining the projected conjugate gradient, a bried explanation about
the conjugate gradient method will be provided. The conjugate gradient (CG), is a
procedure to solve the problem:

\begin{equation}
  \min_x ~ \phi(x) = \frac{1}{2} x^T H x + c^T x,
\end{equation}

for a symmetric positive definite matrix $H$. Which happens to be equivalent to the problem
of fiding a solution to the problem $H x = -c$. The CG method is an iterative procedure,
that starts with a initial solution $x_0$ and update this solution iteratively:

\begin{equation}
  x_{k+1} = x_{k} + \alpha_k p_k.
\end{equation}

The name of the method is due to a property of the update vectors $p_k$. This vectors
are said to be *conjugate* with respect to $H$ because they satisfy the following
property:

\begin{equation}
  p_i^T H p_j = 0,~\text{for all }i \not= j.
\end{equation}

The *conjugacy* of the a set of vectors $\{p_0,\cdots, p_k\}$ is sufficient
to guarantee this set is linearly independent. So assume that, $x$ have
dimension $n$, after $n-1$ iteration the resulting vector is:

\begin{equation}
  x_n = x_0 + \alpha_0 p_0 + \cdots + \alpha_{n-1} p_{n-1} 
\end{equation}

since we have the sum of $n$ linear independent vectors, for the
right choice of coeficients $\alpha_k$ we have that $x_n$ can assume
any value in $\mathbb{R}^n$, incluse the optimal value $x^*$ that
is solution to the problem of minimizing $\phi(x)$.


References
----------
\[1\]&nbsp;&nbsp;&nbsp;[Jorge Nocedal, and Stephen J. Wright. "Numerical optimization"
Second Edition (2006).][1]

\[2\]&nbsp;&nbsp;&nbsp; [Nicholas I.M. Gould, Mary E. Hribar and Jorge Nocedal.
"On the solution of equality constrained quadratic programming problems arising
in optimization." SIAM Journal on Scientific Computing 23.4 (2001): 1376-1395.][2]

[1]: http://www.bioinfo.org.cn/~wangchao/maa/Numerical_Optimization.pdf
[2]: https://pdfs.semanticscholar.org/d959/8c935921efb5c4459fd6c55cf501cd578b45.pdf
