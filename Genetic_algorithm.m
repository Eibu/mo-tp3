classdef Genetic_algorithm
    %GENETIC_ALGORITHM 
    properties
        config;
        population;
        generation_counter;
        stop;
    end
    
    methods
        function obj = Genetic_algorithm(config)
            %GENETIC_ALGORITHM Initialize the population and the GA given
            %the configuration
            obj.config = config;
            obj.population = generate_population(obj.config);
            obj.generation_counter = 1;
            obj.stop = 0;
        end
        
        function obj = run(obj)
            %RUN main loop of the GA execution
            pop = evaluate(obj.population);
            while(~obj.stop)
                p1 = select(pop);
                popc = cross(p1);
                popm = mutate(p1);
                p1 = evaluate([popm popc]);
                pop = replace(pop,p1);
                obj = hasToStop(obj,pop);
            end
        end
        
        function population = evaluate(obj,population)
            population = obj.config.evaluate(obj.config,population);
        end
        
        function population = select(obj,population)
            population = obj.config.select(obj.config, population);
        end
        
        function population = mutate(obj,population)
            population = obj.config.mutate(obj.config,population);
        end
        
        function population = cross(obj,population)
            population = obj.config.cross(obj.config, population);
        end
        
        function population = replace(obj,parents, children)
            population = obj.config.replace(obj.config,parents, children);
        end
        
        function obj = hasToStop(obj,population)
            obj = obj.config.stopCriterion(obj,population);
        end
        
        function population = generate_population(~,config)
            population(config.population_size) = individual;
            N = length(config.distance_matrix);
            for i =1:config.population_size
                vars = 2:N;
                population(i).variables = vars(randperm(N-1));
            end
        end
    end
end

