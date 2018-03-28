function pop = exchange(config, pop)
    popSize = config.population_size;
    % Extract population to mutate
    pop = pop(randperm(popSize, ceil(popSize * config.pm)));
    
    for i=1:length(pop)
        vars = pop(i).variables;
        chromoLength = length(vars);
        
        swapIndices = randi(chromoLength, 1, 2);
        vars(swapIndices) = vars(swapIndices(end:-1:1));
        
        pop(i).variables = vars;
    end
end

