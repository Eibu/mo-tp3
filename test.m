load('data.mat');

popSize = 100;
maxGen = 100;
pc = 0.1;

problems = {data10, data100};
cross = {
    @(conf, pop) mockCrossover(conf, pop)
};
mutate = {
    @(conf, pop) exchange(conf, pop), ...
    @(conf, pop) insertion(conf, pop), ...
    @(conf, pop) move(conf, pop), ...
    @(conf, pop) inversion(conf, pop)
};

countProblems = length(problems);
countCross = length(cross);
countMutate = length(mutate);

%load('metrics.mat')
metrics = metric(); % Reinitialize accumulated metrics

while 1 % For each sample
    for i=1:countProblems % For each problem
        initialPop = generate_population(popSize, length(problems{i}));
        
        for j=1:countCross % For each crossover
            for k=1:countMutate % For each mutation
                curConf = configuration(problems{i}, popSize, maxGen, pc, cross{j}, mutate{k});
                
                ga = genetic_algorithm(curConf, initialPop);
                pop = ga.run();
                
                metrics.addFitnessMeasure(curConf, pop);
                save('metrics.mat', 'metrics');
            end
        end
    end
end

metrics.displayGraph();

function pop = mockCrossover(config, pop)
    popSize = config.population_size;
    pop = pop(randperm(popSize, popSize * config.pc));
end