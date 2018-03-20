function pop = evaluation(config, pop)
    for i=1:length(pop)
        vars = pop(i).variables;
        cities = config.problem;
        
        % Append distance between the start city (1) and the second
        % unknown city at compile-time (vars(1))
        dist = distance(cities(1,:), cities(vars(1),:));
        
        for j=1:length(vars)-1
            dist = dist + distance(cities(vars(j),:), cities(vars(j+1),:));
        end
        
        % Hamiltonian's cycle, so connect the last city to the known start
        % city
        dist = dist + distance(cities(vars(j),:), cities(1,:));
        
        pop(i).fitness = dist;
    end
end

