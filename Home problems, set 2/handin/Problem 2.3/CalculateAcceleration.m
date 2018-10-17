function acceleration = CalculateAcceleration(mass, gravityForce, foundationBrakeForce, engineBrakeForce)
    acceleration = (gravityForce - foundationBrakeForce - engineBrakeForce) / mass;
end
