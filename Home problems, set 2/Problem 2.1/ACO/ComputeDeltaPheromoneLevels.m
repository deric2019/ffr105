function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,  pathLengthCollection)
    numberOfPaths = size(pathCollection, 1);
    numberOfNodes = size(pathCollection, 2) - 1;
    
    deltaPheromoneLevel = zeros(numberOfNodes);

    for i = 1:numberOfNodes
        for j = i+1:numberOfNodes
            delta = 0;
            
            for k = 1:numberOfPaths
                path = pathCollection(k, :);
            
                if ContainsEdge(path, i, j)
                    pathLength = pathLengthCollection(k);
                    delta = delta + 1 / pathLength;
                end
            end
            
            deltaPheromoneLevel(i, j) = delta;
            deltaPheromoneLevel(j, i) = delta;
        end
    end
end

function containsEdge = ContainsEdge(path, i, j)
    numberOfEdgesInPath = size(path, 2) - 1;

    for k = 1:numberOfEdgesInPath
        if i == path(k) && j == path(k + 1) || j == path(k) && i == path(k + 1)
            containsEdge = true;
            return;
        end
    end
    
    containsEdge = false;
end
