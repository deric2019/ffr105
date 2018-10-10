function chromosomePlot = PlotChromosome(chromosome, numberOfRegisters, constants, data)
    xValues = data(:, 1);

    numberOfDataPoints = length(xValues);

    yEstimates = zeros(numberOfDataPoints, 1);

    for i = 1:numberOfDataPoints
        x = xValues(i);
        yEstimates(i) = EvaluateChromosome(chromosome, x, numberOfRegisters, constants);
    end
    
    chromosomePlot = plot(xValues, yEstimates, 'blue');
end
