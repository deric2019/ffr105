function fitness = EvaluatePath(path, cityLocations)
    pathLength = PathLength(path, cityLocations);
    fitness = 1 / pathLength;
end
