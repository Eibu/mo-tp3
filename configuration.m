classdef configuration
    properties
        % To be defined by user
        population_size;
        max_generation;
        pm;
        cross;
        mutate;
        
        pc;
        select;
        evaluate;
        replace;
        distance_matrix;
    end
    
    methods
        function obj = configuration(countCities, popSize, maxGen, pm, cross, mutate)
            obj.population_size = popSize;
            obj.max_generation = maxGen;
            obj.pm = pm;
            obj.pc = 1 - pm;
            obj.cross = cross;
            obj.mutate = mutate;
            
            obj.select = @(conf, pop) tournament(conf, pop);
            obj.evaluate = @(dist_matrix, pop) evaluation(dist_matrix, pop);
            obj.replace = @(conf, p, c) replace_worst(conf, p, c);
            obj.distance_matrix = generate_distance_matrix(...
                generate_problem(countCities));
        end
    end
end

