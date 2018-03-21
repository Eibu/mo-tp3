function [population] = cycle_based_crossover(config,population)
%CYCLE_BASED_CROSSOVER Generates a new population using a cycle based
%crossover.
pc = config.pc;
N = length(population);
K = ceil(pc*N);
pop(K) = individual;

i= 1;
while i<=K
    p1 = population(ceil(rand()*N));
    p2 = population(ceil(rand()*N));
    pop(i).variables = generate_child(p1.variables,p2.variables);
    i=i+1;
end

end


function child = generate_child(p1,p2)
N= length(p1);    
i=1;
b1 = p1;%zeros(1,N);%List of booleans pointing out if the allele is already chosen
b2 = p2;%zeros(1,N);
i1 = 1;
child = zeros(1,N);
while i<=N && ~isempty(i1)
    if(b1(i1)~=0)
        child(i) = b1(i1);
        tmp = b1(i1)-1;
        b1(i1)=0;
        i1 = b2(tmp)-1;
        i=i+1;
    else
        %On récupère la première position non nulle dans b1
        i1 = find(b1,1,'first');
    end
end
end
