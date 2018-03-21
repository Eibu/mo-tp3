function [population] = position_crossover(config,population)
%POSITION_CROSSOVER 
pc = config.pc;
N = length(population);
K = ceil(pc*N);
pop(K) = individual;
 i= 1;
 while i <= K
     p1 = population(ceil(rand()*N));
     p2 = population(ceil(rand()*N));
     pop(i).variables = generate_child(p1.variables, p2.variables);
     i = i+1;
 end
population = pop;
end


function child = generate_child(p1,p2)
    N = length(p1);
    idx = randi([1 N],[1 ceil(sqrt(N))]);
    child = p1.*ismember(p1,idx);
    p2bis = p2(~ismember(p2,idx));
    pi = 1;
    for i= 1 :N
        if(child(i)==0)
            child(i) = p2bis(pi);
            pi = pi+1;
        end
    end
end