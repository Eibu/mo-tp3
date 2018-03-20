function pop = insertion(config, pop)
    popSize = config.population_size;
    pop = pop(randperm(popSize, popSize * config.pm));
    
    for i=1:length(pop)
        vars = pop(i).variables;
        chromoLength = length(vars);
        
        indices = randi(chromoLength, 1, 2);
        fromIdx = max(indices);
        insertIdx = min(indices);
        
        vars(insertIdx:fromIdx) = [vars(fromIdx) vars(insertIdx:fromIdx - 1)];
        
        pop(i).variables = vars;
    end
end

