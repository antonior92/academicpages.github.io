---
title: 'GSoC 2017 - Submission'
date: 2017-08-24
permalink: /posts/2017/24/GSoC-proposal/
tags:
  - GSoC 2017
  - Python
  - Scipy
  - Mathematical Programming
  - Optimization
---

During the last few months I have worked on my Google Summer of Code (GSoC) project, that 
consists of implementing a large-scale optimization algorithm to be integrated to Scipy.

The algorithm implemented was an interior point method
described [here](https://antonior92.github.io/posts/2017/07/interior-point-method/).
A series of blog post describe different aspects of the algorithm and its use 
([link](https://antonior92.github.io/tags/#gsoc-2017)).

The implementation can be found on the separate repository:

[https://github.com/antonior92/ip-nonlinear-solver](https://github.com/antonior92/ip-nonlinear-solver)

and is being integrated to SciPy through the pull request:

[https://github.com/scipy/scipy/pull/7729](https://github.com/scipy/scipy/pull/7729)

During my GSoC I have implemented the optimization algorithm, tested it on almost one hundred examples 
([link](https://antonior92.github.io/posts/2017/00/NumericalResults/)) and created
an interface for using it. While the optimization solver is ready to be used and tested,
there are still a features I want to include, namely quasi-Newton approximations to the Hessian matrix including:

- SR1 approximation;
- BFGS approximation; and,
- L-BFGS approximation.
    
I included those as *optional* items on my GSoC proposal and, unfortunately, they will not be ready for the GSoC submission. 
Furthermore, there are still some questions about how to best integrate my implementation to the optimization
SciPy library that are still under discussion. However, I will tend to those final points in the weeks following the end of the program.

Finally, I would like to thanks Google for this awesome oportunity and
my mentors: Nikolay, Matt and Ralf for teaching me so much during this three months,
provinding me the insightful comments and interest conversations. It has been a pleasure
working with the three of you.

