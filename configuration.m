classdef configuration
    %CONFIGURATION 
    properties
        population_size;
        max_generation;
        pc;
        pm;
        select;
        cross;
        mutate;
        evaluate;
        replace;
        distance_matrix;
    end
    
    methods
        function obj = configuration(population_size, max_generation, ...
                pm, select, cross, mutate,evaluate,replace,distance_matrix)
            
            %CONFIGURATION 
            obj.population_size = population_size;
            obj.max_generation = max_generation;
            obj.pm = pm;
            obj.pc = 1-pm;
            obj.select = select;
            obj.cross = cross;
            obj.mutate = mutate;
            obj.evaluate = evaluate;
            obj.replace = replace;
            obj.distance_matrix = distance_matrix;
        end
        
    end
end

