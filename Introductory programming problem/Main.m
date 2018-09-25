clear all;

polynomialCoefficients = [10 -2 -1 1];
startingPoint = 2;
tolerance = 0.0001;

try
    iterationValues = NewtonRaphson(polynomialCoefficients, startingPoint, tolerance);
    PlotIterations(polynomialCoefficients, iterationValues);
    numberOfIterations = length(iterationValues);
    lastIterationValue = iterationValues(end);
    optimumValue = Polynomial(lastIterationValue, polynomialCoefficients);
    fprintf('Local optimum found after %u iterations: x=%.4f, f(x)=%.4f\n', numberOfIterations, lastIterationValue, optimumValue);
catch error
    if startsWith(error.identifier, 'NewtonRaphson')
        fprintf('ERROR: %s\n', error.message);
    else
        rethrow(error);
    end
end
