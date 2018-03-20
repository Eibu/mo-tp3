function [population] = partial_crossover(config, population)
%PARTIAL_CROSSOVER 
pc = config.pc;
N = length(population);
K = ceil(pc*N);
pop(K) = individual;

i= 1;
while i<K
    p1 = population(ceil(rand()*N));
    p2 = population(ceil(rand()*N));
    [pop(i).variables, pop(i+1).variables] = generate_child(p1.variables,p2.variables);
    i = i+2;
end


end

function [c1,c2] = generate_child(p1,p2)
    var_count = length(p1);
    idx = sort(ceil(rand(1,2)*var_count));
    root1 = p1(idx);
    root2 = p2(idx);
    
    
end