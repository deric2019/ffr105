function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    numberOfNodes = size(pheromoneLevel, 1);
    
    edgeWeights = CalculateEdgeWeights(numberOfNodes, pheromoneLevel, visibility, alpha, beta);
    
    % numberOfNodes + 1 is needed since we add the starting node to the end
    % of the path when we're done.
    path = zeros(1, numberOfNodes + 1);

    % The tabu list is represented as a vector of 1s and 0s of length N,
    % where a 1 at index i indicates that node i is on the tabu list.
    % This allows for faster lookups compared to using a list that contains
    % the visited nodes in order.
    tabuList = zeros(1, numberOfNodes);

    startNode = RandomIndex(numberOfNodes);
    path(1) = startNode;
    tabuList(startNode) = 1;
    
    for i = 2:numberOfNodes
        currentNode = path(i - 1);
        node = GetNextNode(numberOfNodes, currentNode, tabuList, edgeWeights);
        path(i) = node;
        tabuList(node) = 1;
    end
    
    path(end) = startNode;
end

function edgeWeights = CalculateEdgeWeights(numberOfNodes, pheromoneLevel, visibility, alpha, beta)
    edgeWeights = zeros(numberOfNodes);
    
    for i = 1:numberOfNodes
        for j = 1+1:numberOfNodes
            tau = pheromoneLevel(i, j);
            eta = visibility(i, j);
            weight = tau^alpha * eta^beta;
            edgeWeights(i, j) = weight;
            edgeWeights(j, i) = weight;
        end
    end
end

function node = GetNextNode(numberOfNodes, currentNode, tabuList, edgeWeights)
    probabilities = CalculateProbabilities(numberOfNodes, currentNode, tabuList, edgeWeights);
    node = randsample(1:numberOfNodes, 1, true, probabilities);
end

function probabilities = CalculateProbabilities(numberOfNodes, currentNode, tabuList, edgeWeights)
    nonTabuWeights = zeros(1, numberOfNodes);
    totalWeight = 0;
    
    j = currentNode;

    for i = 1:numberOfNodes
        isTabu = tabuList(i) == 1;
        
        if ~isTabu
            edgeWeight = edgeWeights(i, j);
            nonTabuWeights(i) = edgeWeight;
            totalWeight = totalWeight + edgeWeight;
        end
    end
    
    probabilities = nonTabuWeights / totalWeight;
end
