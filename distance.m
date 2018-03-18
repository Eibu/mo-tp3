function dist = distance(city1, city2)
    to = city2 - city1;
    dist = sqrt(sum(to.^2));
end

