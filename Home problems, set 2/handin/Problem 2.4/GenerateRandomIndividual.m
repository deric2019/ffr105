function individual = GenerateRandomIndividual(minNumberOfInstructions, maxNumberOfInstructions, numberOfRegisters, numberOfVariableRegisters, numberOfOperators)
    numberOfInstructions = RandomIndex(maxNumberOfInstructions - minNumberOfInstructions) + minNumberOfInstructions;

    chromosomeLength = numberOfInstructions * 4;
    chromosome = zeros(1, chromosomeLength);
        
    for j = 1:4:chromosomeLength
        destinationRegister = RandomIndex(numberOfVariableRegisters);
        operator = RandomIndex(numberOfOperators);
        operand1 = RandomIndex(numberOfRegisters);
        operand2 = RandomIndex(numberOfRegisters);

        chromosome(j) = destinationRegister;
        chromosome(j + 1) = operator;
        chromosome(j + 2) = operand1;
        chromosome(j + 3) = operand2;
    end

    individual = struct('Chromosome', chromosome);
end

