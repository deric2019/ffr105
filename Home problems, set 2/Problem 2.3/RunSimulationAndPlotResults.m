function RunSimulationAndPlotResults(network, iSlope, iDataSet)
    slopeLength = 1000;
    minVelocity = 1;
    maxVelocity = 25;
    maxBreakTemperature = 750;

    [~, positions, velocities, breakPressures, gears, breakTemperatures] = RunSimulation(network, iDataSet, iSlope, slopeLength, minVelocity, maxVelocity, maxBreakTemperature);

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
    title('Break pedal pressure');
    axis([0 1000 0 1]);
    plot(positions, breakPressures);

    subplot(3, 2, 4);
    hold on;
    title('Gear');
    axis([0 1000 1 10]);
    plot(positions, gears);

    subplot(3, 2, 5);
    hold on;
    title('Break temperature');
    axis([0 1000 283 750]);
    plot(positions, breakTemperatures);
end
