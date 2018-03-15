classdef individual
    %INDIVIDUAL 
    properties
        variables;
        fitness;
    end
    
    methods
        function str = toString(obj)
            str = strcat('Variables : ',obj.variables,'\nFitness :',obj.fitness);
        end
    end
end

