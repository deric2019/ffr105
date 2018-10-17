function slope = GenerateRandomSlope()
    maxAllowance = 10;
    initialAngle = maxAllowance * rand;
    allowance = min(initialAngle, maxAllowance - initialAngle); 
    sinCosTotalMultiplier = (rand * 2 - 1) * allowance;
    sinMultiplier = rand * sinCosTotalMultiplier;
    cosMultiplier = sinCosTotalMultiplier - sinMultiplier;

    sinDivisor = 200 * rand + 20;
    cosDivisor = 200 * rand + 20;
    sinOffset = 2 * pi * rand;
    cosOffset = 2 * pi * rand;

    allowance = allowance - 2 * abs(sinCosTotalMultiplier);
    xDivisor = 1000 / (allowance * rand);
    alpha = str2sym(initialAngle + " + " ...
    + "x/" + xDivisor +" + " ...
    + sinMultiplier + "*sin(x/" + sinDivisor + " + " + sinOffset + " ) + "...
    + cosMultiplier + "*cos(x/" + cosDivisor + " + " + cosOffset + ")");

    slope = simplify(alpha);
end