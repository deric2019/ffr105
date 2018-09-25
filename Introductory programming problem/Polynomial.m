function result = Polynomial(x, polynomialCoefficients)
    result = 0;
    polynomialDegree = length(polynomialCoefficients) - 1;
    for termDegree=0:polynomialDegree
        termCoefficient = polynomialCoefficients(termDegree+1);
        result = result + termCoefficient * x^termDegree;
    end
end
