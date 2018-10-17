clear all;

% Data sets
iTrainingDataSet = 1;
iValidationDataSet = 2;
iTestDataSet = 3;

% NN parameters
layerSizes = [3 7 2];
initialWeightRange = [-1 1];
mutationWeightRange = [-10 10];

% We take number of neurons + 1 in order to account for the bias term
numberOfInputWeights = (layerSizes(1) + 1) * layerSizes(2);
numberOfOutputWeights = (layerSizes(2) + 1) * layerSizes(3);

% GA parameters
chromosomeLength = numberOfInputWeights + numberOfOutputWeights;
tournamentSelectionParameter = 0.90;
tournamentSize = 2;
crossoverProbability = 0.20;
mutationProbability = 1 / chromosomeLength;
creepMutationProbability = 0.80;
creepRate = 0.01;
elitismCount = 1;
populationSize = 100;
maxNumberOfGenerations = 200;
maxHoldoutCount = 25;

% Initialize population
population = InitializePopulation(populationSize, chromosomeLength, initialWeightRange);
fitnessValues = zeros(populationSize, 1);

% Setup plots
fitnessFigure = figure;
hold on;
set(fitnessFigure, 'DoubleBuffer', 'on');
axis([1 maxNumberOfGenerations 0 1]);
xlabel('Generation');
ylabel('Fitness');
trainingFitnessPlot = plot(1:maxNumberOfGenerations, zeros(1, maxNumberOfGenerations));
validationFitnessPlot = plot(1:maxNumberOfGenerations, zeros(1, maxNumberOfGenerations));
legend('Training', 'Validation');
drawnow;

% Do optimization
bestTrainingChromosome = zeros(1, chromosomeLength);
bestValidationChromosome = zeros(1, chromosomeLength);
maxTrainingFitnessFound = -1;
maxValidationFitnessFound = -1;

iGeneration = 1;
holdoutCount = 0;

while holdoutCount < maxHoldoutCount && iGeneration <= maxNumberOfGenerations
    fprintf('Running generation %d ...\n', iGeneration);
    
    % Evaluate all individuals, save the best one
    for i = 1:populationSize
        chromosome = population(i, :);

        network = DecodeChromosome(chromosome, layerSizes);
        [trainingFitness, trainingTotalDistance, trainingAverageVelocity] = EvaluateIndividual(network, iTrainingDataSet);
        fitnessValues(i) = trainingFitness;
        
        if trainingFitness > maxTrainingFitnessFound
            bestTrainingChromosome = chromosome;
            maxTrainingFitnessFound = trainingFitness;
            
            fprintf(...
                'Generation %d: trainingFitness = %.5f, total distance = %.5f, average velocity = %.5f\n', ...
                iGeneration, ...
                trainingFitness, ...
                trainingTotalDistance, ...
                trainingAverageVelocity);
            
            [validationFitness, validationTotalDistance, validationAverageVelocity] = EvaluateIndividual(network, iValidationDataSet);
            
            if validationFitness > maxValidationFitnessFound
                bestValidationChromosome = chromosome;
                maxValidationFitnessFound = validationFitness;
                
                holdoutCount = 0;
                
                fprintf(...
                    'Generation %d: validationFitness = %.5f, total distance = %.5f, average velocity = %.5f\n', ...
                    iGeneration, ...
                    validationFitness, ...
                    validationTotalDistance, ...
                    validationAverageVelocity);
            else
                holdoutCount = holdoutCount + 1;
                fprintf('Generation %d: holdoutCount = %d\n', iGeneration, holdoutCount);
            end
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
            [newChromosome1, newChromosome2] = Cross(chromosome1, chromosome2);
        else
            newChromosome1 = chromosome1;
            newChromosome2 = chromosome2;
        end
        
        tempPopulation(i, :) = newChromosome1;
        tempPopulation(i + 1, :) = newChromosome2;
    end
    
    % Perform mutation
    for i = 1:populationSize
        originalChromosome = tempPopulation(i, :);
        mutatedChromosome = Mutate(originalChromosome, mutationProbability, creepMutationProbability, creepRate, mutationWeightRange);
        tempPopulation(i, :) = mutatedChromosome;
    end
    
    % Perform elitism
    tempPopulation = InsertBestIndividual(tempPopulation, bestTrainingChromosome, elitismCount);
    
    % Replace population
    population = tempPopulation;
    
    % Update plots
    plotVector = get(trainingFitnessPlot, 'YData');
    plotVector(iGeneration) = maxTrainingFitnessFound;
    set(trainingFitnessPlot, 'YData', plotVector);
    plotVector = get(validationFitnessPlot, 'YData');
    plotVector(iGeneration) = validationFitness;
    set(validationFitnessPlot, 'YData', plotVector);
    drawnow;
    
    iGeneration = iGeneration + 1;
end

bestNetwork = DecodeChromosome(bestValidationChromosome, layerSizes);
[validationTestFitness, validationTestTotalDistance, validationTestAverageVelocity] = EvaluateIndividual(bestNetwork, iTestDataSet);
fprintf( ...
    'Test results for best network: fitness=%.5f, totalDistance=%.5f, averageVelocity=%.5f\n', ...
    validationTestFitness, ...
    validationTestTotalDistance, ...
    validationTestAverageVelocity);
fprintf('chromosome = %s;\n', mat2str(bestValidationChromosome));
