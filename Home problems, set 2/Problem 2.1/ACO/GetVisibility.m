function visibility = GetVisibility(nodeLocations)
    numberOfNodes = size(nodeLocations, 1);

    visibility = zeros(numberOfNodes);
    
    for i = 1:numberOfNodes
        for j = 1:numberOfNodes
            if i ~= j
                distance = DistanceBetweenNodes(j, i, nodeLocations);
                visibility(i, j) = 1 / distance;
            end
        end
    end
end
