function nextDeltaBrakeTemperature = GetNextDeltaBrakeTemperature(brakePressure, deltaBrakeTemperature, brakeCooldownTime, brakeHeatingRate, deltaT)
    if brakePressure < 0.01
        deltaBrakeTemperatureDerivative = -deltaBrakeTemperature / brakeCooldownTime;
    else
        deltaBrakeTemperatureDerivative = brakeHeatingRate * brakePressure;
    end
    
    nextDeltaBrakeTemperature = deltaBrakeTemperature + deltaBrakeTemperatureDerivative * deltaT;
end
