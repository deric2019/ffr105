function derivativePolynomialCoefficients = PolynomialDifferentiation(polynomialCoefficients, order)
    if order >= length(polynomialCoefficients)
        derivativePolynomialCoefficients = [];
        return;
    end
    
    derivativePolynomialCoefficients = polynomialCoefficients;
    for i=1:order
        derivativePolynomialCoefficients = FirstOrderPolynomialDifferentiation(derivativePolynomialCoefficients);
    end
end

function derivativePolynomialCoefficients = FirstOrderPolynomialDifferentiation(polynomialCoefficients)
    numberOfPolynomialCoefficients = length(polynomialCoefficients);
    numberOfDerivativeCoefficients = numberOfPolynomialCoefficients - 1;
    
    derivativePolynomialCoefficients = zeros(1, numberOfDerivativeCoefficients);
    for i=1:numberOfDerivativeCoefficients
        derivativePolynomialCoefficients(i) = polynomialCoefficients(i+1) * i;
    end
end
