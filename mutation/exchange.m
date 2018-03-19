function pop = exchange(~, pop)
    for i=1:length(pop)
        vars = pop(i).variables;
        chromoLength = length(vars);
        
        swapIndices = randi(chromoLength, 1, 2);
        vars(swapIndices) = vars(swapIndices(end:-1:1));
        
        pop(i).variables = vars;
    end
end

