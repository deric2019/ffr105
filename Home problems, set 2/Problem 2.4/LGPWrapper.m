function [bestChromosome, minErrorFound] = LGPWrapper( ...
        data, ...
        numberOfVariableRegisters, ...
        constants, ...
        numberOfOperators, ...
        minNumberOfInstructions, ...
        maxNumberOfInstructions, ...
        tournamentSize, ...
        tournamentSelectionParameter, ...
        crossoverProbability, ...
        mutationProbability, ...
        mutationVariationFactor, ...
        minDiversity, ...
        maxDiversity, ...
        elitismCount, ...
        populationSize, ...
        numberOfGenerations, ...
        debug)

    % TODO:
    % - Remove magic constants
    % - Fix CalculateDiversity, update minDiversity and maxDiversity
    % - Transfer changes from LGPWrapper to LGP24, remove LGPWrapper and
    % ParameterSearch
    % - Make sure program plots/prints what it should, and not any
    % unneccessary stuff
    
    numberOfRegisters = numberOfVariableRegisters + length(constants);

    fitnessValues = zeros(populationSize, 1);

    % Initialize plots
    if debug == true
        mutationRateFigure = figure;
        set(mutationRateFigure, 'DoubleBuffer', 'on');
        axis([1 numberOfGenerations 0 0.1]);
        mutationRatePlot = plot(1:numberOfGenerations, zeros(1, numberOfGenerations));
        drawnow;
        
        diversityFigure = figure;
        set(diversityFigure, 'DoubleBuffer', 'on');
        axis([1 numberOfGenerations 0 1]);
        diversityPlot = plot(1:numberOfGenerations, zeros(1, numberOfGenerations));
        drawnow;
        
        functionFigure = figure;
        hold on;
        set(functionFigure, 'DoubleBuffer', 'on');
        PlotData(data);
        drawnow;
    end

    % Initialize population
    population = InitializePopulation(populationSize, minNumberOfInstructions, maxNumberOfInstructions, numberOfRegisters, numberOfVariableRegisters, numberOfOperators);

    maxFitnessFound = -1;
    minErrorFound = inf;

    % For each generation
    for iGeneration = 1:numberOfGenerations
        % Evaluate all individuals
        foundNewBestIndividual = false;

        for i = 1:populationSize
            individual = population(i);
            chromosome = individual.Chromosome;
            totalError = CalculateError(chromosome, data, numberOfRegisters, constants);
            fitness = 1 / totalError;
            
            % Penalize chromosomes with many instructions by a factor of 10
            if length(chromosome) > maxNumberOfInstructions * 4
                fitness = fitness / 10;
            end
            
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
            if debug == true
                if exist('chromosomePlot', 'var') ~= 0
                    delete(chromosomePlot);
                end
                figure(3);
                chromosomePlot = PlotChromosome(bestIndividual.Chromosome, numberOfRegisters, constants, data);
                drawnow;
            end
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
        
        % Calculate diversity and update mutation rate
        diversity = CalculateDiversity(population, numberOfRegisters, numberOfVariableRegisters, numberOfOperators);
        
        if diversity < minDiversity
            mutationProbability = mutationProbability * mutationVariationFactor;
        elseif diversity > maxDiversity
            mutationProbability = mutationProbability / mutationVariationFactor;
        end
        
        if debug == true
            plotVector = get(mutationRatePlot, 'YData');
            plotVector(iGeneration) = mutationProbability;
            set(mutationRatePlot, 'YData', plotVector);
            
            plotVector = get(diversityPlot, 'YData');
            plotVector(iGeneration) = diversity;
            set(diversityPlot, 'YData', plotVector);
            
            drawnow;
        end
    end

    bestChromosome = bestIndividual.Chromosome;
end
