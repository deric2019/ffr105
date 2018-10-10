function nextPosition = GetNextPosition(position, velocity, deltaT, slopeAngle)
    nextPosition = position + velocity * deltaT * cosd(slopeAngle);
end
