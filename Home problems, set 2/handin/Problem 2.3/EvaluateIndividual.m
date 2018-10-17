function [fitness, totalDistance, averageVelocity] = EvaluateIndividual(network, iDataSet)
    slopeLength = 1000;
    minVelocity = 1;
    maxVelocity = 25;
    maxBrakeTemperature = 750;
    
    numberOfSlopes = GetNumberOfSlopes(iDataSet);

    totalFitness = 0;
    totalDistance = 0;
    totalTime = 0;
        
    for iSlope = 1:numberOfSlopes
        [times, positions] = RunSimulation(network, iDataSet, iSlope, slopeLength, minVelocity, maxVelocity, maxBrakeTemperature);

        timeUntilTermination = times(end);
        distanceTravelled = positions(end);
        averageVelocity = distanceTravelled / timeUntilTermination;

        distanceFitnessRatio = 0.90;
        velocityFitnessRatio = 1 - distanceFitnessRatio;
    
        distanceFitness = distanceTravelled / slopeLength * distanceFitnessRatio;
        velocityFitness = averageVelocity / maxVelocity * velocityFitnessRatio;

        if distanceTravelled < slopeLength
            slopeFitness = distanceFitness;
        else
            slopeFitness = distanceFitness + velocityFitness;
        end

        totalFitness = totalFitness + slopeFitness;
        totalTime = totalTime + timeUntilTermination;
        totalDistance = totalDistance + distanceTravelled;
    end

    fitness = totalFitness / numberOfSlopes;
    averageVelocity = totalDistance / totalTime;
end
