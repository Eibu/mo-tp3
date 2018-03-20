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
        problem;
    end
    
    methods
        function obj = configuration(problem, popSize, maxGen, pm, cross, mutate)
            obj.population_size = popSize;
            obj.max_generation = maxGen;
            obj.pm = pm;
            obj.pc = 1 - pm;
            obj.cross = cross;
            obj.mutate = mutate;
            
            obj.select = @(conf, pop) tournament(conf, pop);
            obj.evaluate = @(dist_matrix, pop) evaluation(dist_matrix, pop);
            obj.replace = @(conf, p, c) replace_worst(conf, p, c);
            obj.problem = problem;
        end
        
        function str = toString(obj)
            pbSize = num2str(length(obj.problem));
            crossover = configuration.fun2str(obj.cross);
            mutation = configuration.fun2str(obj.mutate);
            
            str = [pbSize, '-', crossover, '/', mutation];
        end
    end
    
    methods (Static, Access = private)
        function funStr = fun2str(fun)
            tokens = regexpi(func2str(fun), '\)\s*(\w+)', 'tokens', 'once');
            funStr = tokens{1};
        end
    end
end

