function visibility = GetVisibility(nodeLocations)
    numberOfNodes = size(nodeLocations, 1);

    visibility = zeros(numberOfNodes);
    
    for i = 1:numberOfNodes
        for j = i+1:numberOfNodes
            distance = DistanceBetweenNodes(i, j, nodeLocations);
            visibilityValue = 1 / distance;
            visibility(i, j) = visibilityValue;
            visibility(j, i) = visibilityValue;
        end
    end
end
