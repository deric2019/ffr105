function updatedParticles = UpdatePositions(particles, velocities)
    numberOfParticles = size(particles, 1);
    numberOfDimensions = size(particles, 2);
    
    updatedParticles = zeros(numberOfParticles, numberOfDimensions);
    
    for i = 1:numberOfParticles
        for j = 1:numberOfDimensions
            updatedParticles(i, j) = particles(i, j) + velocities(i, j);
        end
    end
end
