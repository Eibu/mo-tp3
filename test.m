% Param 1: Problem size (count of cities)
% Param 2: Population size
% Param 3: Count max generation
% Param 4: Mutation probability
% Param 5: Crossover function
% Param 6: Mutation function
config = configuration(3, 100, 100, 0.1, ...
    @(conf, pop) mockCrossover(conf, pop), ...
    @(conf, pop) mockMutation(conf, pop) ...
);

ga = genetic_algorithm(config);
ga.run();

function pop = mockCrossover(~, pop); end
function pop = mockMutation(~, pop); end