clear all;

% Load function data
data = LoadFunctionData();

% Define parameters
GENES_PER_INSTRUCTION = 4;

numberOfVariableRegisters = 7;
constants = [1 3 -1];
numberOfRegisters = numberOfVariableRegisters + length(constants);
numberOfOperators = 4; % +, -, *, /
minNumberOfInstructions = 5;
maxNumberOfInstructions = 100;
tooManyInstructionsPenalty = 10;
divisionByZeroConstant = 10000;
tournamentSize = 5;
tournamentSelectionParameter = 0.75;
crossoverProbability = 0.20;
mutationVariationFactor = 1.1;
minDiversity = 0.60;
maxDiversity = 0.60;
elitismCount = 1;
populationSize = 100;
numberOfGenerations = 1000;

% Initialize population
population = InitializePopulation(populationSize, minNumberOfInstructions, maxNumberOfInstructions, numberOfRegisters, numberOfVariableRegisters, numberOfOperators);

mutationProbability = 1 / mean(arrayfun(@(x) length(x.Chromosome), population));

% Setup plots
fig = figure;
set(fig, 'DoubleBuffer', 'on');

subplot(2, 2, 1);
hold on;
xlabel('x');
ylabel('y');
axis([-5 5 -1.5 1.5]);
PlotData(data);
xValues = -5:0.1:5;
functionPlot = plot(xValues, zeros(1, length(xValues)));

subplot(2, 2, 2);
hold on;
xlabel('Generation');
ylabel('Error');
axis([1 numberOfGenerations 0 1]);
errorPlot = plot(1:numberOfGenerations, zeros(1, numberOfGenerations));

subplot(2, 2, 3);
hold on;
xlabel('Generation');
ylabel('Mutation rate');
axis([1 numberOfGenerations 0 0.1]);
mutationRatePlot = plot(1:numberOfGenerations, zeros(1, numberOfGenerations));

subplot(2, 2, 4);
hold on;
xlabel('Generation');
ylabel('Population diversity');
axis([1 numberOfGenerations 0 1]);
diversityPlot = plot(1:numberOfGenerations, zeros(1, numberOfGenerations));

drawnow;

% Run optimization
fitnessValues = zeros(populationSize, 1);

maxFitnessFound = -1;
minErrorFound = inf;

for iGeneration = 1:numberOfGenerations
    % Evaluate all individuals
    foundNewBestIndividual = false;

    for i = 1:populationSize
        individual = population(i);
        chromosome = individual.Chromosome;
        totalError = CalculateError(chromosome, data, numberOfRegisters, constants, divisionByZeroConstant);
        fitness = 1 / totalError;

        % Penalize chromosomes with many instructions
        if length(chromosome) > maxNumberOfInstructions * GENES_PER_INSTRUCTION
            fitness = fitness / tooManyInstructionsPenalty;
        end

        fitnessValues(i) = fitness;

        if fitness > maxFitnessFound
            bestIndividual = individual;
            maxFitnessFound = fitness;
            minErrorFound = totalError;
            foundNewBestIndividual = true;
        end
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

    % Calculate diversity and update mutation rate
    diversity = CalculateDiversity(population);

    if diversity < minDiversity
        mutationProbability = mutationProbability * mutationVariationFactor;
    elseif diversity > maxDiversity
        mutationProbability = mutationProbability / mutationVariationFactor;
    end

    % Update plots
    if foundNewBestIndividual == true
        chromosome = bestIndividual.Chromosome;

        plotVector = get(functionPlot, 'YData');
        for i = 1:length(xValues)
            x = xValues(i);
            plotVector(i) = EvaluateChromosome(chromosome, x, numberOfRegisters, constants, divisionByZeroConstant);
        end
        set(functionPlot, 'YData', plotVector);
        fprintf( ...
            'Generation %d: fitness = %.5f, error = %.5f, # of instructions = %d\n', ...
            iGeneration, ...
            maxFitnessFound, ...
            minErrorFound, ...
            length(chromosome) / GENES_PER_INSTRUCTION);
    end

    plotVector = get(errorPlot, 'YData');
    plotVector(iGeneration) = minErrorFound;
    set(errorPlot, 'YData', plotVector);

    plotVector = get(mutationRatePlot, 'YData');
    plotVector(iGeneration) = mutationProbability;
    set(mutationRatePlot, 'YData', plotVector);

    plotVector = get(diversityPlot, 'YData');
    plotVector(iGeneration) = diversity;
    set(diversityPlot, 'YData', plotVector);

    drawnow;
end

% Print best solution
bestChromosome = bestIndividual.Chromosome;
functionExpression = DecodeChromosome(bestChromosome, numberOfRegisters, constants, divisionByZeroConstant);
fprintf('bestChromosome = %s;\n', mat2str(bestChromosome));
fprintf('g(x) = %s\n', functionExpression);
