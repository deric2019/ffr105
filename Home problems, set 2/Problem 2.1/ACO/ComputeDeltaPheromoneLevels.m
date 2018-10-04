function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,  pathLengthCollection)
    numberOfPaths = size(pathCollection, 1);
    numberOfNodes = size(pathCollection(1, :), 2);
    
    deltaPheromoneLevel = zeros(numberOfNodes);

    for i = 1:numberOfNodes
        for j = 1:numberOfNodes
            delta = 0;
            
            for k = 1:numberOfPaths
                path = pathCollection(k, :);
            
                if ContainsEdge(path, j, i)
                    pathLength = pathLengthCollection(k);
                    delta = delta + 1 / pathLength;
                end
            end
            
            deltaPheromoneLevel(i, j) = delta;
        end
    end
end

function containsEdge = ContainsEdge(path, fromNode, toNode)
    numberOfEdges = size(path, 2);

    for k = 1:numberOfEdges - 1
        if fromNode == path(k) && toNode == path(k + 1)
            containsEdge = true;
            return;
        end
    end
    
    containsEdge = false;
end
