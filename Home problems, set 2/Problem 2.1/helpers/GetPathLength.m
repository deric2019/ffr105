function length = GetPathLength(path, nodeLocations)
    numberOfNodes = size(path, 2);
    
    length = 0;
    
    for i = 1:numberOfNodes - 1
        fromNode = path(i);
        toNode = path(i + 1);
        length = length + DistanceBetweenNodes(fromNode, toNode, nodeLocations);
    end
    
    firstNode = path(1);
    lastNode = path(end);
    length = length + DistanceBetweenNodes(firstNode, lastNode, nodeLocations);
end
