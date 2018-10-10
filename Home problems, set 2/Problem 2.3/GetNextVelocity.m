function nextVelocity = GetNextVelocity(velocity, acceleration, deltaT)
    nextVelocity = velocity + acceleration * deltaT;
end
