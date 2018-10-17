function [times, positions, velocities, breakPressures, gears, breakTemperatures] = RunSimulation(network, iDataSet, iSlope, slopeLength, minVelocity, maxVelocity, maxBreakTemperature)
    % Define constants
    MAX_SLOPE_ANGLE = 10; % degrees
    MASS = 20000; % kg
    NUMBER_OF_GEARS = 10;
    GEAR_CHANGE_COOLDOWN = 1; % s
    AMBIENT_BREAK_TEMPERATURE = 283; % K
    BREAK_COOLDOWN_TIME = 30; % s
    BREAK_HEATING_RATE = 40; % K/s
    ENGINE_BREAK_CONSTANT = 3000; % N
    GEAR_COEFFICIENTS = [7.0 5.0 4.0 3.0 2.5 2.0 1.6 1.4 1.2 1];
    DELTA_T = 0.1; % s

    % Define initial state
    position = 0; % m
    velocity = 20; % m/s
    breakPressure = 0.0;
    breakTemperature = 500; % K
    deltaBreakTemperature = breakTemperature - AMBIENT_BREAK_TEMPERATURE; % K
    gear = 7;
    
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
        gravityForce = CalculateGravityForce(MASS, slopeAngle);
        foundationBreakForce = CalculateFoundationBreakForce(MASS, breakPressure, breakTemperature, maxBreakTemperature);
        engineBreakForce = CalculateEngineBreakForce(gear, ENGINE_BREAK_CONSTANT, GEAR_COEFFICIENTS);

        acceleration = CalculateAcceleration(MASS, gravityForce, foundationBreakForce, engineBreakForce);
        
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
            slopeAngle / MAX_SLOPE_ANGLE;
            breakTemperature / maxBreakTemperature;
        ];
        networkOutput = RunNeuralNetwork(network, networkInput);
        breakPressure = networkOutput(1);
        gearChange = networkOutput(2);
        
        % Perform gearchange
        gearChangeAllowed = time - lastGearChangeTime >= GEAR_CHANGE_COOLDOWN;

        if gearChange <= 0.3 && gearChangeAllowed == true
            gear = max(gear - 1, 1);
            lastGearChangeTime = time;
        elseif gearChange >= 0.7 && gearChangeAllowed == true
            gear = min(gear + 1, NUMBER_OF_GEARS);
            lastGearChangeTime = time;
        end

        % Calculate next position
        position = GetNextPosition(position, velocity, DELTA_T, slopeAngle);

        % Calculate next velocity
        velocity = GetNextVelocity(velocity, acceleration, DELTA_T);

        % Calculate next break temperature
        deltaBreakTemperature = GetNextDeltaBreakTemperature(breakPressure, deltaBreakTemperature, BREAK_COOLDOWN_TIME, BREAK_HEATING_RATE, DELTA_T);
        breakTemperature = GetNextBreakTemperature(AMBIENT_BREAK_TEMPERATURE, deltaBreakTemperature);
        
        % Check constraints
        if velocity < minVelocity || velocity > maxVelocity || breakTemperature > maxBreakTemperature
            break;
        end
        
        % Advance time
        time = time + DELTA_T;

        iIteration = iIteration + 1;
    end
    
    times = [times time];
    positions = [positions position];
    velocities = [velocities velocity];
    breakPressures = [breakPressures breakPressure];
    gears = [gears gear];
    breakTemperatures = [breakTemperatures breakTemperature];
end
