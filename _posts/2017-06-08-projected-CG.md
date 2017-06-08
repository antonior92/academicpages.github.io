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






References
----------
\[1\]&nbsp;&nbsp;&nbsp;[Nocedal, Jorge, and Stephen J. Wright. "Numerical optimization"
Second Edition (2006).][1]

\[2\]&nbsp;&nbsp;&nbsp; [Gould, Nicholas IM, Mary E. Hribar, and Jorge Nocedal.
"On the solution of equality constrained quadratic programming problems arising
in optimization." SIAM Journal on Scientific Computing 23.4 (2001): 1376-1395.][2]

[1]: http://www.bioinfo.org.cn/~wangchao/maa/Numerical_Optimization.pdf
[2]: https://pdfs.semanticscholar.org/d959/8c935921efb5c4459fd6c55cf501cd578b45.pdf
