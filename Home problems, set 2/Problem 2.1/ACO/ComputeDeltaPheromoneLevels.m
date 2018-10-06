function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,  pathLengthCollection)
    numberOfPaths = size(pathCollection, 1);
    numberOfNodes = size(pathCollection, 2) - 1;
    
    deltaPheromoneLevel = zeros(numberOfNodes);
    
    for k = 1:numberOfPaths
        path = pathCollection(k, :);
        pathLength = pathLengthCollection(k);
        
        numberOfNodesInPath = size(path, 2);
        traversedEdges = zeros(numberOfNodes);
        
        for i = 1:numberOfNodesInPath - 1
            fromNode = path(i);
            toNode = path(i + 1);
            traversedEdges(fromNode, toNode) = 1;
            traversedEdges(toNode, fromNode) = 1;
        end
        
        for i = 1:numberOfNodes
            for j = i+1:numberOfNodes
                if traversedEdges(i, j) == 1
                    deltaPheromoneLevel(i, j) = deltaPheromoneLevel(i, j) + 1 / pathLength;
                    deltaPheromoneLevel(j, i) = deltaPheromoneLevel(i, j);
                end
            end
        end
    end
end
