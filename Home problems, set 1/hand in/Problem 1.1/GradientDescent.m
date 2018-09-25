function x = GradientDescent(startingPoint, penaltyFactor, stepLength, threshold)
    x = startingPoint;

    gradient = Gradient(x(1), x(2), penaltyFactor);
    
    while norm(gradient) >= threshold
        x = x - gradient * stepLength;
        gradient = Gradient(x(1), x(2), penaltyFactor);
    end
end
