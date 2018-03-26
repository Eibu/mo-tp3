load('data.mat');

% ======================================================================
% PROBLEM LOAD METHOD (let only one commented)
% ----------------------------------------------------------------------
% Load an existant problem (data10, ...100, ...1000, ...10000, ...100000
problem = data100;
% ----------------------------------------------------------------------
% Generate a new problem with param as count cities (must be >= 4)
%problem = generate_problem(4);
% ======================================================================

% ============================================
% CONFIGURATION
% --------------------------------------------
% Param 1: Problem
% Param 2: Population size
% Param 3: Count max generation
% Param 4: Mutation probability
% Param 5: Crossover function
% Param 6: Mutation function
config = configuration(problem, 100, 100, 0.1, ...
    @position_crossover, ...
    @move ...
);
% ================================================================

ga = genetic_algorithm(config);
pop = ga.run();