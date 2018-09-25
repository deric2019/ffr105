function gradient = Gradient(x1, x2, penaltyFactor)
    x1Derivative = 2 * (x1 - 1);
    x2Derivative = 4 * (x2 - 2);

    constraint = x1^2 + x2^2 - 1;
    
    if constraint > 0
        x1PenaltyTerm = 4 * penaltyFactor * x1 * (x1^2 + x2^2 - 1);
        x2PenaltyTerm = 4 * penaltyFactor * x2 * (x1^2 + x2^2 - 1);
        x1Derivative = x1Derivative + x1PenaltyTerm;
        x2Derivative = x2Derivative + x2PenaltyTerm;
    end

    gradient = [x1Derivative; x2Derivative];
end
