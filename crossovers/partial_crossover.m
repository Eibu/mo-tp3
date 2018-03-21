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
    idx = sort(ceil(rand(1,2)*(var_count-2)+1));
    root1 = p1(idx(1):idx(2));
    root2 = p2(idx(1):idx(2));
    c1 = concat_lists(p1,root2,idx);
    c2 = concat_lists(p2,root1,idx);
    if ~all(ismember(root1,root2))
        for i = 1:idx(1)-1
            if(ismember(c1(i),root2))
                c1(i)= get_perm(c1(i),root2,root1);
            end
            if(ismember(c2(i),root1))
                c2(i)= get_perm(c2(i),root1,root2);
            end
        end
        for i = idx(2)+1:var_count
            if(ismember(c1(i),root2))
                c1(i) = get_perm(c1(i),root2,root1);
            end
            if(ismember(c2(i),root1))
                c2(i)= get_perm(c2(i),root1,root2);
            end
        end
    end
end

function p = get_perm(val, v1,v2)
    p = val;
    while ismember(p,v1)
        p = v2(v1==p);
    end
end

function [result] = concat_lists(li,root,idx)
    result = [li(1:(idx(1)-1)) root li((idx(2)+1):length(li))];
end