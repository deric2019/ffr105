function nearestNeighbourPath = GetNearestNeighbourPath(startNode, nodeLocations)
    numberOfNodes = size(nodeLocations, 1);
    
    nearestNeighbourPath = zeros(1, numberOfNodes + 1);
    nearestNeighbourPath(1) = startNode;

    for i = 2:numberOfNodes
        currentNode = nearestNeighbourPath(i - 1);
        nextNode = GetNearestNeighbour(currentNode, nearestNeighbourPath, nodeLocations);
        nearestNeighbourPath(i) = nextNode;
    end
    
    nearestNeighbourPath(end) = startNode;
end

function nearestNeighbour = GetNearestNeighbour(node, visitedNodes, nodeLocations)
    numberOfCities = size(nodeLocations, 1);
    
    nearestNeighbour = 0;
    nearestNeighbourDistance = inf;
    
    for otherNode = 1:numberOfCities
        if ~ismember(otherNode, visitedNodes)
            distance = DistanceBetweenNodes(node, otherNode, nodeLocations);

            if distance < nearestNeighbourDistance
                nearestNeighbour = otherNode;
                nearestNeighbourDistance = distance;
            end
        end
    end
end
