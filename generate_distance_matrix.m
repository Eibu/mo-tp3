function distMatrix = generate_distance_matrix(cities)
    countCities = length(cities);
    distMatrix = nan(countCities, countCities);
    
    % This can be speed up (triangular matrix with a diagonale of zeros).
    % But we don't care because it is only executed at the initialization
    for i=1:countCities
        for j=1:countCities
            distMatrix(i, j) = distance(cities(i), cities(j));
        end
    end
end

