function population = InitializePopulation(populationSize, numberOfCities)
    population = zeros(populationSize, numberOfCities);
    for i = 1:populationSize
        path = randperm(numberOfCities);
        population(i, :) = path;
    end
end
