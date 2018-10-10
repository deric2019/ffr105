clear all;

iDataSet = 1;
iSlope = 1;

% Define parameters
mass = 20000; % kg
ambientBreakTemperature = 283; % K
maxBreakTemperature = 750; % K
breakCooldownTime = 30; % s
breakHeatingRate = 40; % K/s
engineBreakConstant = 3000; % N
maxVelocity = 25; % m/s
minVelocity = 1; % m/s
maxSlopeAngle = 10; % degrees
deltaT = 0.1;

iterations = 1000;

% Define initial values
initialPosition = 0;
initialVelocity = 20; % m/s
initialGear = 7;
initialBreakTemperature = 500; % K
breakPressure = 0.2;

% Define variables for keeping track of state
position = initialPosition;
velocity = initialVelocity;
gear = initialGear;
breakTemperature = initialBreakTemperature;
deltaBreakTemperature = 1;
time = 0;

% Run through simulation
for iIteration = 1:iterations
    % Advance time
    time = time + deltaT;
    
    % Get slope angle for current position
    slopeAngle = GetSlopeAngle(position, iSlope, iDataSet);
    
    % Calculate acceleration in current position
    gravityForce = CalculateGravityForce(mass, slopeAngle);
    foundationBreakForce = CalculateFoundationBreakForce(mass, breakPressure, breakTemperature, maxBreakTemperature);
    engineBreakForce = CalculateEngineBreakForce(gear, engineBreakConstant);
    
    acceleration = CalculateAcceleration(mass, gravityForce, foundationBreakForce, engineBreakForce);
    
    % Print current state
    fprintf('t = %.1f: x = %.3f, v = %.3f, a = %.3f, Tb = %.3f\n', time, position, velocity, acceleration, breakTemperature);
    
    % Calculate next position
    position = GetNextPosition(position, velocity, deltaT, slopeAngle);
    
    % Calculate next velocity
    velocity = GetNextVelocity(velocity, acceleration, deltaT);
    
    % Calculate next break temperature
    deltaBreakTemperature = GetNextDeltaBreakTemperature(breakPressure, deltaBreakTemperature, breakCooldownTime, breakHeatingRate, deltaT);
    breakTemperature = GetNextBreakTemperature(ambientBreakTemperature, deltaBreakTemperature);
end
