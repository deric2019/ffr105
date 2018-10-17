function [times, positions, velocities, brakePressures, gears, brakeTemperatures] = RunSimulation(network, iDataSet, iSlope, slopeLength, minVelocity, maxVelocity, maxBrakeTemperature)
    % Define constants
    MAX_SLOPE_ANGLE = 10; % degrees
    MASS = 20000; % kg
    NUMBER_OF_GEARS = 10;
    GEAR_CHANGE_COOLDOWN = 2; % s
    AMBIENT_BRAKE_TEMPERATURE = 283; % K
    BRAKE_COOLDOWN_TIME = 30; % s
    BRAKE_HEATING_RATE = 40; % K/s
    ENGINE_BRAKE_CONSTANT = 3000; % N
    GEAR_COEFFICIENTS = [7.0 5.0 4.0 3.0 2.5 2.0 1.6 1.4 1.2 1];
    DELTA_T = 0.1; % s

    % Define initial state
    position = 0; % m
    velocity = 20; % m/s
    brakePressure = 0.0;
    brakeTemperature = 500; % K
    deltaBrakeTemperature = brakeTemperature - AMBIENT_BRAKE_TEMPERATURE; % K
    gear = 7;
    
    time = 0;
    lastGearChangeTime = -1;
    
    % Define variables for historical state
    times = [];
    positions = [];
    velocities = [];
    brakePressures = [];
    gears = [];
    brakeTemperatures = [];
    
    iIteration = 1;

    % Run through simulation
    while position < slopeLength
        % Get slope angle for current position
        slopeAngle = GetSlopeAngle(position, iSlope, iDataSet);

        % Calculate acceleration in current position
        gravityForce = CalculateGravityForce(MASS, slopeAngle);
        foundationBrakeForce = CalculateFoundationBrakeForce(MASS, brakePressure, brakeTemperature, maxBrakeTemperature);
        engineBrakeForce = CalculateEngineBrakeForce(gear, ENGINE_BRAKE_CONSTANT, GEAR_COEFFICIENTS);

        acceleration = CalculateAcceleration(MASS, gravityForce, foundationBrakeForce, engineBrakeForce);
        
        % Add current state to historical state
        times = [times time];
        positions = [positions position];
        velocities = [velocities velocity];
        brakePressures = [brakePressures brakePressure];
        gears = [gears gear];
        brakeTemperatures = [brakeTemperatures brakeTemperature];
        
        % Get input from neural network
        networkInput = [
            velocity / maxVelocity;
            slopeAngle / MAX_SLOPE_ANGLE;
            brakeTemperature / maxBrakeTemperature;
        ];
        networkOutput = RunNeuralNetwork(network, networkInput);
        brakePressure = networkOutput(1);
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

        % Calculate next brake temperature
        deltaBrakeTemperature = GetNextDeltaBrakeTemperature(brakePressure, deltaBrakeTemperature, BRAKE_COOLDOWN_TIME, BRAKE_HEATING_RATE, DELTA_T);
        brakeTemperature = GetNextBrakeTemperature(AMBIENT_BRAKE_TEMPERATURE, deltaBrakeTemperature);
        
        % Check constraints
        if velocity < minVelocity || velocity > maxVelocity || brakeTemperature > maxBrakeTemperature
            break;
        end
        
        % Advance time
        time = time + DELTA_T;

        iIteration = iIteration + 1;
    end
    
    times = [times time];
    positions = [positions position];
    velocities = [velocities velocity];
    brakePressures = [brakePressures brakePressure];
    gears = [gears gear];
    brakeTemperatures = [brakeTemperatures brakeTemperature];
end
