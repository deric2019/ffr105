function plot = PlotParticles(particles)
    plot = scatter(particles(:, 1), particles(:, 2), 10, 'black', 'filled');
end
