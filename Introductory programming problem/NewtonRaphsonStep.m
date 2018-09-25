function nextX = NewtonRaphsonStep(prevX, firstOrderDerivativePolynomialCoefficients, secondOrderDerivativePolynomialCoefficients)
    firstOrderDerivative = Polynomial(prevX, firstOrderDerivativePolynomialCoefficients);
    secondOrderDerivative = Polynomial(prevX, secondOrderDerivativePolynomialCoefficients);

    if secondOrderDerivative == 0
        throw(MException('NewtonRaphson:SecondOrderDerivativeZero', 'The second order derivative in the point x=%.4f is 0, can''t find next point', prevX));
    end

    nextX = prevX - (firstOrderDerivative / secondOrderDerivative);
end
