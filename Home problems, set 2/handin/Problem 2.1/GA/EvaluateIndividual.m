function fitness = EvaluateIndividual(path, cityLocations)
    pathLength = GetPathLength(path, cityLocations);
    fitness = 1 / pathLength;
end
