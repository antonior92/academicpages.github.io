---
title: 'Byrd-Omojokun Trust-Region SQP'
date: 2017-06-26
permalink: /posts/2017/06/Byrd-Omojokun/
tags:
  - GSoC 2017
  - Python
  - Scipy
  - Mathematical Programming
  - Optimization
  - Trust-Region method
  - Equality-constrained Nonlinear Programming
---

During the previous two weeks I have been implementing a 
trust-region Sequencial Quadratic Programming (SQP) method. 
This method is able to solve the equality-constrained
nonlinear programming problem:

\begin{eqnarray}
  \min_x && f(x), \\\\\\
   \text{subject to } && c(x) = 0. \\\\\\
\end{eqnarray}

Ideally at each iteration this method would solve the following
trust-region quadratic programming (QP) subproblem
in order to compute the step update $p_k$:

\begin{eqnarray}
  \min_p && \nabla f(x_k)^T p + \frac{1}{2} p^T \nabla^2_xx \mathcal{L}(x_k, \lambda_k)^T p, \\\\\\
   \text{subject to } && A(x_k)d + c(x_k) = 0; \\\\\\
   && \|p\| \le \Delta_k
\end{eqnarray}
where $\nabla f(x_k)^T$ is the function gradient, $\nabla^2_xx \mathcal{L}(x_k, \lambda_k)^T$
is the Hessian (in relation to the variable $x$) of the Lagrangian, $c(x_k)$ is the constraint
and $A(x_k)$ is the Jacobian of the constraint evaluated at $x_k$.

Note that this problem may not be feasible, since the linear constraints
may not be compatible with the trust-region constraints, as illustrated in the figure
bellow:

![screenshot 2017-06-09 13 52 38](https://user-images.githubusercontent.com/16557411/26998679-e1d51982-4d5d-11e7-8cc8-12b08807ba8a.png)

According to Nocedal and Wright \[1\](p. 546):

> To resolve the possible conflict between the linear constraints  and the trust-region constraint, 
it is not appropriate simply to increase the trust-region until the step satisfying the 
linear constraints intersects the trust region. This approach would defeat the purpose of using the 
trust region in the first place as a way to define a region within which we trust the model to accurately
reflect the behavior of the objective and constraint functions. Analytically, it would harm the convergence
properties of the algorithm.

> A more appropriate viewpoint is that there is no reason to satisfy the linearized constraints exactly 
at every step; rather, we should aim to improve the feasibility of these constraints at each step and to
satisfy them exactly only if the trust-region constraint permits it. 

The Byrd-Omojokun approach to deal with the incompatibility 
of the linear constraints is to modify the QP subproblem
allowing more flexibility to the linear constraints.
This approach solve the subproblem:

\begin{eqnarray}
  \min_d && \nabla f(x_k)^T d + \frac{1}{2} d^T \nabla^2_xx \mathcal{L}(x_k, \lambda_k)^T d, \\\\\\
   \text{subject to } && A(x_k)d + c(x_k) = r_k; \\\\\\
   && \|d\| \le \Delta_k
\end{eqnarray}

where $r_k$ is adjusted such that the constraints are always compatible.
This is done in two steps:

1. The first step is to solve the subproblem:

\begin{eqnarray}
  \min_v && \|A(x_k)v + c(x_k)\|^2, \\\\\\
   \text{subject to } && \|d\| \le \eta \Delta_k
\end{eqnarray}
where $\eta$ is a constant such that $0<\eta<1$. In our implementation \eta=0.8$ is being used.

Denoting the solution of the above subproblem $v_k$ we define $r_k$ as:
\begin{equation}
  r_k = A(x_k)v + c_k
\end{equation}

2. The second step is to solve the subproblem:
\begin{eqnarray}
  \min_d && \nabla f(x_k)^T d + \frac{1}{2} d^T \nabla^2_xx \mathcal{L}(x_k, \lambda_k)^T d, \\\\\\
   \text{subject to } && A(x_k)d + c(x_k) = r_k; \\\\\\
   && \|d\| \le \Delta_k
\end{eqnarray}
for the computed $r_k$


References
----------
\[1\]&nbsp;&nbsp;&nbsp;[Jorge Nocedal, and Stephen J. Wright. "Numerical optimization"
Second Edition (2006).][1]


[1]: http://www.bioinfo.org.cn/~wangchao/maa/Numerical_Optimization.pdf

