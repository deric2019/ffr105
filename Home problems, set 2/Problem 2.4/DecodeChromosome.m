function fn = DecodeChromosome(chromosome, numberOfRegisters, constants)
    chromosomeLength = length(chromosome);
    numberOfConstants = length(constants);
    
    operatorStrings = ['+', '-', '*', '/'];
    
    registers = [];
    for i = 1:numberOfRegisters - numberOfConstants
        registers = [registers sym(0)];
    end
    for constant = constants
        registers = [registers sym(constant)];
    end
    registers(1) = sym('x');

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
            if isAlways(operand2 == 0)
                operationResult = sym(10000);
            else
                operationResult = operand1 / operand2;
            end
        else
            error('Invalid operator %s', operator);
        end
        
        fprintf('Instruction %d: %s %s %s => %s\n', i, operand1, operatorStrings(operator), operand2, operationResult);
        
        registers(destinationRegister) = operationResult;
    end
    
    fn = simplify(registers(1));
end
