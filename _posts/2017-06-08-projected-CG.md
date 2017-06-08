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
   \text{subject to } && A x = b.
\end{eqnarray}

This algorithm is an important substep of the nonlinear programming solver
I am implementing and, therefore, deserve some discussion. I based
my implementation on the descriptions in \[1\], Chapter 16,
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

The name of the method is due to a property of the update vectors $p_k$. These vectors
are said to be *conjugate* with respect to $H$ because they satisfy the following
property:

\begin{equation}
  p_i^T H p_j = 0,~\text{for all }i \not= j.
\end{equation}

The *conjugacy* of the a set of vectors $\\{p_0,\cdots, p_k\\}$ is sufficient
to guarantee this set is linearly independent.

Assume that $x$ have dimension $n$, after $n$ iteration the resulting vector is:

\begin{equation}
  x_n = x_0 + \alpha_0 p_0 + \cdots + \alpha_{n-1} p_{n-1} 
\end{equation}

since we have the sum of $n$ linear independent vectors, for the
right choice of coeficients $\alpha_k$ we have that $x_n$ can assume
any value in $\mathbb{R}^n$, inclusive the optimal value $x^*$ that
is solution to the problem of minimizing $\phi(x)$. And because
of that the CG method converge at most in $n$ iteractions.

The strenght of the conjugate gradient method is that
a satisfatory solution to the minimization problem
can usually be obtained in much less iterations than $n$.
Furthermore, the set of conjugate vectors $\\{p_0,\cdots, p_k\\}$
is computed in rather economic fashion by using only the previous
value $p_{k-1}$ to compute the new conjugate vector $p_k$:

\begin{equation}
  p_{k+1} = r_{k} + \beta_k p_{k-1},
\end{equation}

where $r_k$ is the gradient of $\phi$ in $x_k$:

\begin{equation}
  r_{k} = \nabla \phi(x_k) = H x_k + c.
\end{equation}

and $\beta$ is constant choosen such that if $p_{k-1}$
is conjugate to the set $\\{p_0,\cdots, p_k-2\\}$
than  $p_{k}$ is conjugate to this set too and also to $p_{k-1}$.

The constant $\alpha_k$ and $\beta_k$ can be easily compute using the following
formulas:

\begin{eqnarray}
	\alpha_k = \frac{r_k^T r_k}{p_k H p_k} \\\\\\
    \beta_k = \frac{r_{k+1}^T r_{k+1}}{r_k^T r_k}.
\end{eqnarray}

For a explanation on how this constants were compute we refer the
reader to \[1, Chapter 5 \].

So a basic iteration of the conjugate gradient consists of the following steps:
- Compute $\alpha_k = \frac{r_k^T r_k}{p_k H p_k}$;
- Update the solution $x_{k+1} = x_{k} + \alpha_k p_k$;
- Compute the residual $r_{k+1} = H x_{k+1} + c$;
- Compute $\beta_k = \frac{r_{k+1}^T r_{k+1}}{r_k^T r_k}$;
- Get a new conjugate vector: $p_{k+1} = r_{k} + \beta_k p_{k-1}$

This method can be implement in quite economic fashion without the need to
actually store the matrix $H$. Only the ability to compute the product
$H v$ for any given vector $v$, is actually need. Which makes this method very
appropriate for very large problems.

A comprehensive description of the CG method can be found on \[1\], Chapter 5.

Projected Conjugate Gradient
----------------------------

The projected CG method is a variation of the CG method that is 
able to solve problems of the form:

\begin{eqnarray}
  \min_x && \phi(x) =  \frac{1}{2} x^T H x + c^T x, \\\\\\
   \text{subject to } && A x = b.
\end{eqnarray}

The idea of this method is to choose an initial point $x_0$,
such that $x_0$ satisfy the constraints:

\begin{equation}
  A x_0 = b,
\end{equation}

and to choose the update vectors $p_k$ in the null space of 
$A$, such that:

\begin{equation}
  A p_k = 0,
\end{equation}

It follows that for:

\begin{equation}
  x_k = x_0 + (\alpha_0 p_0 + \cdots + \alpha_{n-1} p_{k-1}),
\end{equation}

we have $A x_k = A x_0 + 0 = b$. So the constraints are satisfied,
getting progressively close to the optimal value of $\phi(x)$.

A comprehensive description of the projected CG method can be
found on \[1\], Chapter 16.

Roundoff Errors
---------------

A naive implementation of the projected CG method may have
it result significantly affected by roundoff errors.

The problem occurs because
the computed vector $p_k$ may not be exactly on the null-space
of the matrix $A$, such that:

\begin{equation}
  A p_k > 0,
\end{equation}

This cause the constraints to be  progressivelly more violated
along the iterations.

The next figure shows the application of the projected CG 
for the problem ``CVXQP3_M`` from the CUTEst collection.
The constrain  violation $\\|Ax_k-b\\|$ is monitored
along the iteractions, showing that the roundoff errors 
can cause large constraints violations.

![error_per_iteration](https://antonior92.github.io/files/error_per_iteration.png)

Fortunatelly, in \[2\] some iterative refinements
and a new way to update the residuals are proposed to
keep the roundoff errors at aceptable levels. The constrain
violation  $\\|Ax_k-b\\|$ along the iteractions, after implementing
the proposed modifications, is displayed bellow
indicating acceptable levels of constraint violation
along the iteractions.

![error_per_iteration_corrected](https://antonior92.github.io/files/error_per_iteration_corrected.png)

Final Results
-------------

I performed experiments on the following set of problems:
``CVXQP1_S, CVXQP2_S, CVXQP3_S, CVXQP1_M, CVXQP2_M, CVXQP3_M,
CVXQP1_L, CVXQP2_L, CVXQP3_L, CONT-050, CONT-100, DPKL01, MOSARQP1,
DUAL1, DUAL2, DUAL3, DUAL4, PRIMAL1, PRIMAL2, LASER``.
The description of the problems can be found in \[3\] (convex QP problems).

I compared two variations of the projected CG method, refered in
\[2\] as *normal equation approach* and *augmented system approach*,
with the solution of the equality constrained programming (EQP)
problem:

\begin{eqnarray}
  \min_x &&\frac{1}{2} x^T H x + c^T x, \\\\\\
   \text{subject to } && A x = b.
\end{eqnarray}

by the direct factorization of the Karush-Kuhn-Tucker equations.

The comparison is presented on the graph below. 
I am displaying the optimality measure ``1/2 x.T G x + c.T x + f`` 
*vs* the constraint violation ``|| A x - b||`` for different
optimization problems with each solving method a different collor.
Each different problem was solved by the three different methods:

- projected CG with normal equation approach;
- projected CG with augmented system approach; and,
- direct factorization of the Karush-Kuhn-Tucker equations.

The *augmented system approach* seems to provide a slightly more accurate
result compared with the *normal equation approach*.

![optimality_x_error_after](https://antonior92.github.io/files/optimality_x_error_after.png)


About the execution time: The normal equation approach is slightly (no more than 2x)
faster than the augmented system approach. The direct factorization is significantly
slower (more than 10x) for very large problems and can be slightly faster for small
problems compared to both CG methods. The executions times are compared on the
graph bellow for the same set of problems.

![execution_time_after](https://antonior92.github.io/files/execution_time_after.png)

References
----------
\[1\]&nbsp;&nbsp;&nbsp;[Jorge Nocedal, and Stephen J. Wright. "Numerical optimization"
Second Edition (2006).][1]

\[2\]&nbsp;&nbsp;&nbsp;[Nicholas I.M. Gould, Mary E. Hribar and Jorge Nocedal.
"On the solution of equality constrained quadratic programming problems arising
in optimization." SIAM Journal on Scientific Computing 23.4 (2001): 1376-1395.][2]

\[3\]&nbsp;&nbsp;&nbsp;[Istvan Maros and Csaba Meszaros  "A repository of
convex quadratic programming problems",  Optimization Methods and Software (OMS)
Volumes 11&12 (December, 1999), 671-681][3]

[1]: http://www.bioinfo.org.cn/~wangchao/maa/Numerical_Optimization.pdf
[2]: https://pdfs.semanticscholar.org/d959/8c935921efb5c4459fd6c55cf501cd578b45.pdf
[3]: http://www.doc.ic.ac.uk/rr2000/DTR97-6.pdf
