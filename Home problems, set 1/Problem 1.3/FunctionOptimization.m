clear all;

debug = false;

% Parameters
numberOfVariables = 2;
numberOfGenesPerVariable = 25;
numberOfGenes = numberOfVariables * numberOfGenesPerVariable;
variableRange = 10.0;
populationSize = 100;
crossoverProbability = 0.8;
mutationProbability = 0.02;
tournamentSelectionParameter = 0.75;
tournamentSize = 2;
elitismCount = 1;
numberOfGenerations = 100;

fitnessValues = zeros(populationSize, 1);
decodedPopulation = zeros(populationSize, numberOfVariables);

if debug == true
    [bestPlotHandle, textHandle] = createFitnessFigure(numberOfGenerations);
    populationPlotHandle = createPopulationFigure(variableRange, populationSize);
end

% Initialize population
population = InitializePopulation(populationSize, numberOfGenes);

for iGeneration = 1:numberOfGenerations
    if debug == true
        fprintf('Generation %i\n', iGeneration);
    end
    
    bestFitness = 0.0;
    bestIndividual = zeros(1, numberOfGenes);
    bestX = zeros(1, numberOfVariables);
    
    % Decode and evaluate all individuals
    for i = 1:populationSize
        chromosome = population(i, :);
        x = DecodeChromosome(chromosome, numberOfVariables, variableRange);
        decodedPopulation(i, :) = x;
        fitness = EvaluateIndividual(x);
        fitnessValues(i) = fitness;
        
        if fitness > bestFitness
            bestFitness = fitness;
            bestIndividual = chromosome;
            bestX = x;
        end
    end
    
    tempPopulation = population;
    
    % Perform selection and crossover
    for i = 1:2:populationSize
        i1 = TournamentSelect(fitnessValues, tournamentSelectionParameter, tournamentSize);
        i2 = TournamentSelect(fitnessValues, tournamentSelectionParameter, tournamentSize);
        
        chromosome1 = population(i1, :);
        chromosome2 = population(i2, :);
        
        r = rand;
        if r < crossoverProbability
            newChromosomePair = Cross(chromosome1, chromosome2);
            tempPopulation(i, :) = newChromosomePair(1, :);
            tempPopulation(i + 1, :) = newChromosomePair(2, :);
        else
            tempPopulation(i, :) = chromosome1;
            tempPopulation(i + 1, :) = chromosome2;
        end
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
    
    if debug == true
        printBestSolution(bestX);
        bestFunctionValue = EvaluateFunction(bestX);
        plotBestFitness(iGeneration, bestFunctionValue, bestPlotHandle, textHandle);
        plotPopulation(decodedPopulation, fitnessValues, populationPlotHandle);
        drawnow;
    end
end

% Print minimum function value found and corresponding variable values
printBestSolution(bestX);

function [bestPlotHandle, textHandle] = createFitnessFigure(numberOfGenerations)
    fitnessFigureHandle = figure;
    hold on;
    set(fitnessFigureHandle, 'DoubleBuffer', 'on');
    axis([1 numberOfGenerations 0 100]);
    bestPlotHandle = plot(1:numberOfGenerations, zeros(1, numberOfGenerations));
    textHandle = text(30, 2.6, sprintf('best: %4.3f', 0.0));
    hold off;
    drawnow;
end

function plotBestFitness(iGeneration, bestFitness, bestPlotHandle, textHandle)
    plotvector = get(bestPlotHandle, 'YData');
    plotvector(iGeneration) = bestFitness;
    set(bestPlotHandle, 'YData', plotvector);
    set(textHandle, 'String', sprintf('best: %4.3f', bestFitness));
end

function populationPlotHandle = createPopulationFigure(variableRange, populationSize)
    surfaceFigureHandle = figure;
    hold on;
    set(surfaceFigureHandle, 'DoubleBuffer', 'on');
    delta = 0.1;
    limit = fix(2 * variableRange / delta) + 1;
    [xValues, yValues] = meshgrid(-variableRange:delta:variableRange, -variableRange:delta:variableRange);
    zValues = zeros(limit, limit);
    for j = 1:limit
        for k = 1:limit
            zValues(j, k) = EvaluateIndividual([xValues(j, k) yValues(j, k)]);
        end
    end
    surfl(xValues, yValues, zValues);
    colormap gray;
    shading interp;
    view([-7 -9 10]);
    populationPlotHandle = plot3(zeros(populationSize, 1), zeros(populationSize, 1), zeros(populationSize, 1), 'kp');
    hold off;
    drawnow;
end

function plotPopulation(decodedPopulation, fitnessValues, populationPlotHandle)
    set(populationPlotHandle, 'XData', decodedPopulation(:, 1), 'YData', decodedPopulation(:, 2), 'ZData', fitnessValues(:));
end

function printBestSolution(bestX)
    minimumFunctionValue = EvaluateFunction(bestX);
    x1 = bestX(1);
    x2 = bestX(2);
    fprintf('min g(x1, x2)=%.3f, x1=%.3f, x2=%.3f\n',  minimumFunctionValue, x1, x2);
end
