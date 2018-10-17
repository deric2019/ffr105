function force = CalculateGravityForce(mass, slopeAngle)
    gravityConstant = 9.80665;
    force = mass * gravityConstant * sind(slopeAngle);
end
