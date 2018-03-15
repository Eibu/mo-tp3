function [population] = fitness_based_replacement(config,parents,children)
%FITNESS_BASED_REPLACEMENT 
N = config.population_size;
population = [parents children];
fitnesses = [population.fitness];
[~,order] = sort(fitnesses,'ascend');
population = population(order);
population = population(1:N);
end

