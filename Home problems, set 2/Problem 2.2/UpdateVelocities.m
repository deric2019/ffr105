function updatedVelocities = UpdateVelocities(velocities, particles, bestParticlePositions, bestPosition, c1, c2, vMax)
    numberOfParticles = size(particles, 1);
    numberOfDimensions = size(particles, 2);
    
    updatedVelocities = zeros(numberOfParticles, numberOfDimensions);
    
    % TODO: Vectorize?
    for i = 1:numberOfParticles
        % Question: Should I generate new values for q and r for each
        % dimension?
        q = rand;
        r = rand;
        
        for j = 1:numberOfDimensions
            previousVelocity = velocities(i, j);
            
            x = particles(i, j);
            xPB = bestParticlePositions(i, j);
            xSB = bestPosition(j);
            
            cognitiveComponent = c1 * q * (xPB - x);
            socialComponent = c2 * r * (xSB - x);
            
            updatedVelocity = previousVelocity + cognitiveComponent + socialComponent;
            
            if abs(updatedVelocity) > vMax
                updatedVelocity = sign(updatedVelocity) * vMax;
            end
            
            updatedVelocities(i, j) = updatedVelocity;
        end
    end
end
