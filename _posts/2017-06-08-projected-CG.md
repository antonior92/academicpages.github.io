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
is computed in rather economic fashion by using only the precious
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

The idea of this method is to choose a initial point $x_0$,
such that $x_0$ satisfy the constraints:

\begin{equation}
  A x_0 = b,
\end{equation}

and to choose the update vectors $p_k$ in the null space of 
$A$, such that:
\begin{equation}
  A p_k = b,
\end{equation}

It follows that for:

\begin{equation}
  x_k = x_0 + (\alpha_0 p_0 + \cdots + \alpha_{n-1} p_{k-1}),
\end{equation}

we have $A x_k = A x_0 + 0 = b$. While, getting progressively
close to the optimal value of $\phi(x)$.


References
----------
\[1\]&nbsp;&nbsp;&nbsp;[Jorge Nocedal, and Stephen J. Wright. "Numerical optimization"
Second Edition (2006).][1]

\[2\]&nbsp;&nbsp;&nbsp; [Nicholas I.M. Gould, Mary E. Hribar and Jorge Nocedal.
"On the solution of equality constrained quadratic programming problems arising
in optimization." SIAM Journal on Scientific Computing 23.4 (2001): 1376-1395.][2]

[1]: http://www.bioinfo.org.cn/~wangchao/maa/Numerical_Optimization.pdf
[2]: https://pdfs.semanticscholar.org/d959/8c935921efb5c4459fd6c55cf501cd578b45.pdf
