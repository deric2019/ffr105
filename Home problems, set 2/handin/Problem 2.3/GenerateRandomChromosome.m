function chromosome = GenerateRandomChromosome(chromosomeLength, weightRange)
    minWeight = weightRange(1);
    maxWeight = weightRange(2);
    chromosome = minWeight + rand(1, chromosomeLength) * (maxWeight - minWeight);
end
