function population = generate_population(config)
    population(config.population_size) = individual;
    N = length(config.distance_matrix);
    for i =1:config.population_size
        vars = 2:N;
        population(i).variables = vars(randperm(N-1));
    end
end