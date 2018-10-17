function error = CalculateError(chromosome, data, numberOfRegisters, constants, divisionByZeroConstant)
    numberOfDataPoints = size(data, 1);
    
    error = 0;

    for k = 1:numberOfDataPoints
        x = data(k, 1);
        y = data(k, 2);
        yEstimate = EvaluateChromosome(chromosome, x, numberOfRegisters, constants, divisionByZeroConstant);
        error = error + (yEstimate - y)^2;
    end
    
    error = 1 / numberOfDataPoints * error;
end

