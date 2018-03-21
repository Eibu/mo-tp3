classdef genetic_algorithm
    %GENETIC_ALGORITHM 
    properties (Access = private)
        config;
    end
    
    properties
        population;
        generation_counter;
        stop;
    end
    
    methods
        function obj = genetic_algorithm(config, initialPop)
            %GENETIC_ALGORITHM Initialize the population and the GA given
            %the configuration
            obj.config = config;
            obj.generation_counter = 1;
            obj.stop = false;
            if nargin == 2
                obj.population = initialPop;
            else
                obj.population = generate_population( ...
                    config.population_size, length(config.problem) ...
                );
            end
        end
        
        function pop = run(obj)
            %RUN main loop of the GA execution
            pop = obj.evaluate(obj.population);
            while(~obj.stop)
                obj.printStatus();
                p1 = obj.select(pop);
                popc = obj.cross(p1);
                test_pop(popc); % TODO: Remove for the deliverable
                popm = obj.mutate(p1);
                test_pop(popm); % TODO: Remove for the deliverable
                p1 = obj.evaluate([popm popc]);
                pop = obj.replace(pop,p1);
                obj = obj.hasToStop();
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
        
        function obj = hasToStop(obj)
            obj.generation_counter = obj.generation_counter + 1;
            if obj.generation_counter > obj.config.max_generation
                obj.stop = true;
            else
                obj.stop  = false;
            end
        end
        
        function printStatus(obj)            
            if obj.generation_counter == 1
                fprintf('%s - ', obj.config.toString());
            end
            
            fprintf('%d ', obj.generation_counter); 
            if obj.generation_counter == obj.config.max_generation
                fprintf('\n');
            end
        end
    end
end

