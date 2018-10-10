clear all;

% TODO: Chromosome length penalty
% TODO: Varying mutation rate
% TODO: Remove magic constants

% Load data
data = LoadFunctionData();

% Define parameters
numberOfVariableRegisters = 3;
constants = [1 3 -1];
numberOfRegisters = numberOfVariableRegisters + length(constants);
numberOfOperators = 4; % +, -, *, /
minNumberOfInstructions = 5;
maxNumberOfInstructions = 50;
tournamentSize = 5;
tournamentSelectionParameter = 0.75;
crossoverProbability = 0.20;
mutationProbability = 0.01;
elitismCount = 1;
populationSize = 100;
numberOfGenerations = 500;

fitnessValues = zeros(populationSize, 1);

% Initialize plots
figure;
hold on;
PlotData(data);
drawnow;

% Initialize population
population = InitializePopulation(populationSize, minNumberOfInstructions, maxNumberOfInstructions, numberOfRegisters, numberOfVariableRegisters, numberOfOperators);

maxFitnessFound = -1;
minErrorFound = inf;

% For each generation
for iGeneration = 1:numberOfGenerations
    % Make sure that all individuals have valid chromosomes
    % TODO: Remove this
    for individual = population
        chromosome = individual.Chromosome;
        isValid = IsValidChromosome(chromosome, numberOfRegisters, numberOfVariableRegisters, numberOfOperators);
        if ~isValid
            fprintf('Generation %d, invalid chromosome: [%s];\n', iGeneration, sprintf('%d ', chromosome));
            totalError('Invalid chromosome');
        end
    end
    
    % Evaluate all individuals
    foundNewBestIndividual = false;
    
    for i = 1:populationSize
        individual = population(i);
        chromosome = individual.Chromosome;
        totalError = CalculateError(chromosome, data, numberOfRegisters, constants);
        fitness = 1 / totalError;
        fitnessValues(i) = fitness;
        
        if fitness > maxFitnessFound
            bestIndividual = individual;
            maxFitnessFound = fitness;
            minErrorFound = totalError;
            foundNewBestIndividual = true;
        end
    end
    
    % Plot best individual
    if foundNewBestIndividual == true
        if exist('chromosomePlot', 'var') ~= 0
            delete(chromosomePlot);
        end
        chromosomePlot = PlotChromosome(bestIndividual.Chromosome, numberOfRegisters, constants, data);
        drawnow;
        fprintf('Generation %d: fitness = %.5f, error = %.5f, # of instructions = %d\n', iGeneration, maxFitnessFound, minErrorFound, length(bestIndividual.Chromosome) / 4);
    end
    
    % Create new population
    tempPopulation = population;
    
    % Perform selection and crossover
    for i = 1:2:populationSize
        i1 = TournamentSelect(fitnessValues, tournamentSelectionParameter, tournamentSize);
        i2 = TournamentSelect(fitnessValues, tournamentSelectionParameter, tournamentSize);
        
        individual1 = population(i1);
        individual2 = population(i2);
        
        chromosome1 = individual1.Chromosome;
        chromosome2 = individual2.Chromosome;
        
        r = rand;
        if r < crossoverProbability
            [newChromosome1, newChromosome2] = Cross(chromosome1, chromosome2);
        else
            newChromosome1 = chromosome1;
            newChromosome2 = chromosome2;
        end
        
        tempPopulation(i) = struct('Chromosome', newChromosome1);
        tempPopulation(i + 1) = struct('Chromosome', newChromosome2);
    end
    
    % Perform mutation
    for i = 1:populationSize
        originalIndividual = tempPopulation(i);
        originalChromosome = originalIndividual.Chromosome;
        mutatedChromosome = Mutate(originalChromosome, mutationProbability, numberOfRegisters, numberOfVariableRegisters, numberOfOperators);
        tempPopulation(i) = struct('Chromosome', mutatedChromosome);
    end
    
    % Perform elitism
    tempPopulation = InsertBestIndividual(tempPopulation, bestIndividual, elitismCount);
    
    % Replace population
    population = tempPopulation;
end

bestChromosome = bestIndividual.Chromosome;
fprintf('bestChromosome = [%s];\n', sprintf('%d ', bestChromosome));
