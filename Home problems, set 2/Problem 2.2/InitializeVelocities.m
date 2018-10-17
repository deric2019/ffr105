function velocities = InitializeVelocities(numberOfParticles, numberOfDimensions, alpha, xMin, xMax)
    velocities = zeros(numberOfParticles, numberOfDimensions);
    
    for i = 1:numberOfParticles
        for j = 1:numberOfDimensions
            r = rand;
            velocities(i, j) = alpha * (-(xMax - xMin) / 2 + r * (xMax - xMin));
        end
    end
end
