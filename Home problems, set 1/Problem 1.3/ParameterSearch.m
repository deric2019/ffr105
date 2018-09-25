clear all;

debug = false;

numberOfVariables = 2;
numberOfGenesPerVariable = 25;
variableRange = 10.0;
populationSize = 100;
crossoverProbability = 0.8;
tournamentSelectionParameter = 0.75;
tournamentSize = 2;
elitismCount = 1;
numberOfGenerations = 100;

mutationProbabilities = [0.00, 0.02, 0.05, 0.10];
numberOfRunsPerMutationProbability = 100;

medianFitnessValues = zeros(1, length(mutationProbabilities));
for i = 1:length(mutationProbabilities)
    mutationProbability = mutationProbabilities(i);
    bestFitnessValues = zeros(1, numberOfRunsPerMutationProbability);
    for run = 1:numberOfRunsPerMutationProbability
        bestX = FunctionOptimizationWrapper( ...
            numberOfVariables, ...
            numberOfGenesPerVariable, ...
            variableRange, ...
            populationSize, ...
            crossoverProbability, ...
            mutationProbability, ...
            tournamentSelectionParameter, ...
            tournamentSize, ...
            elitismCount, ...
            numberOfGenerations, ...
            debug);
        bestFitnessValue = EvaluateIndividual(bestX);
        bestFitnessValues(run) = bestFitnessValue;
        fprintf('run=%i, mutationProbability=%.2f, bestFitnessValue=%.4f\n', run, mutationProbability, bestFitnessValue);
    end
    medianFitnessValue = median(bestFitnessValues);
    medianFitnessValues(i) = medianFitnessValue;
    fprintf('mutationProbability=%.2f, medianFitnessValue=%.4f\n', mutationProbability, medianFitnessValue);
end

medianFitnessValues
