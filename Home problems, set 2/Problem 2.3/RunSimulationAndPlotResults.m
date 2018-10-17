function RunSimulationAndPlotResults(network, iSlope, iDataSet)
    slopeLength = 1000;
    minVelocity = 1;
    maxVelocity = 25;
    maxBrakeTemperature = 750;

    [~, positions, velocities, brakePressures, gears, brakeTemperatures] = RunSimulation(network, iDataSet, iSlope, slopeLength, minVelocity, maxVelocity, maxBrakeTemperature);

    figure;

    subplot(3, 2, 1);
    hold on;
    title('Slope angle');
    axis([0 1000 0 10]);
    fplot(@(x) GetSlopeAngle(x, iSlope, iDataSet));

    subplot(3, 2, 2);
    hold on;
    title('Velocity');
    axis([0 1000 0 25]);
    plot(positions, velocities);

    subplot(3, 2, 3);
    hold on;
    title('Brake pedal pressure');
    axis([0 1000 0 1]);
    plot(positions, brakePressures);

    subplot(3, 2, 4);
    hold on;
    title('Gear');
    axis([0 1000 1 10]);
    plot(positions, gears);

    subplot(3, 2, 5);
    hold on;
    title('Brake temperature');
    axis([0 1000 283 750]);
    plot(positions, brakeTemperatures);
end
