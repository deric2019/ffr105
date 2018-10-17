function population = InitializePopulation(populationSize, chromosomeLength, weightRange)
    population = zeros(1, chromosomeLength);
    for i = 1:populationSize
        population(i, :) = GenerateRandomChromosome(chromosomeLength, weightRange);
    end
end
