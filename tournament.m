function [population] = tournament(config,population)
N = length(population);

k=2;
perms = [randperm(N);randperm(N)];

pop(N) =individual;

for i =1:N
    pop(i) = bestOf(population(perms(1,i)),population(perms(2,i)));
end
population = pop;
end

function [best,worst] = bestOf(i1,i2)
if i1.fitness<i2.fitness
    best = i1;
    worst = i2;
else
    best = i2;
    worst = i1;
end
end