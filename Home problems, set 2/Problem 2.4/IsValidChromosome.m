function isValid = IsValidChromosome(chromosome, numberOfRegisters, numberOfVariableRegisters, numberOfOperators)
    chromosomeLength = length(chromosome);

    for i = 1:4:chromosomeLength
        destinationRegister = chromosome(i);
        iOperator = chromosome(i + 1);
        operand1 = chromosome(i + 2);
        operand2 = chromosome(i + 3);
        
        if destinationRegister < 1 && destinationRegister > numberOfVariableRegisters ...
                || iOperator < 1 && iOperator > numberOfOperators ...
                || operand1 < 1 && operand1 > numberOfRegisters ...
                || operand2 < 1 && operand2 > numberOfRegisters
            isValid = false;
            return;
        end
    end
    
    isValid = true;
end
