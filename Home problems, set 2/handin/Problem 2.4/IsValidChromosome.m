function isValid = IsValidChromosome(chromosome, numberOfRegisters, numberOfVariableRegisters, numberOfOperators)
    chromosomeLength = length(chromosome);

    for i = 1:4:chromosomeLength
        destinationRegister = chromosome(i);
        operator = chromosome(i + 1);
        operand1 = chromosome(i + 2);
        operand2 = chromosome(i + 3);
        
        isValidDestinationRegister = destinationRegister >= 1 && destinationRegister <= numberOfVariableRegisters;
        isValidOperator = operator >= 1 && operator <= numberOfOperators;
        isValidOperand1 = operand1 >= 1 && operand1 <= numberOfRegisters;
        isValidOperand2 = operand2 >= 1 && operand2 <= numberOfRegisters;
        
        if isValidDestinationRegister && isValidOperator && isValidOperand1 && isValidOperand2
            isValid = false;
            return;
        end
    end
    
    isValid = true;
end
