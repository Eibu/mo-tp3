classdef metric
    %METRIC Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        % Dim 1: Problem
        % Dim 2: Config
        % Dim 3: Results
        data
    end
    
    methods
        function obj = metric()
            obj.data = containers.Map();
        end
        
        function obj = addFitnessMeasure(obj, conf, pop)
            bestFitness = inf;
            
            % Retrieve best fitness in the population
            for i=1:length(pop)
                curFitness = pop(i).fitness;
                
                if curFitness < bestFitness
                    bestFitness = curFitness;
                end
            end
            
            confKey = conf.toString(); % Get pb and conf map key
            if ~obj.data.isKey(confKey) % Initialize if conf not present
                obj.data(confKey) = [];
            end
            obj.data(confKey) = [obj.data(confKey), bestFitness]; % Append
        end
        
        function displayGraph(obj)
        end
    end
end

