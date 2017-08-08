---
title: 'Numerical Results'
date: 2017-08-08
permalink: /posts/2017/00/NumericalResults/
tags:
  - GSoC 2017
  - Python
  - Scipy
  - Mathematical Programming
  - Optimization
---



I have implemented two solvers along my Google Summer of Code:
1. A Sequential Quadratic Programming (SQP) solver for equality-constrained problems, of the type:
\begin{eqnarray}
  \min_x && f(x), \\\\\\
   \text{subject to } && c(x) = 0. \\\\\\
\end{eqnarray}
A detailed description of this method can be found [here](https://antonior92.github.io/posts/2017/06/Byrd-Omojokun/).
2. An interior point solver capable of solving general nonlinear programing problems of the type:
\begin{eqnarray}
  \min_x && f(x), \\\\\\
   \text{subject to } && c_E(x) = 0,\\\\\\
   && c_I(x) \le 0,
\end{eqnarray}
This solver uses the SQP solver as a substep and is described
[here](https://antonior92.github.io/posts/2017/07/interior-point-method/).

I have tested both optimization algorithms on some problems from the CUTEst collection \[1\]. The
results of those tests are displayed on the table bellow. For each problem we give the number of variable
``n``, the number of constraints ``m``, the number of iterations ``niters``, the number of function evaluations 
``f evals``, the number of CG iteractions ``CG iters``, the total running time ``time`` and which ``method`` was used.
For problems with no inequalities constraints the ``equality_constrained_sqp`` method is used, otherwise the interior
point method ``tr_interior_point`` is used. This choice, is motivated by the fact that the interior point solver does
not offers any advantages in relation to ``equality_constrained_sqp`` when no inequality constraints are present.


**This blog post is a work in progress...**

|   name   | n  | m  |  niters  | f evals  | CG iters |   time   |   opt    |  c viol  |         method          |
|---------:|---:|---:|---------:|---------:|---------:|---------:|---------:|---------:|:-----------------------:|
| MARATOS  | 2  | 1  |    38    |    39    |    37    |   0.04   |7.5537e-09|9.3934e-12|equality_constrained_sqp |
| MARATOS  | 2  | 1  |    34    |    35    |    33    |   0.04   |8.3680e-09|3.5021e-12|equality_constrained_sqp |
|   ELEC   | 30 | 10 |    34    |    50    |   107    |   0.07   |3.4974e-09|4.0030e-16|equality_constrained_sqp |
|   ELEC   | 90 | 30 |    64    |   105    |   460    |   0.16   |7.3052e-08|5.2074e-16|equality_constrained_sqp |
|   ELEC   |150 | 50 |    76    |   125    |   368    |   0.32   |1.1155e-07|7.1951e-16|equality_constrained_sqp |
|  ROSEN   | 2  | 0  |    20    |    23    |    33    |   0.05   |1.6333e-12|0.0000e+00|equality_constrained_sqp |
|  ROSEN   | 20 | 0  |    99    |   131    |   600    |   0.23   |8.0429e-09|0.0000e+00|equality_constrained_sqp |
| ROSENBD  | 2  | 4  |    35    |    35    |    35    |   0.04   |3.4665e-09|0.0000e+00|    tr_interior_point    |
| ROSENBD  | 20 | 40 |    38    |    38    |    58    |   0.06   |1.8151e-09|3.1402e-16|    tr_interior_point    |
| ROSENIL  | 2  | 1  |    34    |    36    |    46    |   0.04   |6.9147e-09|1.5216e-17|    tr_interior_point    |
|  ROSENL  | 2  | 2  |    19    |    19    |    13    |   0.02   |1.5908e-09|2.7756e-17|    tr_interior_point    |
|  SINEQ   | 2  | 3  |    27    |    27    |    26    |   0.03   |2.2272e-09|2.8657e-16|    tr_interior_point    |

References
==========
\[1\]&nbsp;&nbsp;&nbsp;  [Gould, Nicholas IM, Dominique Orban, and Philippe L. Toint. "CUTEst: a constrained and unconstrained testing environment with safe threads for mathematical optimization." Computational Optimization and Applications 60.3 (2015): 545-557.][13]

[1]: ftp://www.hsl.rl.ac.uk/pub/nimg/pubs/GoulOrbaToin15_coap.pdf

