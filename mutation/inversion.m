function pop = inversion(config, pop)
    popSize = config.population_size;
    % Extract population to mutate
    pop = pop(randperm(popSize, ceil(popSize * config.pm)));
    
    for i=1:length(pop)
        vars = pop(i).variables;
        
        % Choose a random segment
        indices = randi([2, length(vars) - 1], 1, 2);
        fromIdx = min(indices);
        toIdx = max(indices);
        
        % Extract the segment
        segment = vars(toIdx:-1:fromIdx);
        vars(fromIdx:toIdx) = []; % Remove segment from variables
        
        % Place the segment at a random place
        insertIdx = randi(length(vars));
        vars = [vars(1:insertIdx - 1), segment, vars(insertIdx:end)];
        
        pop(i).variables = vars;
    end
end

