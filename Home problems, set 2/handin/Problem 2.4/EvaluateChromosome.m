function yEstimate = EvaluateChromosome(chromosome, x, numberOfRegisters, constants, divisionByZeroConstant)
    chromosomeLength = length(chromosome);
    numberOfConstants = length(constants);

    % Initialize registers
    registers = zeros(1, numberOfRegisters);
    registers(1) = x;
    registers(end - numberOfConstants + 1:end) = constants;
    
    % Execute instructions
    for i = 1:4:chromosomeLength
        destinationRegister = chromosome(i);
        operator = chromosome(i + 1);
        operand1Register = chromosome(i + 2);
        operand2Register = chromosome(i + 3);
        
        operand1 = registers(operand1Register);
        operand2 = registers(operand2Register);
        
        if operator == 1
            operationResult = operand1 + operand2;
        elseif operator == 2
            operationResult = operand1 - operand2;
        elseif operator == 3
            operationResult = operand1 * operand2;
        elseif operator == 4
            if operand2 == 0
                operationResult = divisionByZeroConstant;
            else
                operationResult = operand1 / operand2;
            end
        else
            error('Invalid operator %s', operator);
        end
        
        registers(destinationRegister) = operationResult;
    end
    
    % Return result
    yEstimate = registers(1);
end
