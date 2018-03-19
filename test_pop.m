function test_pop(pop)
    for i=1:length(pop)
        vars = pop(i).variables;
        sortedVars = sort(vars);
        assert(isequal(sortedVars, 2:length(vars) + 1));
    end
end

