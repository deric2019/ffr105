function acceleration = CalculateAcceleration(mass, gravityForce, foundationBreakForce, engineBreakForce)
    acceleration = (gravityForce - foundationBreakForce - engineBreakForce) / mass;
end
