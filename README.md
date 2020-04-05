# MATLAB code for mutation based GPS and PSOGSA

Code to perform function optimization.

### This is code for paper entitled - "Fuzzy Mutation Embedded Hybrids of Gravitational Search and Particle Swarm Optimization Methods for Engineering Design Problems"

## The code given is for two algorithms:
* Mutation based GPS (MGPS)
* Mutation based PSOGSA (MPSOGSA) 

## Parameters

The following parameters must be set in main.m file for MPSOGSA & MGPS
* num - the number of runs per function
* functionCount - the number of functions you want to execute

Additionally for MGPS yolu can set
* rho & phi - values to set the fuzzy membership function parameters

Parameters to set for MGPS and MPSOGSA
* n - population size
* iter - iteration to be executed

Note: To optimize engineering problems code must be changed, uncomment all function calls with engg and comment the ones without

## Running the code
* Set all the required parameters in the files specified above
* run file _main.m_

Link for algorithm details: [Paper]()

## Abstract:

Gravitational Search Algorithm (GSA) and Particle Swarm Optimization (PSO) are nature-inspired, swarm-based optimization algorithms respectively. Though they have been widely used for single-objective optimization since their inception, they suffer from premature convergence. Even though the hybrids of GSA and PSO perform much better, the problem remains. Hence, to solve this issue we have proposed a fuzzy mutation model for two hybrid versions of PSO and GSA – Gravitational Particle Swarm (GPS) and PSOGSA. The developed algorithms are called Mutation based GPS (MGPS) and Mutation based PSOGSA (MPSOGSA). The mutation operator is based on a fuzzy model where the probability of mutation has been calculated based on the closeness of particle to population centroid and improvement in the particle value. We have evaluated these two new algorithms on 23 benchmark functions of three categories (unimodal, multi-modal and multi-modal with fixed dimension). The experimental outcome shows that our proposed model outperforms their corresponding ancestors, MGPS outperforms GPS 13 out of 23 times (56.52%) and MPSOGSA outperforms PSOGSA 17 times out of 23 (73.91%). We have also compared our results against those of recent optimization algorithms such as Sine Cosine Algorithm (SCA), Opposition-Based SCA, and Volleyball Premier League Algorithm (VPL).  In addition, we have applied our proposed algorithms on some classic engineering design problems and the outcomes are satisfactory.