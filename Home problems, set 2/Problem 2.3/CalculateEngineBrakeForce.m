function force = CalculateEngineBrakeForce(gear, engineBrakeConstant, gearCoefficients)
    force = gearCoefficients(gear) * engineBrakeConstant;
end
