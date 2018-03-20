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
            % 1 figure = 1 problem
            % y as best average fitness with error bar
            % x as configuration mutation/crossover
            
            figure
            
            mappedResults = obj.getMappedResults();
            problemsKeys = mappedResults.keys;
            problemsSize = length(problemsKeys);
            
            for i=1:problemsSize
                problemKey = problemsKeys{i};
                problem = mappedResults(problemKey);
                
                combsKeys = problem.keys;
                combsSize = length(combsKeys);
                
                combsName = cell(1, combsSize);
                fitnessesMeans = nan(1, combsSize);
                fitnessesError = nan(1, combsSize);
                
                for j=1:combsSize
                    combKey = combsKeys{j};
                    fitnesses = problem(combKey);
                    
                    fitnessMean = mean(fitnesses);
                    fitnessesMeans(j) = fitnessMean;
                    
                    % Compute margin of error
                    fitnessStddev = std(fitnesses);
                    sampleSize = length(fitnesses);
                    confidence = 0.95;
                    alpha = (1 - confidence) / 2;
                    degFreedom = sampleSize - 1;
                    t = tinv(alpha, degFreedom);
                    fitnessesError(j) = t*fitnessStddev/sqrt(sampleSize);
                    
                    combsName{j} = sprintf('%s%s%s', ...
                        '\begin{tabular}{c}', ...
                        strrep(combKey, '/', '\\'), ...
                        '\end{tabular}' ...
                    );
                end
                
                subplot(problemsSize, 1, i);
                errorbar(fitnessesMeans, fitnessesError, 'x');
                set(gca, 'XTick', 1:combsSize, 'XTickLabel', combsName, 'TickLabelInterpreter', 'latex');
                xlim([0.5, combsSize+0.5]);
                title(['Problem size:', ' ', problemKey]);
                ylabel("Sample's mean fitnesses");
            end
        end
    end
    
    methods (Access = private)        
        function mappedResults = getMappedResults(obj)
            mappedResults = containers.Map();
            keys = obj.data.keys;
            
            for i=1:length(keys)
                key = keys{i};
                tokens = regexpi(key, '(\w+)', 'tokens');
                pb = tokens{1}{1};
                comb = sprintf('%s/%s', tokens{2}{1}, tokens{3}{1});
                
                if ~mappedResults.isKey(pb)
                    mappedResults(pb) = containers.Map();
                end
                
                pbComb = mappedResults(pb);
                pbComb(comb) = obj.data(key);
                mappedResults(pb) = pbComb;
            end
        end
    end
end

