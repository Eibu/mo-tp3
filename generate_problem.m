% Longitude (x) as first coord and latitude (y) as second coord
function cities = generate_problem(countCities)
    cities = countCities * (rand(countCities, 2) - 0.5);
end