function length = GetNearestNeighbourPathLength(nodeLocations)
    numberOfNodes = size(nodeLocations, 1);
    startNode = RandomIndex(numberOfNodes);
    path = GetNearestNeighbourPath(startNode, nodeLocations);
    length = GetPathLength(path, nodeLocations);
end
