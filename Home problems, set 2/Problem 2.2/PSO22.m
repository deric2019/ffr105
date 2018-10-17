clear all;

debug = false;

% Define parameters
alpha = 1;
xMin = -5;
xMax = 5;
vMax = xMax - xMin;
numberOfDimensions = 2;
c1 = 2;
c2 = 2;
initialInertiaWeight = 1.4;
inertiaWeightMin = 0.4;
beta = 0.99;
numberOfParticles = 20;
numberOfIterations = 500;

% Initialize positions and velocities of particles
particles = InitializeParticles(numberOfParticles, numberOfDimensions, xMin, xMax);
velocities = InitializeVelocities(numberOfParticles, numberOfDimensions, alpha, xMin, xMax);

% Run optimization
inertiaWeight = initialInertiaWeight;

scores = zeros(numberOfParticles, 1);

bestParticleScores = ones(numberOfParticles, 1) * inf;
bestParticlePositions = zeros(numberOfParticles, numberOfDimensions);

bestScore = inf;
bestPosition = zeros(1, 2);

if debug == true
    fig = figure;
    set(fig, 'DoubleBuffer', 'on');
    hold on;
    xlim([xMin - 2 xMax + 2]);
    ylim([xMin - 2 xMax + 2]);
    PlotLevelCurves(xMin - 2, xMax + 2, @EvaluateFunction);
    particlePlot = PlotParticles(particles);
    drawnow;
end

for iIteration = 1:numberOfIterations
    for i = 1:numberOfParticles
        % Evaluate each particle
        particle = particles(i, :);
        score = EvaluateParticle(particle);
        
        % Update x_pb and x_sb
        if score < bestParticleScores(i)
            bestParticleScores(i) = score;
            bestParticlePositions(i, :) = particle;
        end
        
        if score < bestScore
            bestScore = score;
            bestPosition = particle;
            
            fprintf(...
                'Iteration %d: new minimum = %.6f, (x, y) = (%.6f, %.6f)\n', ...
                iIteration, ...
                bestScore, ...
                bestPosition(1), ...
                bestPosition(2));
        end
    end

    % Update particle velocities and positions
    velocities = UpdateVelocities(velocities, particles, bestParticlePositions, bestPosition, c1, c2, vMax, inertiaWeight);
    particles = UpdatePositions(particles, velocities);
    
    % Update inertia weight
    inertiaWeight = UpdateInertiaWeight(inertiaWeight, beta, inertiaWeightMin);
    
    if debug == true
        delete(particlePlot);
        particlePlot = PlotParticles(particles);
        drawnow;
    end
end

fprintf( ...
    'Best result: %.6f, (x, y) = (%.6f, %.6f)\n', ...
    bestScore, ...
    bestPosition(1), ...
    bestPosition(2));
