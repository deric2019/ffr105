function force = CalculateEngineBreakForce(gear, engineBreakConstant, gearCoefficients)
    force = gearCoefficients(gear) * engineBreakConstant;
end
