function population = InitializePopulation(populationSize, minNumberOfInstructions, maxNumberOfInstructions, numberOfRegisters, numberOfVariableRegisters, numberOfOperators)
    population = [];
                
    for i = 1:populationSize
        individual = GenerateRandomIndividual(minNumberOfInstructions, maxNumberOfInstructions, numberOfRegisters, numberOfVariableRegisters, numberOfOperators);
        population = [population individual];
    end
end
