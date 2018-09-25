function x = DecodeChromosome(chromosome, numberOfVariables, variableRange)
    numberOfGenes = size(chromosome, 2);
    numberOfGenesPerVariable = numberOfGenes / numberOfVariables;
    
    x = zeros(1, numberOfVariables);
    for iVariable = 1:numberOfVariables
        x(iVariable) = DecodeVariable(chromosome, iVariable, numberOfGenesPerVariable, variableRange);
    end
end

function x = DecodeVariable(chromosome, variableIndex, numberOfBitsPerVariable, variableRange)
    x = 0;
    offset = (variableIndex - 1) * numberOfBitsPerVariable;
    for i = 1:numberOfBitsPerVariable
        x = x + chromosome(i + offset) * 2^(-i);
    end
    x = -variableRange + 2 * variableRange * x / (1 - 2^(-numberOfBitsPerVariable));
end
