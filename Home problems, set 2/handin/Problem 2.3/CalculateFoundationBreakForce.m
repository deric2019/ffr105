function force = CalculateFoundationBreakForce(mass, breakPressure, breakTemperature, maxBreakTemperature)
    gravityConstant = 9.80665;
    
    force = mass * gravityConstant / 20 * breakPressure;

    if breakTemperature >= maxBreakTemperature - 100
        force = force * exp(-(breakTemperature - (maxBreakTemperature - 100)) / 100);
    end
end
