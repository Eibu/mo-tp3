function population = generate_population(popSize, countCities)
    population(popSize) = individual;
    for i=1:popSize
        vars = 2:countCities;
        population(i).variables = vars(randperm(countCities - 1));
    end
end