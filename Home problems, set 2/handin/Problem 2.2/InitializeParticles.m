function particles = InitializeParticles(numberOfParticles, numberOfDimensions, xMin, xMax)
    particles = zeros(numberOfParticles, numberOfDimensions);

    for i = 1:numberOfParticles
        for j = 1:numberOfDimensions
            r = rand;
            particles(i, j) = xMin + r * (xMax - xMin);
        end
    end
end
