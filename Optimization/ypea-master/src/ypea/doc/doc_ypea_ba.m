%% Bees Algorithm
% This document shows how
% *Bees Algorithm (BA)*
% as a part of Yarpiz Evolutionary Algorithms Toolbox (YPEA)
% cab be used to solve optimization problems.

%% Problem Definition
% First of all, we need to define optimization problem. We must define the
% search space (decision variables) and objective function.

%%
% Let's ceate an instance of optimization problem.
problem = ypea_problem();

%%
% Assume that the problem is to find 20 real numbers, in range -10 to 10.
problem.vars = ypea_var('x', 'real', 'size', 20, 'lower_bound', -10, 'upper_bound', 10);

%%
% And, the objective is to minimize the well-known _sphere_ function
% in this domain.
sphere = ypea_test_function('sphere');
problem.obj_func = @(sol) sphere(sol.x);

%%
% To get more information on the optimization problems and decision variables,
% you can go to
% <doc_ypea_problem.html Optimization Problems> and
% <doc_ypea_var.html Decision Variables>.

%% Bees Algorithm
% Now, we are ready to create, initialize and utilize the
% Bees Algorithm (BA)
% to solve the optimization problem, defined above.

%%
% First, we must create an instance of algorithm class:
alg = ypea_ba();

%%
% There are two versions of the Bees Algorithm available in YPEA Toolbox:
% 
% * *Standard Bees Algorithm*,
% which can be set and used by |alg.type = 'standard'| or |'std'| simply.
% * *Probabilistic Bees Algorithm*,
% which can be set and used by |alg.type = 'probabilistic'| or |'prob'|
% simply.
% 

%%
% The parameters for the Standard BA are listed below:
% 
% * Ratio of Selected Sites to Population Size (|selected_site_ratio|, default: 0.5)
% * Ratio of Selected Sites Bees to Population Size (|selected_site_bee_ratio|, default: 0.1)
% * Ratio of Elite Sites to Selected Sites (|elite_site_ratio|, default: 0.4)
% * Ratio of Elite Sites Bees to Selected Sites Bees (|elite_site_bee_ratio|, default: 2)
% 

%%
% The only parameter for the Probabilistic BA is as follows:
% 
% * Ratio of Recruited Bees to Population Size (|recruited_bee_ratio|, default: 0.1)
% 

%%
% These properties are common in both of BA versions:
% 
% * Bee Dance Radius(|dance_radius|, default: 0.1)
% * Bee Dance Radius Damping Rate(|dance_radius_damp|, default: 0.99)
% 

%%
% Here, we use the standard version. Let's set the parameters of the algorithm.

% Maximum Number of Iterations
alg.max_iter = 1000;

% Population Size
alg.pop_size = 30;

% Type of Algorithm (Standard or Probabilistic)
alg.type = 'standard';

% Selected Sites Ratio (wrt. Scout Bee Count or Population Size)
alg.selected_site_ratio = 0.5;

% Selected Sites Bee Count Ratio (wrt. Scout Bee Count)
alg.selected_site_bee_ratio = 0.1;

% Elite Sites Ratio (wrt. Selected Sites Count)
alg.elite_site_ratio = 0.4;

% Elite Sites Bee Count Ratio (wrt. Selected Sites Bee Count)
alg.elite_site_bee_ratio = 2;

% Bees Dance Radius
alg.dance_radius = 0.1;

% Bees Dance Radius Damp Rate
alg.dance_radius_damp = 0.99;
        
%%
% And now, we are ready to run the algorithm and solve the problem.
% The solve method, gets problem as input and returns |best_sol|, the best solution found
% by the algorithm.

best_sol = alg.solve(problem);

%%
% You may turn of the text output, by disabling the display property, just
% befor running the algorithm (i.e. calling |alg.solve(problem)|).
alg.display = false;

%% Results

%%
% The actual solution, is stored in the |solution| field of |best_sol|.

best_sol.solution

%%
% The values of 20 decision variables, denoted by |x| is as follows:
best_sol.solution.x

%%
% and the related objective value is:
best_sol.obj_value

%%
% Total run time of the algorithm is given by (in seconds):
alg.run_time

%%
% and total number of function evaluations is given by:
alg.nfe

%%
% We can illustrate the result of optimization process by plotting
% best objective value history (|alg.best_obj_value_history|)
% vs. number of function evaluations (|alg.nfe_history|).

figure;
alg.semilogy('nfe', 'LineWidth', 2);
xlabel('NFE');
ylabel('Best Objective Value');
title(['Results of ' alg.full_name]);
grid on;
