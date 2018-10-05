function length = GetPathLength(path, nodeLocations)
    numberOfSteps = size(path, 2) - 1;
    
    length = 0;
    
    for i = 1:numberOfSteps
        fromNode = path(i);
        toNode = path(i + 1);
        length = length + DistanceBetweenNodes(fromNode, toNode, nodeLocations);
    end
    
    % If the path doesn't end in the starting city, add the distance from
    % the last visited city to the starting city.
    firstNode = path(1);
    lastNode = path(end);
    if firstNode ~= lastNode
        length = length + DistanceBetweenNodes(firstNode, lastNode, nodeLocations);
    end
end
