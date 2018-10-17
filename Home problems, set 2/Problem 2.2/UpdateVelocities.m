function updatedVelocities = UpdateVelocities(velocities, particles, bestParticlePositions, bestPosition, c1, c2, vMax, inertiaWeight)
    numberOfParticles = size(particles, 1);
    numberOfDimensions = size(particles, 2);
    
    updatedVelocities = zeros(numberOfParticles, numberOfDimensions);
    
    for i = 1:numberOfParticles
        q = rand;
        r = rand;
        
        for j = 1:numberOfDimensions
            previousVelocity = velocities(i, j);
            
            x = particles(i, j);
            xPB = bestParticlePositions(i, j);
            xSB = bestPosition(j);
            
            cognitiveComponent = q * (xPB - x);
            socialComponent = r * (xSB - x);
            
            updatedVelocity = inertiaWeight * previousVelocity + c1 * cognitiveComponent + c2 * socialComponent;
            
            updatedVelocities(i, j) = min(abs(updatedVelocity), vMax) * sign(updatedVelocity);
        end
    end
end
