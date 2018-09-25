function PlotIterations(polynomialCoefficients, iterationValues)
    figure;
    hold on;
    
    minIterationValue = min(iterationValues);
    maxIterationValue = max(iterationValues);
    
    plotXPadding = (maxIterationValue - minIterationValue) / 4;
    minPlotX = minIterationValue - plotXPadding;
    maxPlotX = maxIterationValue + plotXPadding;
    xlim([minPlotX, maxPlotX]);
    
    PlotPolynomial(polynomialCoefficients, minPlotX, maxPlotX);
    PlotIterationValues(polynomialCoefficients, iterationValues);
    
    hold off;
end

function PlotPolynomial(polynomialCoefficients, minX, maxX)
    xValues = linspace(minX, maxX);
    yValues = EvalPolynomial(polynomialCoefficients, xValues);
    plot(xValues, yValues);
end

function PlotIterationValues(polynomialCoefficients, iterationValues)
    yValues = EvalPolynomial(polynomialCoefficients, iterationValues);
    scatter(iterationValues, yValues, 50, 'black');
end

function yValues = EvalPolynomial(polynomialCoefficients, xValues)
    numberOfValues = length(xValues);
    yValues = zeros(1, numberOfValues);
    for i=1:numberOfValues
        x = xValues(i);
        y = Polynomial(x, polynomialCoefficients);
        yValues(i) = y;
    end
end
