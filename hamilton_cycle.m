function  hamilton_cycle(individual,config)
%HAMILTON_CYCLE 
distance = sqrt(individual.fitness);
var = [1 individual.variables 1];
cities = config.problem;
cycle = cities(var,:);
x = cycle(:,1);
y= cycle(:,2);
plot(x,y,'-*');
legend(strcat('Hamilton cycle, distance : ',num2str(distance)));
end

