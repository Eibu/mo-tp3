classdef genetic_algorithm
    %GENETIC_ALGORITHM 
    properties (Access = private)
        config;
        dist_matrix;
        population;
        generation_counter;
        stop;
    end
    
    methods
        function obj = genetic_algorithm(config)
            %GENETIC_ALGORITHM Initialize the population and the GA given
            %the configuration
            obj.config = config;
            obj.population = obj.generate_population(obj.config);
            obj.generation_counter = 1;
        end
        
        function obj = run(obj)
            %RUN main loop of the GA execution
            pop = obj.evaluate(obj.population);
            while(~obj.hasToStop())
                p1 = obj.select(pop);
                popc = obj.cross(p1);
                test_pop(popc); % TODO: Remove for the deliverable
                popm = obj.mutate(p1);
                test_pop(popm); % TODO: Remove for the deliverable
                p1 = obj.evaluate([popm popc]);
                pop = obj.replace(pop,p1);
            end
        end
    end
       
    methods(Access = private)
        function population = evaluate(obj,population)
            population = obj.config.evaluate(obj.config, population);
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
        
        function boolean = hasToStop(obj)
            if obj.generation_counter > obj.config.max_generation
                boolean = true;
            else
                boolean = false;
            end
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

