function nextDeltaBreakTemperature = GetNextDeltaBreakTemperature(breakPressure, deltaBreakTemperature, breakCooldownTime, breakHeatingRate, deltaT)
    if breakPressure < 0.01
        deltaBreakTemperatureDerivative = -deltaBreakTemperature / breakCooldownTime;
    else
        deltaBreakTemperatureDerivative = breakHeatingRate * breakPressure;
    end
    
    nextDeltaBreakTemperature = deltaBreakTemperature + deltaBreakTemperatureDerivative * deltaT;
end
