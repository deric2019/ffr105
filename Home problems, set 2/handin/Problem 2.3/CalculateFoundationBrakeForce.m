function force = CalculateFoundationBrakeForce(mass, brakePressure, brakeTemperature, maxBrakeTemperature)
    gravityConstant = 9.80665;
    
    force = mass * gravityConstant / 20 * brakePressure;

    if brakeTemperature >= maxBrakeTemperature - 100
        force = force * exp(-(brakeTemperature - (maxBrakeTemperature - 100)) / 100);
    end
end
