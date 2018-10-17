function [times, positions, velocities, breakPressures, gears, breakTemperatures] = RunSimulation(network, iDataSet, iSlope, slopeLength, minVelocity, maxVelocity, maxBreakTemperature)
    % Define parameters
    maxSlopeAngle = 10; % degrees
    mass = 20000; % kg
    numberOfGears = 10;
    gearChangeCooldown = 1; % s
    ambientBreakTemperature = 283; % K
    breakCooldownTime = 30; % s
    breakHeatingRate = 40; % K/s
    engineBreakConstant = 3000; % N
    deltaT = 0.1; % s

    % Define initial values
    initialPosition = 0;
    initialVelocity = 20; % m/s
    initialGear = 7;
    initialBreakTemperature = 500; % K
    breakPressure = 0.0;

    % Define variables for keeping track of state
    position = initialPosition;
    velocity = initialVelocity;
    gear = initialGear;
    breakTemperature = initialBreakTemperature;
    deltaBreakTemperature = breakTemperature - ambientBreakTemperature;
    time = 0;
    lastGearChangeTime = -1;
    
    % Define variables for historical state
    times = [];
    positions = [];
    velocities = [];
    breakPressures = [];
    gears = [];
    breakTemperatures = [];
    
    iIteration = 1;

    % Run through simulation
    while position < slopeLength
        % Get slope angle for current position
        slopeAngle = GetSlopeAngle(position, iSlope, iDataSet);

        % Calculate acceleration in current position
        gravityForce = CalculateGravityForce(mass, slopeAngle);
        foundationBreakForce = CalculateFoundationBreakForce(mass, breakPressure, breakTemperature, maxBreakTemperature);
        engineBreakForce = CalculateEngineBreakForce(gear, engineBreakConstant);

        acceleration = CalculateAcceleration(mass, gravityForce, foundationBreakForce, engineBreakForce);
        
        % Add current state to historical state
        times = [times time];
        positions = [positions position];
        velocities = [velocities velocity];
        breakPressures = [breakPressures breakPressure];
        gears = [gears gear];
        breakTemperatures = [breakTemperatures breakTemperature];
        
        % Get input from neural network
        networkInput = [
            velocity / maxVelocity;
            slopeAngle / maxSlopeAngle;
            breakTemperature / maxBreakTemperature;
        ];
        networkOutput = RunNeuralNetwork(network, networkInput);
        breakPressure = networkOutput(1);
        gearChange = networkOutput(2);
        
        % Perform gearchange
        gearChangeAllowed = time - lastGearChangeTime >= gearChangeCooldown;

        if gearChange <= 0.3 && gearChangeAllowed == true
            gear = max(gear - 1, 1);
            lastGearChangeTime = time;
        elseif gearChange >= 0.7 && gearChangeAllowed == true
            gear = min(gear + 1, numberOfGears);
            lastGearChangeTime = time;
        end

        % Calculate next position
        position = GetNextPosition(position, velocity, deltaT, slopeAngle);

        % Calculate next velocity
        velocity = GetNextVelocity(velocity, acceleration, deltaT);

        % Calculate next break temperature
        deltaBreakTemperature = GetNextDeltaBreakTemperature(breakPressure, deltaBreakTemperature, breakCooldownTime, breakHeatingRate, deltaT);
        breakTemperature = GetNextBreakTemperature(ambientBreakTemperature, deltaBreakTemperature);
        
        % Check constraints
        if velocity < minVelocity || velocity > maxVelocity || breakTemperature > maxBreakTemperature
            break;
        end
        
        % Advance time
        time = time + deltaT;

        iIteration = iIteration + 1;
    end
    
    times = [times time];
    positions = [positions position];
    velocities = [velocities velocity];
    breakPressures = [breakPressures breakPressure];
    gears = [gears gear];
    breakTemperatures = [breakTemperatures breakTemperature];
end
