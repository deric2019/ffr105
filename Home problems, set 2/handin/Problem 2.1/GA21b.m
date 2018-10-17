clear all;
restoredefaultpath;
addpath('GA', 'helpers', 'TSPGraphics');

cityLocations = LoadCityLocations();

numberOfCities = size(cityLocations, 1);
tournamentSelectionParameter = 0.75;
tournamentSize = 2;
mutationProbability = 1 / numberOfCities;
elitismCount = 1;
populationSize = 100;
numberOfGenerations = 10000;

fitnessValues = zeros(populationSize, 1);

tspFigure = InitializeTspPlot(cityLocations, [0 20 0 20]); 
connections = InitializeConnections(cityLocations);

% Initialize population
population = InitializePopulation(populationSize, numberOfCities);

bestIndividual = zeros(1, numberOfCities);
maxFitnessFound = -1;

for iGeneration = 1:numberOfGenerations
    % Evaluate all individuals
    foundNewBestIndividual = false;
    
    for i = 1:populationSize
        individual = population(i, :);
        fitness = EvaluateIndividual(individual, cityLocations);
        fitnessValues(i) = fitness;
        
        if fitness > maxFitnessFound
            bestIndividual = individual;
            maxFitnessFound = fitness;
            foundNewBestIndividual = true;
        end
    end
    
    % Plot best path in generation, if it is better than any previously seen path
    if foundNewBestIndividual == true
        PlotPath(connections, cityLocations, bestIndividual);
        bestPathLength = GetPathLength(bestIndividual, cityLocations);
        fprintf('Generation %d: path length = %.5f\n', iGeneration, bestPathLength);
    end
    
    tempPopulation = population;
    
    % Perform selection
    for i = 1:2:populationSize
        i1 = TournamentSelect(fitnessValues, tournamentSelectionParameter, tournamentSize);
        i2 = TournamentSelect(fitnessValues, tournamentSelectionParameter, tournamentSize);
        
        chromosome1 = population(i1, :);
        chromosome2 = population(i2, :);
        
        tempPopulation(i, :) = chromosome1;
        tempPopulation(i + 1, :) = chromosome2;
    end
    
    % Perform mutation
    for i = 1:populationSize
        originalChromosome = tempPopulation(i, :);
        mutatedChromosome = Mutate(originalChromosome, mutationProbability);
        tempPopulation(i, :) = mutatedChromosome;
    end
    
    % Perform elitism
    tempPopulation = InsertBestIndividual(tempPopulation, bestIndividual, elitismCount);
    
    % Replace population
    population = tempPopulation;
end

fprintf('bestPath = %s;\n', mat2str(bestIndividual));
