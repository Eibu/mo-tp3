load('data.mat');

popSize = 100;
maxGen = 100;
pc = 0.1;

problems = { data1000 };
cross = {
    @partial_crossover, ...
    @position_crossover, ...
    @cycle_based_crossover
};
mutate = {
    @exchange, ...
    @insertion, ...
    @move, ...
    @inversion
};

countProblems = length(problems);
countCross = length(cross);
countMutate = length(mutate);

%load('metrics.mat')
metrics = metric(); % Reinitialize accumulated metrics

s = 1;
while 1 % For each sample
    fprintf('Sample %d\n', s);
    
    for i=1:countProblems % For each problem
        initialPop = generate_population(popSize, length(problems{i}));
        
        for j=1:countCross % For each crossover
            for k=1:countMutate % For each mutation
                curConf = configuration(problems{i}, popSize, maxGen, pc, cross{j}, mutate{k});
                
                ga = genetic_algorithm(curConf, initialPop);
                pop = ga.run();
                
                metrics.addFitnessMeasure(curConf, pop);
            end
        end
    end
    
    save('metrics1000.mat', 'metrics');
    s = s + 1; % Increment sample
end

metrics.testHypothesis();