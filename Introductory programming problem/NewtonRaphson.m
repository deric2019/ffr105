function iterationValues = NewtonRaphson(polynomialCoefficients, startingPoint, tolerance)
    if length(polynomialCoefficients) <= 2
        throw(MException('NewtonRaphson:PolynomialDegreeTooLow', 'The degree of the polynomial must be 2 or larger'));
    end

    firstOrderDerivativePolynomialCoefficients = PolynomialDifferentiation(polynomialCoefficients, 1);
    secondOrderDerivativePolynomialCoefficients = PolynomialDifferentiation(polynomialCoefficients, 2);

    iterationValues(1) = startingPoint;
    i = 1;
    
    while true
        prevX = iterationValues(i);
        nextX = NewtonRaphsonStep(prevX, firstOrderDerivativePolynomialCoefficients, secondOrderDerivativePolynomialCoefficients);
        iterationValues(i+1) = nextX;
        
        if abs(prevX - nextX) < tolerance
            break;
        end
        
        i = i + 1;
    end
end
