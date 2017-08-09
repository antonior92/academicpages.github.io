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

In this blog post, I will present numerical results obtained
solving problems from the CUTEst collection \[1\] using the algorithms
implemented during my GSoC project.

Let us consider two solvers:

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

I have tested both solvers and the results are displayed on the table bellow. For each problem we give the number of variable
``n``, the number of constraints ``m``, the number of iterations ``niters``, the number of function evaluations 
``f evals``, the number of CG iteractions ``CG iters``, the total running time ``time`` and which ``method`` was used.
For problems with no inequalities constraints the ``equality_constrained_sqp`` method is used, otherwise the interior
point method ``tr_interior_point`` is used. This choice is motivated by the fact that the interior point solver does
not offers any advantages in relation to ``equality_constrained_sqp`` when no inequality constraints are present
and, on the other hand, the SQP solver cannot deals with inequality constraints.


**This blog post is a work in progress...**

|   name   |  n  |  m  |  niters  | f evals  | CG iters |   time   |   opt    |  c viol  |         method          |
|---------:|----:|----:|---------:|---------:|---------:|---------:|---------:|---------:|:-----------------------:|
| CORKSCRW | 456 | 350 |   100    |   109    |   346    |   1.98   |2.8541e-09|1.0846e-13|    tr_interior_point    |
| COSHFUN  | 61  | 20  |   1001   |   1930   |   7049   |   8.54   |3.5715e-07|4.9051e-11|    tr_interior_point    |
| DIXCHLNV | 100 | 50  |    38    |    38    |   288    |   0.69   |7.0484e-09|1.1749e-15|    tr_interior_point    |
|  HAGER4  |2001 |1000 |    54    |    54    |   1030   |   4.6    |3.3627e-09|1.4004e-11|    tr_interior_point    |
| HIMMELBK | 24  | 14  |   149    |   179    |   144    |   0.93   |5.1554e-09|7.7543e-10|    tr_interior_point    |
|  NGONE   | 100 |1273 |   1001   |   1938   |   3628   |  151.54  |4.9984e-07|3.9074e-10|    tr_interior_point    |
| OPTCNTRL | 32  | 20  |   1001   |   1001   |   1046   |   6.95   |1.1222e-06|9.4568e-09|    tr_interior_point    |
| OPTMASS  |1210 |1005 |   188    |   344    |   184    |   7.29   |1.4742e-12|1.6496e-10|    tr_interior_point    |
| ORTHREGF |1205 | 400 |    44    |    51    |    53    |   1.56   |5.2493e-09|2.5644e-15|    tr_interior_point    |
| SVANBERG | 500 | 500 |    62    |    63    |   3378   |   6.11   |8.8827e-09|8.6149e-14|    tr_interior_point    |
| READING1 | 202 | 100 |    63    |   105    |    53    |   0.83   |4.8747e-11|1.2413e-10|    tr_interior_point    |
|   HS7    |  2  |  1  |    9     |    9     |    8     |   0.05   |1.7663e-15|2.6645e-14|equality_constrained_sqp |
|   HS10   |  2  |  1  |    21    |    21    |    22    |   0.12   |6.5597e-10|6.5574e-10|    tr_interior_point    |
|   HS11   |  2  |  1  |    14    |    14    |    13    |   0.1    |1.4302e-09|1.0440e-10|    tr_interior_point    |
|   HS13   |  2  |  1  |    50    |    50    |    52    |   0.42   |8.0145e-09|3.1270e-18|    tr_interior_point    |
|   HS14   |  2  |  2  |    16    |    16    |    9     |   0.11   |4.7773e-10|5.4949e-11|    tr_interior_point    |
|   HS16   |  2  |  2  |    27    |    27    |    20    |   0.2    |9.6985e-09|1.8605e-16|    tr_interior_point    |
|   HS17   |  2  |  2  |    39    |    39    |    43    |   0.33   |3.4599e-09|1.7653e-11|    tr_interior_point    |
|   HS19   |  2  |  2  |    36    |    36    |    33    |   0.28   |1.1376e-12|2.2665e-14|    tr_interior_point    |
|   HS20   |  2  |  3  |    24    |    24    |    25    |   0.23   |1.4164e-10|1.1013e-12|    tr_interior_point    |
|   HS22   |  2  |  2  |    19    |    19    |    14    |   0.12   |7.6461e-09|6.5655e-10|    tr_interior_point    |
|   HS24   |  2  |  3  |    21    |    21    |    17    |   0.15   |4.9476e-13|1.6477e-16|    tr_interior_point    |
|   HS26   |  3  |  1  |    24    |    24    |    45    |   0.12   |1.2401e-11|9.7725e-09|equality_constrained_sqp |
|   HS28   |  3  |  1  |    3     |    3     |    3     |   0.02   |1.5418e-16|4.4409e-16|equality_constrained_sqp |
|   HS31   |  3  |  1  |    15    |    15    |    20    |   0.12   |3.4163e-09|1.9565e-11|    tr_interior_point    |
|   HS32   |  3  |  2  |    28    |    28    |    26    |   0.26   |3.4507e-09|7.1498e-14|    tr_interior_point    |
|   HS33   |  3  |  2  |    33    |    33    |    35    |   0.26   |3.3100e-13|7.8756e-12|    tr_interior_point    |
|   HS39   |  4  |  2  |    16    |    16    |    18    |   0.07   |1.4408e-11|4.1362e-12|equality_constrained_sqp |
|   HS46   |  5  |  2  |   102    |   184    |   261    |   0.51   |8.6871e-09|2.6427e-14|equality_constrained_sqp |
|   HS51   |  5  |  3  |    12    |    12    |    11    |   0.06   |3.0334e-09|9.4857e-16|equality_constrained_sqp |
|   HS52   |  5  |  3  |    2     |    2     |    2     |   0.01   |4.6788e-15|1.3895e-16|equality_constrained_sqp |
|   HS53   |  5  |  3  |   1001   |   1872   |   939    |   2.36   |1.4025e-08|8.3267e-17|    tr_interior_point    |
|   HS63   |  3  |  2  |    14    |    14    |    7     |   0.09   |7.7729e-11|6.6601e-10|    tr_interior_point    |
|   HS64   |  3  |  1  |    36    |    36    |    58    |   0.29   |2.6309e-11|3.2196e-15|    tr_interior_point    |
|   HS65   |  3  |  1  |    24    |    24    |    32    |   0.2    |5.7424e-10|5.2259e-10|    tr_interior_point    |
|   HS70   |  4  |  1  |    46    |    63    |    83    |   0.39   |9.2118e-09|2.2204e-16|    tr_interior_point    |
|   HS71   |  4  |  2  |    22    |    22    |    26    |   0.22   |9.8833e-09|6.4218e-10|    tr_interior_point    |
|   HS72   |  4  |  2  |    42    |    42    |    65    |   0.39   |2.7946e-14|1.4552e-11|    tr_interior_point    |
|   HS73   |  4  |  3  |    25    |    25    |    22    |   0.23   |1.1041e-13|1.3603e-13|    tr_interior_point    |
|   HS74   |  4  |  5  |    18    |    18    |    12    |   0.17   |8.0469e-12|3.2005e-09|    tr_interior_point    |
|   HS75   |  4  |  5  |   107    |   107    |   102    |   1.05   |3.7378e-09|4.4060e-11|    tr_interior_point    |
|   HS77   |  5  |  2  |    20    |    22    |    38    |   0.11   |4.7209e-09|3.6367e-15|equality_constrained_sqp |
|   HS78   |  5  |  3  |    5     |    5     |    4     |   0.03   |9.7961e-11|8.2989e-11|equality_constrained_sqp |
|   HS79   |  5  |  3  |    7     |    7     |    12    |   0.04   |2.0000e-11|1.3042e-11|equality_constrained_sqp |
|   HS80   |  5  |  3  |    14    |    19    |    8     |   0.12   |6.9949e-10|3.8881e-11|    tr_interior_point    |
|   HS81   |  5  |  3  |    15    |    20    |    9     |   0.12   |6.9949e-10|3.8882e-11|    tr_interior_point    |
|   HS83   |  5  |  3  |    56    |    56    |    62    |   0.46   |6.5452e-09|1.1399e-14|    tr_interior_point    |
|   HS84   |  5  |  3  |   144    |   167    |   174    |   1.19   |9.6493e-09|2.5099e-10|    tr_interior_point    |
|   HS85   |  5  | 21  |    73    |    84    |    88    |   0.87   |8.2173e-09|9.0105e-10|    tr_interior_point    |
|   HS86   |  5  | 10  |    41    |    43    |    76    |   0.33   |4.7382e-09|9.4317e-14|    tr_interior_point    |
|   HS93   |  6  |  2  |    43    |    45    |    99    |   0.34   |2.2679e-11|1.5716e-15|    tr_interior_point    |
|   HS95   |  6  |  4  |   492    |   501    |   491    |   3.01   |6.9577e-09|2.3913e-12|    tr_interior_point    |
|   HS96   |  6  |  4  |    79    |    82    |    95    |   0.54   |2.0082e-09|1.0687e-13|    tr_interior_point    |
|   HS97   |  6  |  4  |   425    |   436    |   546    |   2.93   |1.1772e-09|6.3112e-13|    tr_interior_point    |
|   HS98   |  6  |  4  |   524    |   533    |   766    |   3.59   |5.5282e-09|1.8940e-10|    tr_interior_point    |
|   HS99   |  7  |  2  |   1001   |   1829   |   1514   |   2.36   |6.8266e-03|1.0186e-10|    tr_interior_point    |
|  HS100   |  7  |  4  |    73    |    80    |   197    |   0.47   |4.5828e-11|2.1825e-14|    tr_interior_point    |
|  HS104   |  8  |  5  |    44    |    44    |   118    |   0.38   |6.8429e-09|6.1062e-15|    tr_interior_point    |
|  HS106   |  8  |  6  |   568    |   586    |   1055   |   4.99   |9.4742e-09|2.2066e-10|    tr_interior_point    |
|  HS107   |  9  |  6  |    28    |    28    |    37    |   0.22   |9.8416e-09|6.5892e-16|    tr_interior_point    |
|  HS108   |  9  | 13  |    50    |    59    |    88    |   0.37   |3.4345e-09|3.9154e-10|    tr_interior_point    |
|  HS111   | 10  |  3  |   470    |   582    |   644    |   3.69   |3.8922e-09|3.0453e-14|    tr_interior_point    |
|  HS112   | 10  |  3  |    52    |    52    |   137    |   0.47   |1.1325e-09|1.1365e-16|    tr_interior_point    |
|  HS113   | 10  |  8  |    42    |    43    |   143    |   0.34   |4.4825e-09|1.1870e-13|    tr_interior_point    |
|  HS114   | 10  | 11  |   595    |   595    |   1481   |   6.58   |1.1663e-09|1.4904e-12|    tr_interior_point    |
|  HS116   | 13  | 14  |   138    |   160    |   342    |   1.33   |2.9978e-09|6.8222e-11|    tr_interior_point    |
|  HS117   | 15  |  5  |    37    |    38    |   127    |   0.54   |3.0070e-09|5.0810e-14|    tr_interior_point    |
|  HS118   | 15  | 17  |    69    |    69    |   140    |   0.7    |1.1383e-09|2.7173e-14|    tr_interior_point    |
|  HS119   | 16  |  8  |    43    |    43    |   131    |   0.44   |6.6745e-09|9.4581e-15|    tr_interior_point    |
|  HAGER2  |10001|5000 |    9     |    9     |    8     |  14.49   |2.1427e-09|2.7941e-11|equality_constrained_sqp |
|  HAGER3  |10001|5000 |    10    |    10    |    9     |  15.79   |7.9463e-09|3.2307e-11|equality_constrained_sqp |
|   ELEC   | 600 | 200 |   102    |   171    |   893    |  17.14   |2.8875e-05|1.5981e-15|equality_constrained_sqp |
| ORTHREGA |2053 |1024 |    81    |   128    |   179    |  17.99   |7.7269e-09|7.1724e-15|equality_constrained_sqp |
| ORTHREGC |1005 | 500 |    45    |    71    |    89    |   1.27   |2.9254e-09|3.8118e-15|equality_constrained_sqp |
| ORTHREGD |10003|5000 |    45    |    45    |    86    |  136.9   |1.7863e+00|3.8711e-12|equality_constrained_sqp |
| DTOC1ND  |2998 |1996 |    27    |    36    |    48    |   2.77   |4.4776e-08|2.0836e-14|equality_constrained_sqp |
|  DTOC2   |2998 |1996 |    15    |    15    |   302    |   3.11   |6.9793e-09|2.9939e-15|equality_constrained_sqp |
|  DTOC3   |14999|9998 |    12    |    12    |    10    |  96.19   |3.0341e-09|7.7854e-14|equality_constrained_sqp |
|  DTOC4   |14999|9998 |    8     |    8     |    7     |  80.21   |9.5360e-09|4.7457e-14|equality_constrained_sqp |
|  DTOC5   |9999 |4999 |    11    |    11    |    10    |   19.7   |8.3983e-09|1.7489e-14|equality_constrained_sqp |
|  DTOC6   |2001 |1000 |    21    |    21    |    42    |   1.18   |6.6047e-09|4.8743e-15|equality_constrained_sqp |
| EIGENA2  |2550 |1275 |    5     |    5     |    4     |   0.79   |7.4082e-14|0.0000e+00|equality_constrained_sqp |
| EIGENC2  | 462 | 231 |    32    |    40    |   338    |   0.99   |6.7057e-09|5.3904e-16|equality_constrained_sqp |
|  ARTIF   |1002 |1000 |    11    |    11    |    0     |   0.37   |0.0000e+00|1.5652e-09|equality_constrained_sqp |
| BRATU3D  |4913 |3375 |    6     |    6     |    0     |   9.67   |0.0000e+00|1.8642e-09|equality_constrained_sqp |

References
==========
\[1\]&nbsp;&nbsp;&nbsp;  [Gould, Nicholas IM, Dominique Orban, and Philippe L. Toint. "CUTEst: a constrained and unconstrained testing environment with safe threads for mathematical optimization." Computational Optimization and Applications 60.3 (2015): 545-557.][1]

[1]: ftp://www.hsl.rl.ac.uk/pub/nimg/pubs/GoulOrbaToin15_coap.pdf

