function pop = evaluation(config, pop)
    for i=1:length(pop)
        vars = pop(i).variables;
        
        % Append distance between the start city (1) and the second
        % unknown city at compile-time (vars(1))
        dist = config.distance_matrix(1, vars(1));
        
        for j=1:length(vars)-1
            dist = dist + config.distance_matrix(vars(j), vars(j + 1));
        end
        
        % Hamiltonian's cycle, so connect the last city to the known start
        % city
        dist = dist + config.distance_matrix(vars(j), 1);
        
        pop(i).fitness = dist;
    end
end

