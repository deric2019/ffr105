clear all;
restoredefaultpath;
addpath('GA', 'helpers', 'TSPGraphics');

% TODO:
% - Settle on naming. Use either path/city or individual/chromosome/gene
% - Make sure that PathLength returns correct results
% - Find optimal parameters

cityLocations = LoadCityLocations();

numberOfCities = size(cityLocations, 1);
tournamentSelectionParameter = 0.75;
tournamentSize = 2;
mutationProbability = 1 / numberOfCities;
elitismCount = 1;
populationSize = 100;
numberOfGenerations = 5000;

fitnessValues = zeros(populationSize, 1);

tspFigure = InitializeTspPlot(cityLocations, [0 20 0 20]); 
connections = InitializeConnections(cityLocations);

% Initialize population
population = InitializePopulation(populationSize, numberOfCities);

bestPath = zeros(1, numberOfCities);
bestPathFitness = -1;

for iGeneration = 1:numberOfGenerations
    % Evaluate all individuals
    foundNewBestPath = false;
    
    for i = 1:populationSize
        path = population(i, :);
        fitness = EvaluatePath(path, cityLocations);
        fitnessValues(i) = fitness;
       
        if bestPathFitness == -1 || fitness > bestPathFitness
            bestPath = path;
            bestPathFitness = fitness;
            foundNewBestPath = true;
        end
    end
    
    % Plot best path, if it is better than any previously seen path
    if foundNewBestPath == true
        PlotPath(connections, cityLocations, bestPath);
        bestPathLength = PathLength(bestPath, cityLocations);
        fprintf('New best path length (after %d generations): %.2f\n', iGeneration, bestPathLength);
    end
    
    tempPopulation = population;
    
    % Perform selection
    for i = 1:2:populationSize
        i1 = TournamentSelect(fitnessValues, tournamentSelectionParameter, tournamentSize);
        i2 = TournamentSelect(fitnessValues, tournamentSelectionParameter, tournamentSize);
        
        path1 = population(i1, :);
        path2 = population(i2, :);
        
        tempPopulation(i, :) = path1;
        tempPopulation(i + 1, :) = path1;
    end
    
    % Perform mutation
    for i = 1:populationSize
        originalPath = tempPopulation(i, :);
        mutatedPath = Mutate(originalPath, mutationProbability);
        tempPopulation(i, :) = mutatedPath;
    end
    
    % Perform elitism
    tempPopulation = InsertBestIndividual(tempPopulation, bestPath, elitismCount);
    
    % Replace population
    population = tempPopulation;
end

fprintf('Best path length (after %d generations): %.2f\n', numberOfGenerations, bestPathLength);
