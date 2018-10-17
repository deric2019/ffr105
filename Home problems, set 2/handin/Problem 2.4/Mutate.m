function mutatedChromosome = Mutate(chromosome, mutationProbability, numberOfRegisters, numberOfVariableRegisters, numberOfOperators)
    chromosomeLength = length(chromosome);
    
    mutatedChromosome = chromosome;

    for i = 1:chromosomeLength
        r = rand;
        if r < mutationProbability
            m = mod(i, 4);

            if m == 1
                % Destination register
                newValue = RandomIndex(numberOfVariableRegisters);
            elseif m == 2
                % Operator
                newValue = RandomIndex(numberOfOperators);
            else % m == 3 || m == 0
                % Operand 1 or 2
                newValue = RandomIndex(numberOfRegisters);
            end

            mutatedChromosome(i) = newValue;
        end
    end
end
